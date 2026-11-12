#define LOG_ERROR
using System.Collections;
using System.Linq;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class BaseFateCardTheme
{
	public HotfixEnum.fateCardTheme theme;

	protected HotfixEnum.fateCardThemeRank _themeRank;

	private HotfixEnum.fateCardThemeTriggerType[] _triggerTypes;

	private FP _triggerTime;

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

	protected bool CanExcuteA
	{
		get
		{
			if (_themeRank != HotfixEnum.fateCardThemeRank.ProA)
			{
				return _themeRank == HotfixEnum.fateCardThemeRank.Super;
			}
			return true;
		}
	}

	protected bool CanExcuteB
	{
		get
		{
			if (_themeRank != HotfixEnum.fateCardThemeRank.ProB)
			{
				return _themeRank == HotfixEnum.fateCardThemeRank.Super;
			}
			return true;
		}
	}

	protected bool CanExcuteC => _themeRank == HotfixEnum.fateCardThemeRank.Super;

	public void OnInit(HotfixEnum.fateCardTheme theme, HotfixEnum.fateCardThemeRank themeRank, HotfixEnum.fateCardThemeTriggerType[] triggerTypes)
	{
		this.theme = theme;
		_themeRank = themeRank;
		_triggerTypes = triggerTypes;
	}

	public virtual void OnEnable()
	{
		_triggerTime = 0;
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

	private void OnTriggerCharGamePlayLogicCommonEvent(IEvent evt)
	{
		if (!(_actor == null) && evt is TriggerCharGamePlayLogicCommonEvent triggerCharGamePlayLogicCommonEvent && _triggerTypes != null && _triggerTypes.Length != 0)
		{
			if (triggerCharGamePlayLogicCommonEvent.normalAttackTrigger && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.NormalAttack))
			{
				OnTrigger();
			}
			if (triggerCharGamePlayLogicCommonEvent.dodgeTrigger && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.Dodge))
			{
				OnTrigger();
			}
			if (triggerCharGamePlayLogicCommonEvent.skillTrigger && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.CastSkill))
			{
				OnTrigger();
			}
			if (triggerCharGamePlayLogicCommonEvent.ultimateTrigger && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.ExSkill))
			{
				OnTrigger();
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorCastSkillEvent.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && _triggerTypes != null && _triggerTypes.Length != 0 && playerAdventureActor.isAssist && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.AssistSkill))
		{
			OnTrigger();
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
		if (adventureActorReceiveDamageEvent.to.Id == _actor.Id && _triggerTypes != null && _triggerTypes.Length != 0 && _triggerTypes.Contains(HotfixEnum.fateCardThemeTriggerType.Behit))
		{
			OnTrigger();
		}
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

	protected virtual void OnTrigger()
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

	protected long PlayAreaEffect(string fxAlias, TSVector2 position = default(TSVector2), int hitId = 0, FP rotation = default(FP))
	{
		return ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, rotation, (AreaEffectEntity entity) =>
		{
			if (hitId > 111110)
			{
				AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = hitId;
				}
			}
		});
	}

	protected GameObject LoadAsset(string stringAlias)
	{
		GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(_actor, stringAlias, forceUseCommonConfig: true);
		if (null == fxByAlias)
		{
			NovaLogger.Error("特效资源为空:" + stringAlias);
			return null;
		}
		return fxByAlias;
	}

	protected void TriggerTheme()
	{
		_triggerTime = LockStepManager.time;
	}

	protected bool CheckTimeout(FP cd)
	{
		return LockStepManager.time - _triggerTime > cd;
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
