using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Serialization;

namespace ACT.Battle;

public class MonoEntity : MonoBehaviour, IColliderEntityRef
{
	public EntityId id;

	public Entity entity;

	public SonCollider[] sonColliders;

	public AttachPoint[] attachPoints;

	public MonoBodyPart[] bodyParts;

	public WeaponPart[] weaponParts;

	public MixedPart[] MixedParts;

	public AniPartControl aniControl;

	public LineRenderPart[] lineRenderParts;

	public Transform[] switchSkillPoints;

	public GameObject[] shadowColliders;

	[NonSerialized]
	[Obsolete]
	public List<AniPartControl> aniControls = new List<AniPartControl>();

	[NonSerialized]
	public GameObject weaponModel;

	public BodyPartPriorityHitEffect[] priorityHitEffect;

	public MonoMagicaCloth monoMagicaCloth;

	public MaterialOverride materialOverride;

	public ActBehaviorTree btree;

	public NavMeshAgent agent;

	[FormerlySerializedAs("weapon1")]
	public WeaponPartAttach[] weaponAttachs;

	public Renderer[] renderers;

	protected Material[][] m_mats;

	private int m_CurWeapon = -1;

	protected List<MaterialPreset> m_MatQueue = new List<MaterialPreset>();

	protected MaterialPreset m_CurrentMat = MaterialPreset.Origin;

	protected Collider myCollider;

	private Bounds m_SonColliderBounds;

	private Vector3 m_sonCollidersCenterOffset = Vector3.zero;

	public int curWeapon
	{
		get
		{
			return m_CurWeapon;
		}
		set
		{
			m_CurWeapon = value;
		}
	}

	public Bounds SonColliderBounds
	{
		get
		{
			if (!(m_SonColliderBounds.size == Vector3.zero))
			{
				return m_SonColliderBounds;
			}
			return InitSonColliderBounds();
		}
		set
		{
			m_SonColliderBounds = value;
		}
	}

	public Vector3 SonCollidersCenterOffset => m_sonCollidersCenterOffset;

	public event Action<Entity> onDisable;

	public event Action<Entity> onDestroy;

	private void Start()
	{
		if (myCollider == null)
		{
			myCollider = GetComponent<Collider>();
		}
		if (renderers != null)
		{
			m_mats = new Material[renderers.Length][];
			for (int i = 0; i < renderers.Length; i++)
			{
				m_mats[i] = renderers[i].materials;
			}
		}
	}

	private void OnDestroy()
	{
		RemoveEntityRef();
		if (m_mats != null)
		{
			Material[][] mats = m_mats;
			foreach (Material[] array in mats)
			{
				for (int j = 0; j < array.Length; j++)
				{
					UnityEngine.Object.Destroy(array[j]);
				}
			}
		}
		onDestroy?.Invoke(entity);
	}

	public void SetEB(Entity eb)
	{
		entity = eb;
		id = eb.Id;
		if (bodyParts != null)
		{
			for (int i = 0; i < bodyParts.Length; i++)
			{
				MonoBodyPart obj = bodyParts[i];
				obj.entity = entity;
				obj.index = (byte)(i + 1);
				obj.SetRuntimeActive(!obj.parryOnly);
			}
		}
		if (sonColliders != null && sonColliders.Length != 0)
		{
			for (int j = 0; j < sonColliders.Length; j++)
			{
				sonColliders[j].entity = entity;
				bool defaultActive = sonColliders[j].defaultActive;
				sonColliders[j].gameObject.SafeSetActive(defaultActive);
			}
		}
		if (lineRenderParts != null)
		{
			CompAim compAim = eb.GetCompAim();
			for (int k = 0; k < lineRenderParts.Length; k++)
			{
				if (TryGetAttachPoint(lineRenderParts[k].muzzleAttachPointName, out var attackPoint))
				{
					lineRenderParts[k].monoLineRender.start = attackPoint;
					if (!(lineRenderParts[k].name != "aimIKUsed"))
					{
						compAim.transformLine = lineRenderParts[k].monoLineRender;
					}
				}
			}
		}
		BindCharacter();
	}

	public void ControlShadowCollider(bool active)
	{
		if (shadowColliders != null && shadowColliders.Length != 0)
		{
			for (int i = 0; i < shadowColliders.Length; i++)
			{
				shadowColliders[i].SafeSetActive(active);
			}
		}
	}

