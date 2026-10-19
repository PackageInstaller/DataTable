using System.Collections.Generic;
using UnityEngine.Scripting.APIUpdating;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

[DisallowMultipleComponent]
[MovedFrom(true, "UnityEngine.Rendering.Universal", "Unity.RenderPipelines.Universal.Runtime", "DeferredReflectionProbeSceneRegistry")]
[ExecuteAlways]
public sealed class DeferredSceneLightingRegistry : MonoBehaviour
{
	[SerializeField]
	private DeferredReflectionProbeSceneData m_SceneData;

	[FormerlySerializedAs("m_BakeryVolumeL1Texture0")]
	[SerializeField]
	[Header("Volume GI")]
	private Texture3D m_VolumeGIL1Texture0;

	[SerializeField]
	[FormerlySerializedAs("m_BakeryVolumeL1Texture1")]
	private Texture3D m_VolumeGIL1Texture1;

	[SerializeField]
	[FormerlySerializedAs("m_BakeryVolumeL1Texture2")]
	private Texture3D m_VolumeGIL1Texture2;

	[SerializeField]
	[FormerlySerializedAs("m_BakeryVolumeBounds")]
	private Bounds m_VolumeGIBounds = new Bounds(Vector3.zero, Vector3.one);

	[Header("Shadow Mask")]
	[Tooltip("true: Shadow mask 数据打包在 lightmap 的 R 通道（历史 Mask-only 资源）；false: 完整 ACT 合图，从 A 通道读取，且无 Lightmap 物体在 GBuffer 采样 Volume GI。")]
	[SerializeField]
	private bool m_ShadowMaskInRed;

	[Header("Volume 外回退 SH")]
	[Tooltip("勾选：Volume 外回退使用 Bakery 烘焙数据合成的场景 SH；不勾选：使用 Unity Lighting 配置的环境光 SH（默认）。")]
	[HideInInspector]
	[SerializeField]
	private bool m_UseBakerySceneSH;

	[SerializeField]
	[HideInInspector]
	private Vector4 m_SceneBakerySH0 = new Vector4(0f, 0f, 0f, 0f);

	[HideInInspector]
	[SerializeField]
	private Vector4 m_SceneBakerySH1;

	[HideInInspector]
	[SerializeField]
	private Vector4 m_SceneBakerySH2;

	[SerializeField]
	[HideInInspector]
	private Vector4 m_SceneBakerySH3;

	private static readonly List<DeferredSceneLightingRegistry> s_ActiveRegistries = new List<DeferredSceneLightingRegistry>(2);

	private static bool s_InvalidDataWarningIssued;

	public bool shadowMaskInRed => m_ShadowMaskInRed;

	public bool useBakerySceneSH => m_UseBakerySceneSH;

	public DeferredReflectionProbeSceneData sceneData => m_SceneData;

	internal static bool GetActiveUseBakerySceneSH()
	{
		if (TryGetActiveLightingRegistry(out var registry))
		{
			return ProvidesSceneBakerySH(registry);
		}
		return false;
	}

	internal static bool TryGetActiveSceneBakerySH(out Vector4 l0, out Vector4 l1x, out Vector4 l1y, out Vector4 l1z)
	{
		l0 = Vector4.zero;
		l1x = Vector4.zero;
		l1y = Vector4.zero;
		l1z = Vector4.zero;
		if (!TryGetActiveLightingRegistry(out var registry) || !ProvidesSceneBakerySH(registry))
		{
			return false;
		}
		l0 = registry.m_SceneBakerySH0;
		l1x = registry.m_SceneBakerySH1;
		l1y = registry.m_SceneBakerySH2;
		l1z = registry.m_SceneBakerySH3;
		return l0.w > 0.5f;
	}

	private void OnEnable()
	{
		if (!s_ActiveRegistries.Contains(this))
		{
			s_ActiveRegistries.Add(this);
		}
		ResetWarnings();
	}

	private void OnDisable()
	{
		s_ActiveRegistries.Remove(this);
		ResetWarnings();
	}

	internal static bool TryGetActiveData(out DeferredReflectionProbeSceneData data)
	{
		if (!TryGetActiveLightingRegistry(out var registry) || registry.m_SceneData == null)
		{
			data = null;
			return false;
		}
		data = registry.m_SceneData;
		return data.HasResources();
	}

