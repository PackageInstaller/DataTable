using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartnerBase : AIBase
{
	public int partnerLv;

	public void OnEnable()
	{
		OnPartnerEnable();
	}

	public void OnDisable()
	{
		OnPartnerDisable();
	}

	protected virtual void OnPartnerEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageEvt);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected virtual void OnPartnerDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageEvt);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected virtual void OnPartnerBattleStart()
	{
	}

	protected bool IsSummoned(SoldierActor actor, out SoldierActor summoner)
	{
		summoner = null;
		if (actor == null)
		{
			return false;
		}
		List<SoldierLevelController.SoldierSummonData> list = (ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController)?.GetSoldierSummonInfos();
		if (list == null || list.Count <= 0)
		{
			return false;
		}
		foreach (SoldierLevelController.SoldierSummonData item in list)
		{
			if (item.summoned == actor)
			{
				summoner = item.summoner;
				return true;
			}
		}
		return false;
	}

	protected virtual void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnRemoveBuff(IEvent evt)
	{
	}

	private void OnBattleStart(IEvent evt)
	{
		if (evt is AdventureMsgBattleStartEvent)
		{
			OnPartnerBattleStart();
		}
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

	private void OnReceiveDamageEvt(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent damageEvent)
		{
			OnReceiveDamage(damageEvent);
		}
	}
}
