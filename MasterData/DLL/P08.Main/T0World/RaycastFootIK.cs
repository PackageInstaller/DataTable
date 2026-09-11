using Animancer;
using UnityEngine;

namespace T0World;

public class RaycastFootIK : MonoBehaviour
{
	[SerializeField]
	[Header("是否开启")]
	private bool enable = true;

	[SerializeField]
	private AnimancerComponent animancer;

	[SerializeField]
	[Header("检测起点")]
	private float _RaycastOriginY = 0.1f;

	[SerializeField]
	[Header("检测终点")]
	private float _RaycastEndY = -0.2f;

	[SerializeField]
	private float _ForwardOffset;

	[SerializeField]
	private LayerMask whatIsGround;

	public Transform LeftFoot;

	public Transform RightFoot;

	private AnimatedFloat FootWeights;

	public bool ApplyAnimatorIK
	{
		get
		{
			return animancer.Layers.get_Item(0).ApplyAnimatorIK;
		}
		set
		{
			animancer.Layers.get_Item(0).ApplyAnimatorIK = value;
		}
	}

	protected virtual void Awake()
	{
		FootWeights = new AnimatedFloat(animancer, "LeftFootIK", "RightFootIK");
	}

	private void OnEnable()
	{
		ApplyAnimatorIK = true;
	}

	private void OnDisable()
	{
		ApplyAnimatorIK = false;
	}

	protected virtual void OnAnimatorIK(int layerIndex)
	{
		UpdateFootIK(LeftFoot, AvatarIKGoal.LeftFoot, ((AnimatedProperty<AnimatedFloat.Job, float>)FootWeights).get_Item(0), animancer.Animator.leftFeetBottomHeight);
		UpdateFootIK(RightFoot, AvatarIKGoal.RightFoot, ((AnimatedProperty<AnimatedFloat.Job, float>)FootWeights).get_Item(1), animancer.Animator.rightFeetBottomHeight);
	}

	private void UpdateFootIK(Transform footTransform, AvatarIKGoal goal, float weight, float footBottomHeight)
	{
		Animator animator = animancer.Animator;
		animator.SetIKPositionWeight(goal, weight);
		animator.SetIKRotationWeight(goal, weight);
		if (weight != 0f)
		{
			Quaternion iKRotation = animator.GetIKRotation(goal);
			Vector3 vector = iKRotation * Vector3.up;
			Vector3 vector2 = iKRotation * Vector3.forward;
			Vector3 position = footTransform.position;
			position += vector * _RaycastOriginY;
			position += vector2 * _ForwardOffset;
			float num = _RaycastOriginY - _RaycastEndY;
			if (Physics.Raycast(position, -vector, out var hitInfo, num, whatIsGround))
			{
				Debug.DrawLine(position, weight * (hitInfo.point - position) + position, Color.yellow);
				position = hitInfo.point;
				position += vector * footBottomHeight;
				position -= vector2 * _ForwardOffset;
				animator.SetIKPosition(goal, position);
				Vector3 axis = Vector3.Cross(vector, hitInfo.normal);
				iKRotation = Quaternion.AngleAxis(Vector3.Angle(vector, hitInfo.normal), axis) * iKRotation;
				animator.SetIKRotation(goal, iKRotation);
			}
			else
			{
				position += vector * (footBottomHeight - num);
				position -= vector2 * _ForwardOffset;
				animator.SetIKPosition(goal, position);
			}
		}
	}
}
