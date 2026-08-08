using UnityEngine;

namespace Dorm.Character.Animation;

internal class EntityRestoreFacialExpressionOnExit : StateMachineBehaviour
{
	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		int value = 0;
		IEidProvider component = animator.GetComponent<IEidProvider>();
		if (component != null)
		{
			value = component.EntityID;
		}
		if (DormEntityManager.Instance?.TryGet(value) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.sdChara.sheetFaceId = dormComplexEntity.DefaultMouth;
		}
	}
}