	public Vector3 GetAttachPointPosition(string name)
	{
		AttachPoint[] array = attachPoints;
		for (int i = 0; i < array.Length; i++)
		{
			AttachPoint attachPoint = array[i];
			if (attachPoint.key.Equals(name, StringComparison.Ordinal))
			{
				return attachPoint.transform.position;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但并未配置！");
		}
		return Vector3.zero;
	}

	public Transform GetAttachPoint(string name)
	{
		if (attachPoints == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但attachPoints未配置！");
			}
			return null;
		}
		AttachPoint[] array = attachPoints;
		for (int i = 0; i < array.Length; i++)
		{
			AttachPoint attachPoint = array[i];
			if (attachPoint.key == name)
			{
				return attachPoint.transform;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但并未配置！");
		}
		return null;
	}

	public bool TryGetAttachPoint(string name, out Transform attackPoint)
	{
		if (attachPoints != null && attachPoints.Length != 0)
		{
			AttachPoint[] array = attachPoints;
			for (int i = 0; i < array.Length; i++)
			{
				AttachPoint attachPoint = array[i];
				if (attachPoint.key == name)
				{
					attackPoint = attachPoint.transform;
					return true;
				}
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但并未配置！");
		}
		attackPoint = null;
		return false;
	}

	public AttachPoint GetAttachPointAll(string name)
	{
		if (attachPoints == null)
		{
			return new AttachPoint
			{
				transform = transform,
				forward = transform
			};
		}
		AttachPoint[] array = attachPoints;
		for (int i = 0; i < array.Length; i++)
		{
			AttachPoint result = array[i];
			if (result.key == name)
			{
				return result;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但并未配置！");
		}
		return default;
	}

	public bool TryGetAttachPointAll(string name, out AttachPoint attachPoint)
	{
		bool flag = false;
		attachPoint = default;
		if (attachPoints == null)
		{
			attachPoint = new AttachPoint
			{
				transform = transform,
				forward = transform
			};
		}
		else
		{
			AttachPoint[] array = attachPoints;
			for (int i = 0; i < array.Length; i++)
			{
				AttachPoint attachPoint2 = array[i];
				if (attachPoint2.key == name)
				{
					attachPoint = attachPoint2;
					flag = true;
					break;
				}
			}
		}
		if (!flag && LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的AttachPoint,但并未配置！");
		}
		return flag;
	}

	public WeaponPart GetWeaponPart(string name)
	{
		WeaponPart[] array = weaponParts;
		for (int i = 0; i < array.Length; i++)
		{
			WeaponPart result = array[i];
			if (result.name == name)
			{
				return result;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的WeaponPart,但并未配置！");
		}
		return default;
	}

	public MixedPart GetMixedPart(string name)
	{
		MixedPart[] mixedParts = MixedParts;
		for (int i = 0; i < mixedParts.Length; i++)
		{
			MixedPart result = mixedParts[i];
			if (result.name == name)
			{
				return result;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"尝试获取{entity}的名为{name}的MixePart,但并未配置！");
		}
		return default;
	}

	public Bounds InitSonColliderBounds()
	{
		if (sonColliders == null || sonColliders.Length == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("No sonColliders assigned!");
			}
			return default;
		}
		List<Collider> list = new List<Collider>();
		for (int i = 0; i < sonColliders.Length; i++)
		{
			Collider component = sonColliders[i].GetComponent<Collider>();
			if (component != null)
			{
				list.Add(component);
			}
		}
		if (list.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("No valid sonColliders found!");
			}
			return default;
		}
		Bounds bounds = list[0].bounds;
		for (int j = 1; j < list.Count; j++)
		{
			bounds.Encapsulate(list[j].bounds);
		}
		m_SonColliderBounds = bounds;
		m_sonCollidersCenterOffset = bounds.center - entity.GetCompTransform().physicsPosition;
		m_sonCollidersCenterOffset *= (float)(entity.IsFaceRight() ? 1 : (-1));
		return bounds;
	}

	public MonoEntity GetMonoEntity()
	{
		return this;
	}

	public (bool, FindTargetResult) FindResult(Vector3 anchor, Vector3 touchForward)
	{
		if (!entity.IsGot())
		{
			return (false, default);
		}
		Vector3 center = (myCollider ?? GetComponentInParent<Collider>()).bounds.center;
		FindTargetResult item = FindTargetResult.MonoEntity(entity, (anchor - center).sqrMagnitude, center, touchForward, myCollider);
		return (true, item);
	}

	public void RemoveEntityRef()
	{
		if (myCollider != null)
		{
			PhysicsUtility.RemoveEntityRef(myCollider);
		}
	}

	private void OnDisable()
	{
		onDisable?.Invoke(entity);
	}

	private void BindCharacter()
	{
		MonoDestinyEffect component = GetComponent<MonoDestinyEffect>();
		if ((bool)component)
		{
			component.Binding(entity);
		}
	}
}
