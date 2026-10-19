using System;
using System.Collections.Generic;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

[ExecuteInEditMode]
public class HDShadow : MonoBehaviour
{
	public class HDTarget
	{
		public SkinnedMeshRenderer[] skinned;

		internal readonly int registrationId;

		internal readonly int slot;

		internal readonly Transform ownerTransform;

		internal readonly Renderer[] renderers;

		internal readonly Bounds[] localBoundsScratch;

		internal readonly Bounds[] worldBoundsScratch;

		internal readonly Matrix4x4[] localToWorldScratch;

		internal readonly bool[] validRendererScratch;

		internal bool useCustomLightRotation;

		internal Quaternion mainLightRotation;

		public HDTarget()
		{
			registrationId = int.MinValue;
			slot = -1;
			ownerTransform = null;
			renderers = Array.Empty<Renderer>();
			skinned = Array.Empty<SkinnedMeshRenderer>();
			localBoundsScratch = Array.Empty<Bounds>();
			worldBoundsScratch = Array.Empty<Bounds>();
			localToWorldScratch = Array.Empty<Matrix4x4>();
			validRendererScratch = Array.Empty<bool>();
			useCustomLightRotation = false;
			mainLightRotation = Quaternion.identity;
		}

		internal HDTarget(int registrationId, int slot, Transform ownerTransform, Renderer[] renderers, SkinnedMeshRenderer[] skinned)
		{
			this.registrationId = registrationId;
			this.slot = slot;
			this.ownerTransform = ownerTransform;
			this.renderers = renderers;
			this.skinned = skinned;
			localBoundsScratch = new Bounds[renderers.Length];
			worldBoundsScratch = new Bounds[renderers.Length];
			localToWorldScratch = new Matrix4x4[renderers.Length];
			validRendererScratch = new bool[renderers.Length];
			useCustomLightRotation = false;
			mainLightRotation = Quaternion.identity;
		}
	}

	public const int CharacterShadowSlotCount = 4;

	public const int CharacterShadowBitOffset = 8;

	public const uint CharacterShadowSlotMask = 3840u;

	private static readonly HDTarget[] s_Targets = new HDTarget[4];

	private static readonly int s_CharacterMainLightDirectionOverride = Shader.PropertyToID("_CharacterMainLightDirectionOverride");

	public static List<HDTarget> HDTargetList = new List<HDTarget>(4);

	[NonSerialized]
	public HDTarget target = new HDTarget();

	[NonSerialized]
	private CharacterRenderingRegistry.Registration m_Registration;

	[NonSerialized]
	private HDTarget m_LegacyTarget;

	[NonSerialized]
	private MaterialPropertyBlock m_PropertyBlock;

	[NonSerialized]
	private List<Material> m_SharedMaterials;

	[InspectorName("使用角色主光")]
	[FormerlySerializedAs("m_RequiresSpecialCharacterLayer")]
	[Tooltip("注册该角色使用独立主光方向，并使角色不接收场景主光阴影。场景主光 ShadowCaster 的排除仍由角色 Layer 配置保证。")]
	[SerializeField]
	private bool m_UseCharacterMainLight;

	[InspectorName("启用 HD Shadow")]
	[Tooltip("申请 HD Shadow 槽位。使用角色主光时复用角色方向，否则保持旧逻辑并默认使用场景主光方向。")]
	[SerializeField]
	private bool m_EnableHDShadow = true;

	[InspectorName("角色主光旋转")]
	[SerializeField]
	[FormerlySerializedAs("m_CustomLightEulerAngles")]
	[Tooltip("使用与 Unity Directional Light Transform 相同的 Euler 旋转约定；Transform.forward 是光线传播方向。")]
	private Vector3 m_MainLightEulerAngles;

	public bool useCharacterMainLight
	{
		get
		{
			return m_UseCharacterMainLight;
		}
		set
		{
			if (m_UseCharacterMainLight != value)
			{
				m_UseCharacterMainLight = value;
				if (isActiveAndEnabled)
				{
					Register();
				}
			}
		}
	}

	public bool enableHDShadow
	{
		get
		{
			return m_EnableHDShadow;
		}
		set
		{
			if (m_EnableHDShadow != value)
			{
				m_EnableHDShadow = value;
				if (isActiveAndEnabled)
				{
					Register();
				}
			}
		}
	}

	internal static HDTarget GetTarget(int slot)
	{
		if ((uint)slot >= 4u)
		{
			return null;
		}
		return s_Targets[slot];
	}

	public void SetMainLightRotation(Quaternion rotation)
	{
		m_MainLightEulerAngles = rotation.eulerAngles;
		if (isActiveAndEnabled && m_UseCharacterMainLight)
		{
			Register();
		}
	}

