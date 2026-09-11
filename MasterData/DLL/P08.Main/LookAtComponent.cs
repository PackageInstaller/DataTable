using System;
using UnityEngine;

public class LookAtComponent : MonoBehaviour
{
	public enum EBoneType
	{
		None,
		Head,
		Eye
	}

	[Tooltip("骨骼类型,以便查询")]
	public EBoneType eBoneType = EBoneType.Head;

	[Tooltip("头骨Transform")]
	public Transform head;

	[Tooltip("目标Transform")]
	public Transform target;

	[Tooltip("旋转头骨的权重")]
	[Range(0f, 1f)]
	public float headWeight = 0.8f;

	[Tooltip("IK位置权重或解算器的主权重")]
	[Range(0f, 1f)]
	public float IKPositionWeight = 1f;

	[HideInInspector]
	public Vector3 IKPosition;

	[Tooltip("夹紧头骨的旋转,表现是数值越大,旋转越急促 0:自由旋转,1:锁死不旋转")]
	[Range(0f, 1f)]
	public float clampWeightHead = 0.5f;

	[Tooltip("夹紧的正弦平滑迭代次数,用以平滑")]
	[Range(0f, 2f)]
	public int clampSmoothing = 2;

	[Tooltip("脊柱骨骼的权重分布")]
	public AnimationCurve spineWeightCurve = new AnimationCurve(new Keyframe(0f, 0.3f), new Keyframe(1f, 1f));

	private Vector3[] headForwards = new Vector3[1];

	private LookAtBone headBone;

	private bool headIsEmpty => headBone == null;

	private void Awake()
	{
		if (head != null && headBone == null)
		{
			headBone = new LookAtBone(head);
			headBone.Initiate(base.transform);
		}
	}

	private void OnEnable()
	{
		LookAtCompMgr.instance.Registor(this);
	}

	private void OnDisable()
	{
		LookAtCompMgr.instance.UnRegistor(this);
	}

	public void Manual_LateUpdate()
	{
		if (!(IKPositionWeight <= 0f) && !(target == null))
		{
			IKPositionWeight = Mathf.Clamp(IKPositionWeight, 0f, 1f);
			IKPosition = target.position;
			if (!(headWeight <= 0f) && !headIsEmpty)
			{
				Vector3 forward = headBone.forward;
				Vector3 normalized = Vector3.Lerp(forward, (IKPosition - head.transform.position).normalized, headWeight * IKPositionWeight).normalized;
				GetForwards(ref headForwards, forward, normalized, 1, clampWeightHead);
				headBone.LookAt(headForwards[0], headWeight * IKPositionWeight);
			}
		}
	}

	protected Vector3[] GetForwards(ref Vector3[] forwards, Vector3 baseForward, Vector3 targetForward, int bones, float clamp)
	{
		if (clamp >= 1f || IKPositionWeight <= 0f)
		{
			for (int i = 0; i < forwards.Length; i++)
			{
				forwards[i] = baseForward;
			}
			return forwards;
		}
		float num = Vector3.Angle(baseForward, targetForward);
		float num2 = 1f - num / 180f;
		float num3 = ((clamp > 0f) ? Mathf.Clamp(1f - (clamp - num2) / (1f - num2), 0f, 1f) : 1f);
		float num4 = ((clamp > 0f) ? Mathf.Clamp(num2 / clamp, 0f, 1f) : 1f);
		for (int j = 0; j < clampSmoothing; j++)
		{
			num4 = Mathf.Sin(num4 * MathF.PI * 0.5f);
		}
		if (forwards.Length == 1)
		{
			forwards[0] = Vector3.Slerp(baseForward, targetForward, num4 * num3);
		}
		else
		{
			float num5 = 1f / (float)(forwards.Length - 1);
			for (int k = 0; k < forwards.Length; k++)
			{
				forwards[k] = Vector3.Slerp(baseForward, targetForward, spineWeightCurve.Evaluate(num5 * (float)k) * num4 * num3);
			}
		}
		return forwards;
	}
}
