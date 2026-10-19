using UnityEngine;

namespace ACT.UI;

public class HitStateBehaviour : StateMachineBehaviour
{
	public bool goToHide;

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (goToHide)
		{
			animator.Play("Hide");
			animator.SetInteger("state", -1);
		}
		else
		{
			animator.SetInteger("hitState", 0);
		}
	}
}
