using System.Collections;
using AdventureBehaviour;

namespace AIScript.Character._11601;

public class ParallelScript_Summoned : AIBase
{
	private PlayFX _playFX;

	public void OnEnable()
	{
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		else
		{
			_playFX.Clear();
		}
		_playFX.Play(_actor, null, "fx_11601_loop_Skill_Main_PeaShooter_born", default, _actor.tsTransform.Position, default);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_Summoned_DestroySelf_P2)
		{
			DestroySelf();
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		DestroySelf();
	}

	private void DestroySelf()
	{
		if (_actor.state == ActorState.Spawn)
		{
			_actor.StartLogicCoroutine(WaitForDestroySelf());
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private IEnumerator WaitForDestroySelf()
	{
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == _actor)
		{
			_playFX?.Stop();
			_playFX?.Clear();
		}
	}

	public void OnDisable()
	{
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		_actor.DisablePenetrate();
		_playFX?.Stop();
		_playFX?.Clear();
	}
}
