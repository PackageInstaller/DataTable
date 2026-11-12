using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._16001;

public class ParallelScript_Summoned_MainControl : AIBase
{
	private PlayerAdventureActor _summoner;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropItemFinish);
	}

	private void OnBattleReady(IEvent _)
	{
		DestroySelf();
	}

	private void OnSummonedSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent { sender: MonsterAdventureActor sender } && sender.IsPlayerSummoned(out var summoner, out var _) && summoner == _summoner && sender.dataID == _actor.dataID && sender.Id != _actor.Id)
		{
			DestroySelf();
		}
	}

	private void DestroySelf()
	{
		if (_actor.state == ActorState.Null || _actor.state == ActorState.Spawn)
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
		while (_actor.state == ActorState.Null || _actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	private void OnDropItemFinish(IEvent evt)
	{
		if (evt is AdventureDropFinishEvent adventureDropFinishEvent && adventureDropFinishEvent.owner == _summoner && CommonUtils.HavePersonalPerk(_summoner.dataID, 516001, out var _) && adventureDropFinishEvent.isPickUp && string.Equals(adventureDropFinishEvent.dropTag, "Item_16001_Main_P01_Bubble_Tag") && adventureDropFinishEvent.target == _actor)
		{
			FP modelScale = _actor.actorScaleInfo.modelScale;
			if (modelScale < Config_MainControl.maxModelScale_P1)
			{
				FP value = Config_MainControl.addModelScaleMutil_P1 * _actor.actorScaleInfo.originModelScale;
				FP max = Config_MainControl.maxModelScale_P1 - modelScale;
				value = TSMath.Clamp(value, 0, max);
				_actor.actorScaleInfo.modelScale += value;
			}
			CommonUtils.PlayOneOffFx(_actor, "fx_16001_base_popoball_Skill_Main_Perk01");
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropItemFinish);
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		_summoner = null;
	}
}
