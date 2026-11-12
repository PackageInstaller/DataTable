using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class ParallelScript_MainControl : ParallelScript
{
	private PlayerSkillCd _playerSkillCd;

	private bool _isLevelStartFinish;

	private FP _lastTriggerTime_P7;

	private int _triggerTimes_P9;

	public override void OnEnable()
	{
		base.OnEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		int perkLevel;
		if (CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPersonalPerk_P1 ", CommonUtils.HavePersonalPerk(_actor.dataID, 513901, out perkLevel));
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513907, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13907012, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513908, out perkLevel))
			{
				_actor.buffComponent.AddBuff(0, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513913, out perkLevel))
		{
			int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.WE);
			if (playerActorCountByElement > 0)
			{
				_actor.buffComponent.AddBuffNum(13913011, playerActorCountByElement, _actor);
			}
		}
		((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: true);
		_isLevelStartFinish = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ADD_SHIELD", OnAddShield);
	}

	private void OnLevelStartFinish(IEvent _)
	{
		if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 "))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(13900001);
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(13900002, buffNumByID, _actor);
				_actor.buffComponent.RemoveBuffByBuffId(13900001);
			}
		}
		_isLevelStartFinish = true;
		OnSoulCountChange();
	}

	protected override void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
		base.OnReceiveCustomEvent(customEvent);
		if (customEvent.eventHashCode == Config_MainControl.eventHashCode_AddSoul)
		{
			AddSoul(customEvent.intParam);
		}
		else if (customEvent.eventHashCode == Config_MainControl.eventHashCode_RemoveSoul)
		{
			RemoveSoul(customEvent.boolParam, customEvent.intParam);
		}
	}

	private void AddSoul(int soulCount)
	{
		if (soulCount <= 0)
		{
			return;
		}
		if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 "))
		{
			if (_actor.buffComponent.CheckBuffByBuffID(13900003))
			{
				_actor.buffComponent.RemoveBuffByBuffId(13900003, soulCount);
			}
			_actor.buffComponent.AddBuffNum(13900002, soulCount, _actor);
		}
		else
		{
			_actor.buffComponent.AddBuffNum(13900001, soulCount, _actor);
		}
	}

	private void RemoveSoul(bool removeAll, int soulCount)
	{
		if (removeAll || soulCount > 0)
		{
			if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 "))
			{
				_actor.buffComponent.RemoveBuffByBuffId(13900002, (!removeAll) ? soulCount : 0);
			}
			else
			{
				_actor.buffComponent.RemoveBuffByBuffId(13900001, (!removeAll) ? soulCount : 0);
			}
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513905, out var _))
		{
			SkillEventInfo skillEventInfo = castSkillEvent.skillEventInfo;
			if (skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || CheckIsSecondStageUltraSkill(skillEventInfo))
			{
				_actor.buffComponent.AddBuff(13905011, _actor);
			}
		}
	}

	protected override void OnSelfCastSkillEnd(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
		base.OnSelfCastSkillEnd(castSkillEndEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513907, out var _) && CheckIsSecondStageUltraSkill(castSkillEndEvent.skillEventInfo) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && (_lastTriggerTime_P7 <= 0 || _actor.LogicTime - _lastTriggerTime_P7 > CommonUtils.GetScriptValue(_actor, 13907013)))
		{
			_lastTriggerTime_P7 = _actor.LogicTime;
			_actor.buffComponent.AddBuff(13907001, _actor);
		}
	}

	private bool CheckIsSecondStageUltraSkill(SkillEventInfo skillEventInfo)
	{
		if (skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.D)
		{
			return false;
		}
		if (skillEventInfo.skillId == 13940001)
		{
			return true;
		}
		if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 ") && skillEventInfo.skillId == 13931002)
		{
			return true;
		}
		return false;
	}

	protected override void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
		base.OnSelfGetBuff(getBuffEvent);
		int perkLevel;
		if (getBuffEvent.eventInfo.buffTags.Contains(Config.buffTag_FirstStage_UltraSkill) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE))
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, !CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out perkLevel));
		}
		if (_isLevelStartFinish && getBuffEvent.eventInfo.buffTags.Contains(Config_MainControl.buffTag_Soul))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513906, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13906011, _actor);
			}
			OnSoulCountChange();
		}
	}

	protected override void OnSelfRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
		base.OnSelfRemoveBuff(removeBuffEvent);
		if (removeBuffEvent.eventInfo.buffTags.Contains(Config.buffTag_FirstStage_UltraSkill))
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: true);
		}
		if (!_isLevelStartFinish)
		{
			return;
		}
		if (removeBuffEvent.eventInfo.buffTags.Contains(Config.buffTag_FirstStage_UltraSkill) && !_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var perkLevel))
			{
				_actor.buffComponent.RemoveBuffByTag(Config_MainControl.buffTag_P3);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513909, out perkLevel))
			{
				_triggerTimes_P9 = 0;
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(13909011);
				if (buffNumByID > 0)
				{
					_actor.buffComponent.RemoveBuffByBuffId(13909011);
					AddSoul(buffNumByID);
				}
			}
		}
		if (removeBuffEvent.eventInfo.buffTags.Contains(Config_MainControl.buffTag_Soul))
		{
			OnSoulCountChange();
		}
	}

	private void OnSoulCountChange()
	{
		RefreshSkillState();
	}

	private void RefreshSkillState()
	{
		if (_actor.buffComponent.HaveBuffNumMax(0, 0, Config_MainControl.buffTag_Soul))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var _))
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13931001);
			}
			else if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 "))
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13931002);
			}
			else
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13931000);
			}
		}
		else
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13931000);
		}
	}

	private void OnAddShield(IEvent evt)
	{
		if (evt is AdventureActorAddShield adventureActorAddShield && adventureActorAddShield.to == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 513911, out var _))
		{
			_actor.buffComponent.AddBuff(13911011, _actor);
		}
	}

	protected override bool OverrideHitDamageId(IList<int> hitDamageTag, int hitDamageId, out int overrideHitDamageId)
	{
		overrideHitDamageId = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513905, out var perkLevel) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_Trigger_P5) && Config_MainControl.hitDamageIdMapping_P5.TryGetValue(hitDamageId, out overrideHitDamageId))
		{
			return true;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513908, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_Trigger_P8) && Config_MainControl.hitDamageIdMapping_P8.TryGetValue(hitDamageId, out overrideHitDamageId))
		{
			return true;
		}
		return false;
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513902, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P2))
		{
			int buffNum = _actor.buffComponent.GetBuffNum(0, 0, Config_MainControl.buffTag_Soul);
			if (buffNum > 0)
			{
				AdventureActor.AddFromAttr(13902011, _actor, buffNum);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513906, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P6))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(13906011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(13906001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513910, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P10))
		{
			AdventureActor.AddFromAttr(13910001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_GetSoul_Skill) && !_actor.logicVariable.GetLogicTagToggle("SkillHasGetSoul") && (!CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var perkLevel) || !_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill)))
		{
			_actor.logicVariable.ToggleLogicTag("SkillHasGetSoul", value: true);
			AddSoul(1);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513912, out perkLevel) && damageEvent.damageType == HotfixEnum.damageType.MARK)
		{
			_actor.buffComponent.AddBuff(13912011, _actor);
		}
	}

	protected override bool ExtraCheckTriggerWaterMarkHitTag(IList<int> hitDamageTag)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513910, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.WE) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
		{
			return CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_TriggerWaterMark_P10);
		}
		return base.ExtraCheckTriggerWaterMarkHitTag(hitDamageTag);
	}

	protected override void TriggerTide(MonsterAdventureActor monster)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513904, out var _))
		{
			if (_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
			{
				if (monster.buffComponent.GetBuffNumByID(4031) % CommonUtils.GetScriptValue(_actor, 13904011).AsInt() == 0)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13901_WaterTrigger_P04", monster.tsTransform.Position);
					OnTriggerTide();
				}
				if (monster.buffComponent.HaveBuffNumMax(4031))
				{
					monster.buffComponent.RemoveBuffByBuffId(4031);
				}
			}
			else
			{
				base.TriggerTide(monster);
			}
		}
		else
		{
			base.TriggerTide(monster);
		}
	}

	protected override void OnTriggerTide()
	{
		base.OnTriggerTide();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513909, out var _) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
		{
			_triggerTimes_P9++;
			if (_triggerTimes_P9 >= CommonUtils.GetScriptValue(_actor, 13909001).AsInt())
			{
				_triggerTimes_P9 = 0;
				_actor.buffComponent.AddBuff(13909011, _actor);
				_actor.buffComponent.AddBuff(13909012, _actor);
			}
		}
	}

	private void Clear()
	{
		_isLevelStartFinish = false;
		_lastTriggerTime_P7 = 0;
		_triggerTimes_P9 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ADD_SHIELD", OnAddShield);
		Clear();
	}
}
