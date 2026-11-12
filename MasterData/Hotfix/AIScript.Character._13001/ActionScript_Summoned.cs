using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ActionScript_Summoned : AIBase
{
	private PlayerAdventureActor _summoner;

	private FP _useTauntAttackInterval;

	private FP _lastExitActionTime;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_useTauntAttackInterval = 0;
		_lastExitActionTime = 0;
	}

	public void OnStart()
	{
		if (_lastExitActionTime > 0 && _useTauntAttackInterval > 0)
		{
			_useTauntAttackInterval -= _actor.LogicTime - _lastExitActionTime;
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	public void OnUpdate()
	{
		if (_useTauntAttackInterval <= 0)
		{
			if (!_actor.actorSkillManage.HaveRunningSkill())
			{
				_useTauntAttackInterval = Config_MainControl.useInterval_TauntAttack_Summon;
				ILRuntimeAPI.CreateSkill(13031002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			}
		}
		else
		{
			_useTauntAttackInterval -= _actor.LogicDeltaTime;
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && _summoner != null && adventureActorReceiveDamageEvent.from == _summoner && adventureActorReceiveDamageEvent.to is MonsterAdventureActor && CommonUtils.HavePersonalPerk(_summoner.dataID, 513003, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_MainControl.damageTag_PenetratingArrow_P3) && _actor.DistanceWithRadius(adventureActorReceiveDamageEvent.to) <= Config_MainControl.triggerDiastance_P3 && !_actor.actorSkillManage.HaveRunningSkill())
		{
			ILRuntimeAPI.CreateSkill(13031003, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
	}

	public void OnStop()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_lastExitActionTime = _actor.LogicTime;
	}

	public void OnDisable()
	{
		_useTauntAttackInterval = 0;
		_lastExitActionTime = 0;
		_summoner = null;
	}
}
