using ACT.MultiPlayer;
using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AdsorbWall : MonoTriggerEvent, ITrigger
{
	[HideInInspector]
	public FaceDir wallFaceDir;

	[Header("trigger")]
	public BoxCollider box;

	[Header("是否需要跟随移动")]
	public bool isMove;

	[Header("跟随的运动物体的rigidbody")]
	public Rigidbody rig;

	[Header("最低点位置")]
	public Transform bottomTrans;

	[Header("最高点位置")]
	public Transform topTrans;

	public GameObject prefab;

	private Vector3 m_PathNormal;

	private float m_PathMagnitude;

	private MaterialPropertyBlock m_MaterialPropertyBlock;

	[ColorUsage(true, true)]
	public Color defaultColor = new Color(0.1568628f, 0.1686275f, 191f / 255f, 1f);

	[ColorUsage(true, true)]
	public Color emissionColor = new Color(1.254902f, 1.34902f, 5.992157f, 1f);

	[ColorUsage(true, true)]
	public Color distanceChangeColor = new Color(0f, 23.96863f, 3.137255f, 1f);

	private Vector3 bottomAnchorPoint => bottomTrans.position;

	private Vector3 topAnchorPoint => topTrans.position;

	private void IsMoveValueChange()
	{
		if (!isMove)
		{
			rig = null;
		}
	}

	private void RigValueChange()
	{
		if (rig == null)
		{
			isMove = false;
		}
	}

	public void Start()
	{
		m_MaterialPropertyBlock = new MaterialPropertyBlock();
		wallFaceDir = GetDir(transform);
		Vector3 vector = topAnchorPoint - bottomAnchorPoint;
		m_PathNormal = vector.normalized;
		m_PathMagnitude = vector.magnitude;
		if (prefab != null)
		{
			MeshRenderer[] componentsInChildren = prefab.GetComponentsInChildren<MeshRenderer>();
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.AdsorbWall))
			{
				m_MaterialPropertyBlock.SetColor(BattleConsts.SHADER_EMISSION_COLOR, defaultColor);
				m_MaterialPropertyBlock.SetColor(BattleConsts.SHADER_DISTANCECHANGE_COLOR, defaultColor);
			}
			else
			{
				m_MaterialPropertyBlock.SetColor(BattleConsts.SHADER_EMISSION_COLOR, emissionColor);
				m_MaterialPropertyBlock.SetColor(BattleConsts.SHADER_DISTANCECHANGE_COLOR, distanceChangeColor);
			}
			MeshRenderer[] array = componentsInChildren;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetPropertyBlock(m_MaterialPropertyBlock);
			}
		}
	}

	public void Update()
	{
		if (rig != null)
		{
			Vector3 vector = topAnchorPoint - bottomAnchorPoint;
			m_PathNormal = vector.normalized;
			m_PathMagnitude = vector.magnitude;
		}
	}

	public FaceDir GetDir(Transform point)
	{
		Vector3 localEulerAngles = point.localEulerAngles;
		if (localEulerAngles.y == 90f)
		{
			return FaceDir.Right;
		}
		if (localEulerAngles.y == 270f)
		{
			return FaceDir.Left;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("只会存在左和右的墙，配置错了？？？");
		}
		return FaceDir.None;
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component == null || !Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.AdsorbWall))
		{
			return;
		}
		Entity entity = component.entity;
		CompPhysics compPhysics = entity.GetCompPhysics();
		CompInput compInput = entity.GetCompInput();
		if (compPhysics != null)
		{
			if (wallFaceDir == FaceDir.Left)
			{
				compInput.onRightPressed.Add(OnAdsorb);
			}
			else
			{
				compInput.onLeftPressed.Add(OnAdsorb);
			}
			OnEnterEvt(component.entity, this);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null))
		{
			CompInput compInput = component.entity.GetCompInput();
			if (compInput != null)
			{
				compInput.onRightPressed.Remove(OnAdsorb);
				compInput.onLeftPressed.Remove(OnAdsorb);
			}
			OnExitEvt(component.entity, this);
		}
	}

	private void OnAdsorb(Entity entity, float pressTime)
	{
		CompPhysics compPhysics = entity.GetCompPhysics();
		if ((compPhysics.state == ACTMovementMode.Falling || compPhysics.state == ACTMovementMode.Flying) && CanAdsorb())
		{
			compPhysics.InputEnterAdsorb();
		}
	}

	public bool CanAdsorb()
	{
		if (rig != null)
		{
			return rig.velocity.z == 0f;
		}
		return true;
	}

	public Vector3 ClosestPointOnPath(Vector3 position, float pathOffset, out float pathPos)
	{
		float num = Vector3.Dot(position - bottomTrans.position, m_PathNormal);
		if (num > 0f)
		{
			if (num <= m_PathMagnitude - pathOffset)
			{
				pathPos = 0f;
				return bottomAnchorPoint + m_PathNormal * num;
			}
			pathPos = num - (m_PathMagnitude - pathOffset);
			return topAnchorPoint;
		}
		pathPos = num;
		return bottomAnchorPoint;
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.yellow;
		Gizmos.DrawLine(bottomAnchorPoint, topAnchorPoint);
		if (!(bottomTrans == null) && !(topTrans == null))
		{
			Gizmos.DrawWireCube(bottomTrans.position, Vector3.one * 0.25f);
			Gizmos.DrawWireCube(topTrans.position, Vector3.one * 0.25f);
		}
	}

	private void OnDestroy()
	{
		m_MaterialPropertyBlock.Clear();
	}

	public void TriggerExit()
	{
		CompInput compInput = MonoECS.instance.mainEntity.GetCompInput();
		if (compInput != null)
		{
			compInput.onRightPressed.Remove(OnAdsorb);
			compInput.onLeftPressed.Remove(OnAdsorb);
		}
	}
}