	public void SetCustomLightRotation(bool enabled, Quaternion rotation)
	{
		HDTarget hDTarget = m_Registration?.Target ?? m_LegacyTarget;
		if (hDTarget != null)
		{
			hDTarget.useCustomLightRotation = enabled;
			hDTarget.mainLightRotation = rotation;
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void ResetTargets()
	{
		HDShadow[] array = Object.FindObjectsOfType<HDShadow>(includeInactive: true);
		for (int i = 0; i < array.Length; i++)
		{
			array[i].Unregister();
		}
		CharacterRenderingRegistry.Reset();
		for (int j = 0; j < 4; j++)
		{
			s_Targets[j] = null;
		}
		HDTargetList.Clear();
		foreach (HDShadow hDShadow in array)
		{
			if (hDShadow != null && hDShadow.isActiveAndEnabled)
			{
				hDShadow.Register();
			}
		}
	}

	private void OnEnable()
	{
		Register();
	}

	private void OnDisable()
	{
		Unregister();
	}

	private void OnDestroy()
	{
		Unregister();
	}

	private void OnValidate()
	{
		if (isActiveAndEnabled)
		{
			Register();
		}
	}

	private void OnTransformChildrenChanged()
	{
		RefreshRenderers();
	}

	public void RefreshRenderers()
	{
		if (!isActiveAndEnabled)
		{
			return;
		}
		if (m_UseCharacterMainLight)
		{
			if (m_Registration == null)
			{
				Register();
				return;
			}
			ClearRendererMainLightProperties();
			CharacterRenderingRegistry.RefreshRenderers(m_Registration);
			SynchronizePublicTarget();
			ApplyRendererMainLightProperties();
			return;
		}
		if (m_LegacyTarget != null)
		{
			UnregisterTarget(m_LegacyTarget);
		}
		m_LegacyTarget = null;
		if (m_EnableHDShadow)
		{
			m_LegacyTarget = RegisterTarget(GetInstanceID(), gameObject);
		}
		SynchronizePublicTarget();
	}

	private void Register()
	{
		if (m_UseCharacterMainLight)
		{
			RegisterCharacterMainLight();
		}
		else
		{
			RegisterLegacyHDShadow();
		}
	}

	private void RegisterCharacterMainLight()
	{
		if (m_LegacyTarget != null)
		{
			UnregisterTarget(m_LegacyTarget);
			m_LegacyTarget = null;
		}
		if (m_Registration == null)
		{
			m_Registration = CharacterRenderingRegistry.Register(gameObject, BuildRegistrationSettings());
		}
		else
		{
			CharacterRenderingRegistry.Configure(m_Registration, BuildRegistrationSettings());
		}
		SynchronizePublicTarget();
		ApplyRendererMainLightProperties();
	}

	private void RegisterLegacyHDShadow()
	{
		if (m_Registration != null)
		{
			ClearRendererMainLightProperties();
			CharacterRenderingRegistry.Unregister(m_Registration);
			m_Registration = null;
		}
		if (!m_EnableHDShadow)
		{
			if (m_LegacyTarget != null)
			{
				UnregisterTarget(m_LegacyTarget);
			}
			m_LegacyTarget = null;
			SynchronizePublicTarget();
		}
		else
		{
			if (m_LegacyTarget == null)
			{
				m_LegacyTarget = RegisterTarget(GetInstanceID(), gameObject);
			}
			SynchronizePublicTarget();
		}
	}

	internal static HDTarget RegisterTarget(int registrationId, GameObject owner)
	{
		int num = FindFreeSlot();
		if (num < 0)
		{
			return null;
		}
		Renderer[] componentsInChildren = owner.GetComponentsInChildren<Renderer>(includeInactive: true);
		int num2 = 0;
		int num3 = 0;
		foreach (Renderer renderer in componentsInChildren)
		{
			if (renderer is SkinnedMeshRenderer || renderer is MeshRenderer)
			{
				num2++;
			}
			if (renderer is SkinnedMeshRenderer)
			{
				num3++;
			}
		}
		if (num2 == 0)
		{
			return null;
		}
		Renderer[] array = new Renderer[num2];
		SkinnedMeshRenderer[] array2 = new SkinnedMeshRenderer[num3];
		uint num4 = (uint)(1 << 8 + num);
		int num5 = 0;
		int num6 = 0;
		foreach (Renderer renderer2 in componentsInChildren)
		{
			if (renderer2 is SkinnedMeshRenderer || renderer2 is MeshRenderer)
			{
				if (renderer2 is SkinnedMeshRenderer skinnedMeshRenderer)
				{
					array2[num6++] = skinnedMeshRenderer;
				}
				uint renderingLayerMask = renderer2.renderingLayerMask;
				array[num5] = renderer2;
				renderer2.renderingLayerMask = (renderingLayerMask & 0xFFFFF0FFu) | num4;
				num5++;
			}
		}
		HDTarget hDTarget = new HDTarget(registrationId, num, owner.transform, array, array2);
		s_Targets[num] = hDTarget;
		HDTargetList.Add(hDTarget);
		return hDTarget;
	}

	private void Unregister()
	{
		if (m_Registration != null || m_UseCharacterMainLight)
		{
			ClearRendererMainLightProperties();
		}
		CharacterRenderingRegistry.Unregister(m_Registration);
		m_Registration = null;
		if (m_LegacyTarget != null)
		{
			UnregisterTarget(m_LegacyTarget);
		}
		m_LegacyTarget = null;
		target = new HDTarget();
		ClearCharacterShadowSlotBits(gameObject);
	}

	private CharacterRenderingRegistry.Settings BuildRegistrationSettings()
	{
		return new CharacterRenderingRegistry.Settings
		{
			enableHDShadow = m_EnableHDShadow,
			mainLightRotation = Quaternion.Euler(m_MainLightEulerAngles)
		};
	}

	private void SynchronizePublicTarget()
	{
		target = m_Registration?.Target ?? m_LegacyTarget ?? new HDTarget();
	}

	private void ApplyRendererMainLightProperties()
	{
		if (m_Registration != null)
		{
			Vector3 vector = -(Quaternion.Euler(m_MainLightEulerAngles) * Vector3.forward);
			SetRendererMainLightProperties(m_Registration.Renderers, new Vector4(vector.x, vector.y, vector.z, 1f));
		}
	}

	private void ClearRendererMainLightProperties()
	{
		if (m_Registration != null)
		{
			SetRendererMainLightProperties(m_Registration.Renderers, Vector4.zero);
			return;
		}
		Renderer[] componentsInChildren = gameObject.GetComponentsInChildren<Renderer>(includeInactive: true);
		SetRendererMainLightProperties(componentsInChildren, Vector4.zero);
	}

	private void SetRendererMainLightProperties(Renderer[] renderers, Vector4 directionOverride)
	{
		if (renderers == null || renderers.Length == 0)
		{
			return;
		}
		if (m_PropertyBlock == null)
		{
			m_PropertyBlock = new MaterialPropertyBlock();
		}
		foreach (Renderer renderer in renderers)
		{
			if (!(renderer is SkinnedMeshRenderer) && !(renderer is MeshRenderer))
			{
				continue;
			}
			m_PropertyBlock.Clear();
			renderer.GetPropertyBlock(m_PropertyBlock);
			m_PropertyBlock.SetVector(s_CharacterMainLightDirectionOverride, directionOverride);
			renderer.SetPropertyBlock(m_PropertyBlock);
			if (m_SharedMaterials == null)
			{
				m_SharedMaterials = new List<Material>(4);
			}
			m_SharedMaterials.Clear();
			renderer.GetSharedMaterials(m_SharedMaterials);
			for (int j = 0; j < m_SharedMaterials.Count; j++)
			{
				m_PropertyBlock.Clear();
				renderer.GetPropertyBlock(m_PropertyBlock, j);
				if (!m_PropertyBlock.isEmpty)
				{
					m_PropertyBlock.SetVector(s_CharacterMainLightDirectionOverride, directionOverride);
					renderer.SetPropertyBlock(m_PropertyBlock, j);
				}
			}
		}
	}

	internal static void UnregisterTarget(HDTarget target)
	{
		if (target != null)
		{
			if (s_Targets[target.slot] == target)
			{
				s_Targets[target.slot] = null;
			}
			HDTargetList.Remove(target);
			ClearCharacterShadowSlotBits(target.renderers);
		}
	}

	internal static void ClearCharacterShadowSlotBits(Renderer[] renderers)
	{
		foreach (Renderer renderer in renderers)
		{
			if (!(renderer == null))
			{
				renderer.renderingLayerMask &= 4294963455u;
			}
		}
	}

	private static void ClearCharacterShadowSlotBits(GameObject owner)
	{
		if (owner == null)
		{
			return;
		}
		Renderer[] componentsInChildren = owner.GetComponentsInChildren<Renderer>(includeInactive: true);
		foreach (Renderer renderer in componentsInChildren)
		{
			if (renderer is SkinnedMeshRenderer || renderer is MeshRenderer)
			{
				renderer.renderingLayerMask &= 4294963455u;
			}
		}
	}

	private static int FindFreeSlot()
	{
		for (int i = 0; i < 4; i++)
		{
			if (s_Targets[i] == null)
			{
				return i;
			}
		}
		return -1;
	}
}
