using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._72011;

public class Action : AIBase
{
	private readonly FP startupDelay = 3;

	private readonly int skillId_Main_1 = 107201101;

	private FP _startupTimer;

	public void OnStart()
	{
		_startupTimer = startupDelay;
		_actor.EnableSuperArmor();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
	}

	public void OnUpdate()
	{
		if (_startupTimer > 0)
		{
			_startupTimer -= _actor.LogicDeltaTime;
		}
		else
		{
			TryCastMainSkill();
		}
	}

	private void TryCastMainSkill()
	{
		if (skillId_Main_1 != 0 && !_actor.actorSkillManage.HaveSkill(skillId_Main_1))
		{
			ILRuntimeAPI.CreateSkill(skillId_Main_1, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
		}
	}

	public void OnStop()
	{
		_startupTimer = 0;
		_actor.DisableSuperArmor();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle) && adventureActorReceiveDamageEvent.to.Id == _actor.Id)
		{
			_actor.actorHealthInfo.hp += adventureActorReceiveDamageEvent.damageToHp;
		}
	}

	private void OnActorReceiveDirectDamage(IEvent evt)
	{
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = evt as AdventureActorReceiveDirectEvent;
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle) && adventureActorReceiveDirectEvent.to.Id == _actor.Id)
		{
			_actor.actorHealthInfo.hp += adventureActorReceiveDirectEvent.damageToHp;
		}
	}

	private void OnActorReceiveDotDamage(IEvent evt)
	{
		AdventureActorDotDamageEvent adventureActorDotDamageEvent = evt as AdventureActorDotDamageEvent;
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle) && adventureActorDotDamageEvent.to.Id == _actor.Id)
		{
			_actor.actorHealthInfo.hp += adventureActorDotDamageEvent.damageToHp;
		}
	}

	private void OnActorReceiveKillDamage(IEvent evt)
	{
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = evt as AdventureActorReceiveKillEvent;
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle) && adventureActorReceiveKillEvent.to.Id == _actor.Id)
		{
			_actor.actorHealthInfo.hp += adventureActorReceiveKillEvent.curValue;
		}
	}
}
