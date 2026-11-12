using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class ParallelScript : ParallelBase
{
	private bool _showDecibelPerformance;

	private FP _lastTriggerTime_PlayAddDecibelFx;

	private PlayFX _playFX;

	protected PlayerSkillCd _playerSkillCd;

	private CoroutineNode _perkLogicCor_P41;

	private CoroutineNode _talentLogicCor_D4;

	protected virtual int BuffId_Decibel_Empty => 0;

	protected virtual int BuffId_Decibel_Stack => 0;

	protected virtual int BuffId_Decibel_Max => 0;

	protected bool ShowDecibelPerformance
	{
		get
		{
			return _showDecibelPerformance;
		}
		set
		{
			if (value != _showDecibelPerformance)
			{
				_showDecibelPerformance = value;
				if (_showDecibelPerformance)
				{
					UpdateDecibelPerformance();
					return;
				}
				_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Empty);
				_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Stack);
				_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Max);
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		_showDecibelPerformance = false;
		_lastTriggerTime_PlayAddDecibelFx = 0;
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventHashCode == Config.eventHashCode_AddDecibel)
			{
				AddDecibel(adventureActorCustomEvent.intParam);
			}
			else if (adventureActorCustomEvent.eventHashCode == Config.eventHashCode_RemoveDecibel)
			{
				RemoveDecibel(adventureActorCustomEvent.boolParam, adventureActorCustomEvent.intParam);
			}
			OnReceiveCustomEvent(adventureActorCustomEvent);
		}
	}

	protected virtual void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
	}

	private void OnLevelStartFinish(IEvent _)
	{
		OnDecibelChange(isAdd: false, isConsume: false);
	}

	private void OnPlayerEnter(IEvent evt)
	{
		if (!(evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent) || !(adventurePlayerEnterEvent.player == _actor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			if (_talentLogicCor_D4 != null)
			{
				_actor.StopLogicCoroutine(_talentLogicCor_D4);
			}
			_talentLogicCor_D4 = _actor.StartLogicCoroutine(TalentLogic_D4(), runImmediately: true);
		}
		OnSelfEnter(adventurePlayerEnterEvent);
	}

	private IEnumerator TalentLogic_D4()
	{
		while (true)
		{
			yield return _actor.WaitTime(CommonUtils.GetScriptValue(_actor, 16096411));
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor)
			{
				playerAdventureActor.buffComponent.AddBuff(16096411, _actor);
			}
		}
	}

	protected virtual void OnSelfEnter(AdventurePlayerEnterEvent playerEnterEvent)
	{
	}

	private void OnPlayerLeave(IEvent evt)
	{
		if (!(evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent) || !(adventurePlayerLeaveEvent.player == _actor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			if (_talentLogicCor_D4 != null)
			{
				_actor.StopLogicCoroutine(_talentLogicCor_D4);
			}
			_talentLogicCor_D4 = null;
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(16096411);
			}
		}
		OnSelfLeave(adventurePlayerLeaveEvent);
	}

	protected virtual void OnSelfLeave(AdventurePlayerLeaveEvent playerLeaveEvent)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff getBuffEvent)
		{
			OnGetBuff(getBuffEvent);
		}
	}

	protected virtual void OnGetBuff(AdventureActorGetBuff getBuffEvent)
	{
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff removeBuffEvent)
		{
			OnRemoveBuff(removeBuffEvent);
		}
	}

	protected virtual void OnRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEndEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEndEvent) || !(sender == _actor))
		{
			return;
		}
		if (adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && CommonUtils.HavePersonalPerk(_actor.dataID, 516041, out var _))
		{
			if (_perkLogicCor_P41 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P41);
			}
			_perkLogicCor_P41 = _actor.StartLogicCoroutine(PerkLogic_P41(), runImmediately: true);
		}
		OnSelfCastSkillEnd(adventureActorCastSkillEndEvent);
	}

	private IEnumerator PerkLogic_P41()
	{
		int triggerCount = CommonUtils.GetScriptValue(_actor, 16041013).AsInt();
		FP triggerInterval = CommonUtils.GetScriptValue(_actor, 16041011);
		int decibelCount = CommonUtils.GetScriptValue(_actor, 16041012).AsInt();
		while (triggerCount > 0)
		{
			yield return _actor.WaitTime(triggerInterval);
			AddDecibel(decibelCount);
			triggerCount--;
		}
	}

	protected virtual void OnSelfCastSkillEnd(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor && adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor == _actor)
			{
				OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
			}
			OnBeforePlayerHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforePlayerHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent))
		{
			return;
		}
		if (playerAdventureActor == _actor)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_UltraSkill))
			{
				foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor.buffComponent.AddBuff(16094011, _actor);
				}
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516043, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P43))
			{
				to.buffComponent.AddBuff(16043011, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				to.buffComponent.AddBuff(16096511, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_AddWaterMark) && to.buffComponent.AddBuff(4011, _actor) != null && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
			{
				foreach (AdventureActor allPlayerActor2 in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor2.buffComponent.AddBuff(16096111, _actor);
				}
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && CommonUtils.CheckElementMark(CommonDefine.Water, to))
		{
			playerAdventureActor.buffComponent.AddBuff(16096311, _actor);
		}
		OnPlayerDamaged(adventureActorReceiveDamageEvent);
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor && adventureElementMarkTriggerEvent.markActor is MonsterAdventureActor monsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.WE)
			{
				monsterAdventureActor.buffComponent.AddBuff(16096211, _actor);
			}
			OnElementMarkTrigger(adventureElementMarkTriggerEvent);
		}
	}

	protected virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
	}

	protected void AddDecibel(int count = 0, bool useAddition = true, bool playFx = true)
	{
		if (count <= 0 || IsDecibelMax())
		{
			return;
		}
		if (useAddition)
		{
			count = (count * GetAddDecibelPercent()).AsInt();
		}
		_actor.buffComponent.AddBuffNum(16000001, count, _actor);
		if (playFx && ShowDecibelPerformance && (_lastTriggerTime_PlayAddDecibelFx <= 0 || _actor.LogicTime - _lastTriggerTime_PlayAddDecibelFx > Config.triggerCD_PlatAddDecibelFx))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, "fx_16001_base_Skill_Main_Energy_get", default, _actor.tsTransform.Position, default);
			_lastTriggerTime_PlayAddDecibelFx = _actor.LogicTime;
		}
		OnDecibelChange(isAdd: true, isConsume: false);
	}

	protected void RemoveDecibel(bool clear = false, int count = 0)
	{
		if ((clear || count > 0) && GetDecibelCount() > 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(16000001, (!clear) ? count : 0);
			OnDecibelChange(isAdd: false, isConsume: true);
		}
	}

	protected void ClearDecibel()
	{
		if (GetDecibelCount() > 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(16000001);
			OnDecibelChange(isAdd: false, isConsume: false);
		}
	}

	private void UpdateDecibelPerformance()
	{
		if (!ShowDecibelPerformance)
		{
			return;
		}
		if (_actor.buffComponent.CheckBuffByBuffID(16000001))
		{
			_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Empty);
			if (_actor.buffComponent.HaveBuffNumMax(16000001))
			{
				_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Stack);
				_actor.buffComponent.AddBuff(BuffId_Decibel_Max, _actor);
				return;
			}
			_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Max);
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(16000001);
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(BuffId_Decibel_Stack);
			int num = buffNumByID - buffNumByID2;
			if (num > 0)
			{
				_actor.buffComponent.AddBuffNum(BuffId_Decibel_Stack, num, _actor);
			}
			else if (num < 0)
			{
				_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Stack, -num);
			}
		}
		else
		{
			_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Max);
			_actor.buffComponent.RemoveBuffByBuffId(BuffId_Decibel_Stack);
			_actor.buffComponent.AddBuff(BuffId_Decibel_Empty, _actor);
		}
	}

	protected bool IsDecibelMax()
	{
		return _actor.buffComponent.HaveBuffNumMax(16000001);
	}

	protected int GetDecibelCount()
	{
		return _actor.buffComponent.GetBuffNumByID(16000001);
	}

	private FP GetAddDecibelPercent()
	{
		return 1;
	}

	protected virtual void OnDecibelChange(bool isAdd, bool isConsume)
	{
		UpdateDecibelPerformance();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeave);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		if (_perkLogicCor_P41 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P41);
		}
		_perkLogicCor_P41 = null;
		if (_talentLogicCor_D4 != null)
		{
			_actor.StopLogicCoroutine(_talentLogicCor_D4);
		}
		_talentLogicCor_D4 = null;
	}
}
