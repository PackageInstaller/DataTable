using UnityEngine;

namespace Dorm.Character.Animation;

public class EnableDormCharaterInputTrigger : StateMachineBehaviour
{
	private DormEntityTrigger trigger;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		DormPlayerEntity dormPlayerEntity = DormEntityManager.TryGetPlayer(0);
		if (dormPlayerEntity != null)
		{
			trigger = dormPlayerEntity.Trigger;
		}
		if (trigger == null)
		{
			trigger = animator.GetComponent<DormEntityTrigger>();
		}
		if (trigger != null)
		{
			trigger.ClickInteractAvailable = true;
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if ((bool)trigger)
		{
			trigger.ClickInteractAvailable = false;
		}
	}
}
