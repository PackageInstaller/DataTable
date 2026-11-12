namespace AIScript.Soldier.SoldierPlayerPassive;

public class SoldierPlayerPassiveBase : AIBase
{
	public void OnEnable()
	{
		OnPlayerPassiveEnable();
	}

	public void OnDisable()
	{
		OnPlayerPassiveDisable();
	}

	protected virtual void OnPlayerPassiveEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	protected virtual void OnPlayerPassiveDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnBattleStart(IEvent evt)
	{
		if (evt is AdventureMsgBattleStartEvent)
		{
			OnPlayerPassiveBattleStart();
		}
	}

	protected virtual void OnPlayerPassiveBattleStart()
	{
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		OnCastSkill(adventureActorCastSkillEvent);
		if (adventureActorCastSkillEvent.sender as AdventureActor is SoldierActor { isEnemyCamp: false } soldierActor)
		{
			OnOurSoldierCastSkill(soldierActor, adventureActorCastSkillEvent);
		}
	}

	protected virtual void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
	}
}
