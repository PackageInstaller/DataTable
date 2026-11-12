using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class ParallelLogicController
{
	private AdventureActor _actor;

	private bool _isBossRush;

	private CoroutineNode _detonateBaoLin_FireBurstCor;

	private CoroutineNode _generateAreaEffect_BurstCor;

	public void OnEnable(AdventureActor actor, bool isBossRush)
	{
		_actor = actor;
		_isBossRush = isBossRush;
		if (_isBossRush)
		{
			_actor.logicVariable.ToggleLogicTag("logicTag_CanTriggerBurst", ((MonsterAdventureActor)_actor).BattleLevel >= 15);
		}
		else
		{
			_actor.logicVariable.ToggleLogicTag("logicTag_CanTriggerBurst", _actor.actorHealthInfo.hpPercentage <= Config.hpPercent_ChangeStage);
		}
		_actor.logicVariable.ToggleLogicTag("SkillStrength", value: false);
		_actor.logicVariable.SetLogicTagValue("GenerateInterval_Burst", Config.generateInterval_Burst);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		if (evt is AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent && adventureAreaEffectBeginEvent.owner == _actor && adventureAreaEffectBeginEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag(Config.areaEffectTag_FireBurst))
		{
			if (_detonateBaoLin_FireBurstCor != null)
			{
				_actor.StopLogicCoroutine(_detonateBaoLin_FireBurstCor);
			}
			_detonateBaoLin_FireBurstCor = _actor.StartLogicCoroutine(DetonateBaoLin_FireBurst(areaEffectEntity), runImmediately: true);
		}
	}

	private IEnumerator DetonateBaoLin_FireBurst(AreaEffectEntity areaEffect)
	{
		while (areaEffect.ActiveSelf)
		{
			foreach (LogicEntity item in ILRuntimeAPI.SearchByRangeAndPosition(_actor, areaEffect.tsTransform.Position, areaEffect.GetAreaRadius()))
			{
				if (item is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.CheckTag(Config.tag_BaoLin) && !monsterAdventureActor.IsDead())
				{
					AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
					adventureActorCustomEvent.sender = monsterAdventureActor;
					adventureActorCustomEvent.actor = monsterAdventureActor;
					adventureActorCustomEvent.eventHashCode = Config.eventHashCode_BaoLin_Explosion;
					monsterAdventureActor.DispatchEvent(adventureActorCustomEvent);
				}
			}
			yield return null;
		}
		_detonateBaoLin_FireBurstCor = null;
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff { sender: MonsterAdventureActor sender } adventureActorGetBuff && sender == _actor && adventureActorGetBuff.eventInfo.buffId == 318010010)
		{
			_actor.logicVariable.ToggleLogicTag("SkillStrength", value: true);
			if (_generateAreaEffect_BurstCor != null)
			{
				_actor.StopLogicCoroutine(_generateAreaEffect_BurstCor);
			}
			_generateAreaEffect_BurstCor = _actor.StartLogicCoroutine(GenerateAreaEffect_Burst(), runImmediately: true);
		}
	}

	private IEnumerator GenerateAreaEffect_Burst()
	{
		while (true)
		{
			TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, Config.generateAreaEffectShape_Burst);
			ILRuntimeAPI.PlayAreaEffect(_actor, "Area_BaoYan_Meteor", randomPointInShape);
			yield return _actor.WaitTime(_actor.logicVariable.GetLogicTagValue("GenerateInterval_Burst"));
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: MonsterAdventureActor sender } adventureActorRemoveBuff && sender == _actor && adventureActorRemoveBuff.eventInfo.buffId == 318010010)
		{
			if (_generateAreaEffect_BurstCor != null)
			{
				_actor.StopLogicCoroutine(_generateAreaEffect_BurstCor);
			}
			_generateAreaEffect_BurstCor = null;
		}
	}

	private void OnHpChange(IEvent evt)
	{
		if (!_isBossRush && evt is AdventureActorHpChangedEvent { sender: MonsterAdventureActor sender } && sender == _actor && !_actor.logicVariable.GetLogicTagToggle("logicTag_CanTriggerBurst"))
		{
			_actor.logicVariable.ToggleLogicTag("logicTag_CanTriggerBurst", sender.actorHealthInfo.hpPercentage <= Config.hpPercent_ChangeStage);
		}
	}

	private void OnBattleLevelChange(IEvent evt)
	{
		if (_isBossRush && evt is AdventureMonsterBattleLevelChangedEvent { sender: MonsterAdventureActor sender } adventureMonsterBattleLevelChangedEvent && sender == _actor && adventureMonsterBattleLevelChangedEvent.newLevel > adventureMonsterBattleLevelChangedEvent.oldLevel && !_actor.logicVariable.GetLogicTagToggle("logicTag_CanTriggerBurst"))
		{
			_actor.logicVariable.ToggleLogicTag("logicTag_CanTriggerBurst", adventureMonsterBattleLevelChangedEvent.newLevel >= 15);
		}
	}

	private void OnToughnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && monsterToughnessStateChangeEvent.actor == _actor && monsterToughnessStateChangeEvent.isToughnessBroken && _actor.buffComponent.CheckBuffByBuffID(318010010))
		{
			_actor.logicVariable.ToggleLogicTag("ExitBurstByToughnessBroken", value: true);
			_actor.buffComponent.RemoveBuffByBuffId(318010010);
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		if (_detonateBaoLin_FireBurstCor != null)
		{
			_actor.StopLogicCoroutine(_detonateBaoLin_FireBurstCor);
		}
		_detonateBaoLin_FireBurstCor = null;
		if (_generateAreaEffect_BurstCor != null)
		{
			_actor.StopLogicCoroutine(_generateAreaEffect_BurstCor);
		}
		_generateAreaEffect_BurstCor = null;
		_actor = null;
	}
}
