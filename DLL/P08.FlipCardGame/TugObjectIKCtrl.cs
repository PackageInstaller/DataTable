using UnityEngine;

[RequireComponent(typeof(Animator))]
public class TugObjectIKCtrl : MonoBehaviour
{
	protected Animator animator;

	public bool ikActive;

	public Transform rightHandObj;

	public Transform leftHandObj;

	private void Start()
	{
		animator = GetComponent<Animator>();
	}

	private void OnAnimatorIK()
	{
		if (!animator)
		{
			return;
		}
		if (ikActive)
		{
			animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 1f);
			animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 1f);
			animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, 0.5f);
			animator.SetIKRotationWeight(AvatarIKGoal.LeftHand, 0.5f);
			if (rightHandObj != null)
			{
				animator.SetIKPosition(AvatarIKGoal.RightHand, rightHandObj.position);
				animator.SetIKRotation(AvatarIKGoal.RightHand, rightHandObj.rotation);
			}
			if (leftHandObj != null)
			{
				animator.SetIKPosition(AvatarIKGoal.LeftHand, leftHandObj.position);
				animator.SetIKRotation(AvatarIKGoal.LeftHand, leftHandObj.rotation);
			}
		}
		else
		{
			animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 0f);
			animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 0f);
		}
	}
}
