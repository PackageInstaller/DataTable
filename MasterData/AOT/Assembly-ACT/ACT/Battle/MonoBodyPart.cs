using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using RootMotion.FinalIK;
using UnityEngine;

namespace ACT.Battle;

[ExecuteInEditMode]
[AddComponentMenu("4战斗相关组件/受击的BodyPart")]
public class MonoBodyPart : MonoBehaviour, IColliderEntityRef
{
	public Entity entity;

	public byte index;

	public Collider myCollider;

	public bool parryOnly;

	public bool hitShake;

	public BodyIk[] bodyIks;

	public byte priority;

	public bool aimAble;

	private IKEffector[] m_Effector;

	private bool m_Shaking;

	private float m_DampTime;

	private Vector3 m_Dir;

	private void Awake()
	{
		CacheColliderReference();
		if (Application.isPlaying)
		{
			EnsureInitialized();
		}
	}

	private void Start()
	{
		EnsureInitialized();
	}

	public void SetRuntimeActive(bool active)
	{
		if (active)
		{
			EnsureInitialized();
		}
		enabled = active;
		CacheColliderReference();
		if (myCollider != null)
		{
			myCollider.enabled = active;
		}
	}

	private void CacheColliderReference()
	{
		if (myCollider == null)
		{
			myCollider = GetComponent<Collider>();
		}
	}

	private void EnsureInitialized()
	{
		CacheColliderReference();
		if (!Application.isPlaying || m_Effector != null || !hitShake || bodyIks == null || bodyIks.Length == 0)
		{
			return;
		}
		FullBodyBipedIK componentInParent = GetComponentInParent<FullBodyBipedIK>();
		if (!(componentInParent == null))
		{
			m_Effector = new IKEffector[bodyIks.Length];
			for (int i = 0; i < bodyIks.Length; i++)
			{
				m_Effector[i] = componentInParent.solver.GetEffector(bodyIks[i].ik);
				m_Effector[i].positionWeight = 0f;
			}
		}
	}

	private void Update()
	{
		if (!m_Shaking)
		{
			return;
		}
		m_DampTime += Time.deltaTime;
		int num = 0;
		for (int i = 0; i < bodyIks.Length; i++)
		{
			AnimationCurve damp = bodyIks[i].damp;
			if (m_DampTime > damp.keys[damp.length - 1].time)
			{
				num++;
				m_Effector[i].positionWeight = 0f;
			}
			else
			{
				m_Effector[i].position = m_Effector[i].bone.position + damp.Evaluate(m_DampTime) * bodyIks[i].ikStrength * m_Dir;
			}
		}
		if (num == bodyIks.Length)
		{
			m_Shaking = false;
		}
	}

	internal void OnHit(bool faceLeft, float angle, Vector3 hitPos, float ikStrength)
	{
		EnsureInitialized();
		if (hitShake && m_Effector != null && bodyIks != null && bodyIks.Length != 0)
		{
			m_Dir = (faceLeft ? Vector3.left : Vector3.right);
			Quaternion quaternion = Quaternion.Euler(0f, angle, 0f);
			m_Dir = quaternion * m_Dir;
			m_DampTime = 0f;
			m_Shaking = true;
			for (int i = 0; i < m_Effector.Length; i++)
			{
				m_Effector[i].positionWeight = 1f;
				m_Effector[i].position = hitPos;
				bodyIks[i].ikStrength = ikStrength;
			}
		}
	}

	public MonoEntity GetMonoEntity()
	{
		return entity.GetMono();
	}

	public (bool, FindTargetResult) FindResult(Vector3 anchor, Vector3 touchForward)
	{
		if (!entity.IsLogicAvailable())
		{
			return (false, default);
		}
		Vector3 vector = myCollider.ClosestPoint(anchor);
		FindTargetResult item = FindTargetResult.BodyPart(entity, index, (anchor - vector).sqrMagnitude, vector, touchForward, myCollider);
		return (true, item);
	}

	public void RemoveEntityRef()
	{
		if (myCollider != null)
		{
			PhysicsUtility.RemoveEntityRef(myCollider);
		}
	}

	private void OnDestroy()
	{
		RemoveEntityRef();
	}
}
