using UnityEngine;

public class AnimatorResetTriger : StateMachineBehaviour
{
	public string[] clearAtEnter;

	public string[] clearAtExit;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		string[] array = clearAtEnter;
		foreach (string value in array)
		{
			if (!string.IsNullOrEmpty(value))
			{
				animator.ResetTrigger(value);
			}
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		string[] array = clearAtExit;
		foreach (string value in array)
		{
			if (!string.IsNullOrEmpty(value))
			{
				animator.ResetTrigger(value);
			}
		}
	}
}
