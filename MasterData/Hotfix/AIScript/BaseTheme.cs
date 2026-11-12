using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

public class BaseTheme
{
	private readonly Dictionary<int, FP> _perkTriggerTimeDic = new Dictionary<int, FP>(15);

	protected AdventureActor _actor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected FP LogicDeltaTime
	{
		get
		{
			if (!(_actor != null))
			{
				return LockStepManager.deltaTime;
			}
			return _actor.LogicDeltaTime;
		}
	}

	public virtual void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT", OnTriggerCharGamePlayLogicCommonEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnSwitchActor);
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT", OnTriggerCharGamePlayLogicCommonEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnSwitchActor);
	}

	protected bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(perkId, out lv);
	}

	private void OnTriggerCharGamePlayLogicCommonEvent(IEvent evt)
	{
		if (evt is TriggerCharGamePlayLogicCommonEvent triggerCharGamePlayLogicCommonEvent && !(_actor == null))
		{
			PlayerAdventureActor playerAdventureActor = triggerCharGamePlayLogicCommonEvent.sender as PlayerAdventureActor;
			if (triggerCharGamePlayLogicCommonEvent.normalAttackTrigger)
			{
				OnPerk_NormalAtk();
			}
			if (triggerCharGamePlayLogicCommonEvent.dodgeTrigger)
			{
				OnPerk_Dodge();
			}
			if (playerAdventureActor != null && !playerAdventureActor.isAssist && triggerCharGamePlayLogicCommonEvent.skillTrigger)
			{
				OnPerk_CastSkill();
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorCastSkillEvent.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && playerAdventureActor.isAssist && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			OnPerk_CastAssistSkill();
		}
	}

	private void OnReceiveNoDamage(IEvent evt)
	{
		AdventureActorNoDamageEvent adventureActorNoDamageEvent = evt as AdventureActorNoDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorNoDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && adventureActorNoDamageEvent.from is PlayerAdventureActor && monsterAdventureActor != null)
		{
			OnNoDmgHit(adventureActorNoDamageEvent);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && adventureActorReceiveDamageEvent.from is PlayerAdventureActor && monsterAdventureActor != null)
		{
			OnHitPost(adventureActorReceiveDamageEvent);
		}
		if (adventureActorReceiveDamageEvent.isKill && monsterAdventureActor != null && adventureActorReceiveDamageEvent.from is PlayerAdventureActor)
		{
			OnMonsterKilled(adventureActorReceiveDamageEvent);
		}
		if (_actor != null && adventureActorReceiveDamageEvent.to is PlayerAdventureActor)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnReceiveHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeSettlementEvent.from is PlayerAdventureActor && adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor != null)
		{
			OnHitPre(adventureActorReceiveDamageBeforeSettlementEvent);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && adventureActorReceiveCritDamageEvent.from is PlayerAdventureActor && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (_actor != null && adventureBulletFinishEvent.owner is PlayerAdventureActor)
		{
			OnBulletFinish(adventureBulletFinishEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null)
		{
			if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
			}
			else if (adventureActorReceiveDamageBeforeHitEvent.to is PlayerAdventureActor)
			{
				OnBeforeHurt(adventureActorReceiveDamageBeforeHitEvent);
			}
		}
	}

	private void OnSwitchActor(IEvent evt)
	{
		AdventureSWICH_PLAYER_ACTOR evt2 = evt as AdventureSWICH_PLAYER_ACTOR;
		OnSwitchActor(evt2);
	}

	protected virtual void OnPerk_NormalAtk()
	{
	}

	protected virtual void OnPerk_Dodge()
	{
	}

	protected virtual void OnPerk_CastSkill()
	{
	}

	protected virtual void OnPerk_CastAssistSkill()
	{
	}

	protected virtual void OnCrit(AdventureActorReceiveCritDamageEvent _evt)
	{
	}

	protected virtual void OnNoDmgHit(AdventureActorNoDamageEvent _evt)
	{
	}

	protected virtual void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
	}

	protected virtual void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
	}

	protected virtual void OnMonsterKilled(AdventureActorReceiveDamageEvent _evt)
	{
	}

	protected virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
	}

	protected virtual void OnBeforeHurt(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
	}

	protected virtual void OnHurt(AdventureActorReceiveDamageEvent _evt)
	{
	}

	protected virtual void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
	}

	protected virtual void OnSwitchActor(AdventureSWICH_PLAYER_ACTOR _evt)
	{
	}

	protected void TriggerPerk(int perkId)
	{
		FP time = LockStepManager.time;
		if (_perkTriggerTimeDic.ContainsKey(perkId))
		{
			_perkTriggerTimeDic.set_Item(perkId, time);
		}
		else
		{
			_perkTriggerTimeDic.Add(perkId, time);
		}
	}

	protected bool CheckPerkCDTimeout(int perkId, FP cd)
	{
		if (_perkTriggerTimeDic.TryGetValue(perkId, out var value))
		{
			return LockStepManager.time - value > cd;
		}
		return true;
	}

	protected bool CheckPerkCD(int perkId, FP cd)
	{
		if (cd <= 0)
		{
			return true;
		}
		if (CheckPerkCDTimeout(perkId, cd))
		{
			TriggerPerk(perkId);
			return true;
		}
		return false;
	}

	protected bool CanTriggerPerk(int perkId, out int lv, FP cd)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(perkId, out lv))
		{
			return CheckPerkCD(perkId, cd);
		}
		return false;
	}

	protected void ModifyPerkCD(int perkId, FP reduceCd)
	{
		if (_perkTriggerTimeDic.TryGetValue(perkId, out var value))
		{
			_perkTriggerTimeDic.set_Item(perkId, value - reduceCd);
		}
	}

	protected void ClearAllPerkCD()
	{
		_perkTriggerTimeDic.Clear();
	}

	protected CoroutineNode StartLogicCoroutine(IEnumerator enumerator, bool runImmediately = false)
	{
		if (_actor != null)
		{
			return _actor.StartLogicCoroutine(enumerator, runImmediately);
		}
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			return SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(enumerator, runImmediately);
		}
		return null;
	}

	protected void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (_actor != null && coroutine != null)
		{
			_actor.StopLogicCoroutine(coroutine);
		}
		else if (SceneSingleton<AdventurePlayerController>.Instance != null && coroutine != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(coroutine);
		}
	}

	protected void AddKey(string key)
	{
		if (ModuleController<AdventureModuleController>.Instance.dicCount.TryGetValue(key, out var value))
		{
			ModuleController<AdventureModuleController>.Instance.dicCount.set_Item(key, value + 1);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.dicCount.Add(key, 1);
		}
	}

	protected void DelKey(string key)
	{
		if (ModuleController<AdventureModuleController>.Instance.dicCount.TryGetValue(key, out var value))
		{
			ModuleController<AdventureModuleController>.Instance.dicCount.set_Item(key, value - 1);
		}
	}

	protected int GetKeyCount(string key)
	{
		if (ModuleController<AdventureModuleController>.Instance.dicCount.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	protected void ClearKey(string key)
	{
		if (!(ModuleController<AdventureModuleController>.Instance == null) && ModuleController<AdventureModuleController>.Instance.dicCount.TryGetValue(key, out var _))
		{
			ModuleController<AdventureModuleController>.Instance.dicCount.set_Item(key, 0);
		}
	}
}
