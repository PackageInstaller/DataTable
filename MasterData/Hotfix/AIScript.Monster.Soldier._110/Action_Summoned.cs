using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._110;

public class Action_Summoned : AIBase
{
	private readonly FP durationTime = 6.5;

	private readonly FP durationTime_Potential2 = 12;

	private readonly int skillId_SummonSkill1 = 100011004;

	public const string tag_UseCombo2 = "110_UseCombo2";

	private FP _durationTime;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomBroadcast);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomBroadcast);
	}

	public void OnStart()
	{
		_durationTime = ((_actor is SoldierActor soldierActor && soldierActor.GetPotentialLv() >= 2) ? durationTime_Potential2 : durationTime);
		_actor.EnableUnparalleled();
		_actor.EnableSearchedImmunity();
		_actor.EnableCloseBlock();
	}

	public void OnUpdate()
	{
		if (!_actor.actorSkillManage.HaveSkill(skillId_SummonSkill1))
		{
			CreateSummonSkill();
		}
		if (_durationTime >= 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private void CreateSummonSkill()
	{
		if (skillId_SummonSkill1 != 0)
		{
			ILRuntimeAPI.CreateSkill(skillId_SummonSkill1, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
		}
	}

	private void OnCustomBroadcast(IEvent evt)
	{
		if (!(_actor == null) && evt is AdventureActorCustomEvent adventureActorCustomEvent && string.Equals(adventureActorCustomEvent.eventName, "SummonTag") && adventureActorCustomEvent.actor is SoldierActor soldierActor && _actor is SoldierActor soldierActor2 && soldierActor.isEnemyCamp == soldierActor2.isEnemyCamp)
		{
			_actor.logicVariable.ToggleLogicTag("110_UseCombo2", value: true);
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableSearchedImmunity();
		_actor.DisableCloseBlock();
		_durationTime = 0;
	}
}