	public static bool HasCompleteSurfaceLightmap()
	{
		return HasCompleteSurfaceLightmap(LightmapSettings.lightmaps);
	}

	internal static bool HasCompleteSurfaceLightmap(LightmapData[] lightmaps)
	{
		if (lightmaps == null)
		{
			return false;
		}
		foreach (LightmapData lightmapData in lightmaps)
		{
			if (lightmapData != null && !(lightmapData.lightmapColor == null) && lightmapData.lightmapColor != lightmapData.shadowMask)
			{
				return true;
			}
		}
		return false;
	}

	internal static bool GetShadowMaskInRed()
	{
		RemoveInvalidRegistries();
		for (int i = 0; i < s_ActiveRegistries.Count; i++)
		{
			if (s_ActiveRegistries[i].m_ShadowMaskInRed)
			{
				return true;
			}
		}
		return false;
	}

	internal static bool TryGetActiveVolumeGIL1(out Texture3D texture0, out Texture3D texture1, out Texture3D texture2, out Bounds bounds)
	{
		texture0 = null;
		texture1 = null;
		texture2 = null;
		bounds = default;
		if (!TryGetActiveLightingRegistry(out var registry))
		{
			return false;
		}
		texture0 = registry.m_VolumeGIL1Texture0;
		texture1 = registry.m_VolumeGIL1Texture1;
		texture2 = registry.m_VolumeGIL1Texture2;
		bounds = registry.m_VolumeGIBounds;
		if (texture0 != null && texture1 != null)
		{
			return texture2 != null;
		}
		return false;
	}

	public static DeferredSceneLightingRegistry GetActiveLightingRegistry()
	{
		TryGetActiveLightingRegistry(out var registry);
		return registry;
	}

	private static bool TryGetActiveLightingRegistry(out DeferredSceneLightingRegistry registry)
	{
		RemoveInvalidRegistries();
		registry = null;
		float num = float.PositiveInfinity;
		for (int i = 0; i < s_ActiveRegistries.Count; i++)
		{
			DeferredSceneLightingRegistry deferredSceneLightingRegistry = s_ActiveRegistries[i];
			if (ProvidesLightingData(deferredSceneLightingRegistry))
			{
				float boundsVolume = GetBoundsVolume(deferredSceneLightingRegistry.m_VolumeGIBounds);
				bool flag = boundsVolume < num;
				bool flag2 = Mathf.Approximately(boundsVolume, num) && (registry == null || deferredSceneLightingRegistry.GetInstanceID() < registry.GetInstanceID());
				if (flag || flag2)
				{
					registry = deferredSceneLightingRegistry;
					num = boundsVolume;
				}
			}
		}
		return registry != null;
	}

	private static bool ProvidesLightingData(DeferredSceneLightingRegistry registry)
	{
		if (registry.m_SceneData != null)
		{
			return true;
		}
		if (registry.m_VolumeGIL1Texture0 != null && registry.m_VolumeGIL1Texture1 != null && registry.m_VolumeGIL1Texture2 != null)
		{
			return true;
		}
		return false;
	}

	private static bool ProvidesSceneBakerySH(DeferredSceneLightingRegistry registry)
	{
		if (registry.m_UseBakerySceneSH)
		{
			return registry.m_SceneBakerySH0.w > 0.5f;
		}
		return false;
	}

	private static float GetBoundsVolume(Bounds bounds)
	{
		Vector3 size = bounds.size;
		return Mathf.Abs(size.x * size.y * size.z);
	}

	private static void RemoveInvalidRegistries()
	{
		bool flag = false;
		for (int num = s_ActiveRegistries.Count - 1; num >= 0; num--)
		{
			if (s_ActiveRegistries[num] == null || !s_ActiveRegistries[num].isActiveAndEnabled)
			{
				s_ActiveRegistries.RemoveAt(num);
				flag = true;
			}
		}
		if (flag)
		{
			ResetWarnings();
		}
	}

	private static void ResetWarnings()
	{
		s_InvalidDataWarningIssued = false;
	}
}
