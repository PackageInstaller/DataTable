using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class DelayCompleteTransition : InteractAction
{
	public bool clear = true;

	public int targetStateId;

	public float delayTime;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (stateObjectBase.IsWaitTransition())
		{
			await UniTask.Delay(TimeSpan.FromSeconds(delayTime));
			if (clear)
			{
				stateObjectBase.CompleteTransitionClear();
			}
			else
			{
				stateObjectBase.CompleteTransition(targetStateId);
			}
		}
	}
}
