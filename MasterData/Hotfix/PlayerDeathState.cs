using System;
using System.Collections;
using TrueSync;
using UnityEngine;

public class PlayerDeathState : ActorDeathState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("PlayerDeathStateEnter", _actor.Id);
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	protected override void DoDied()
	{
		DiedClear();
		StartLogicCoroutine(WaitingDiedAnimation(), runImmediately: true);
	}

	private IEnumerator WaitingDiedAnimation()
	{
		_actor.PlayDeathAnim();
		FP timer = 0f;
		FP deathAnimationLength = 3f;
		_actor.TimeControlReset();
		while (true)
		{
			FP logicDeltaTime = _actor.LogicDeltaTime;
			timer += logicDeltaTime;
			if (!(timer < deathAnimationLength))
			{
				break;
			}
			yield return null;
		}
		FinishDied();
	}

	protected override void FinishDied()
	{
		base.FinishDied();
		AdventurePlayerDiedEvent adventurePlayerDiedEvent = AdventurePlayerDiedEvent.Generate();
		adventurePlayerDiedEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurePlayerDiedEvent);
		_actor.DisableParallelAI();
		(_actor as PlayerAdventureActor)?.Despawn();
	}
}
