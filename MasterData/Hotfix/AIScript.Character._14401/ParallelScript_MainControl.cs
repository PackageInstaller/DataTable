using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class ParallelScript_MainControl : ParallelScript
{
	private PlayerSkillCd _playerSkillCd;

	private FP _lastTriggerTime_P5;

	private FP _lastTriggerTime_P6;

	private int _triggerTimes_P7;

	private CoroutineNode _triggerCDCor_P7;

	private bool _triggerPerk_P13;

	private bool TriggerPerk_P13
	{
		get
		{
			return _triggerPerk_P13;
		}
		set
		{
			if (_triggerPerk_P13 != value)
			{
				_triggerPerk_P13 = value;
				if (_triggerPerk_P13)
				{
					_actor.buffComponent.AddBuff(14413011, _actor);
				}
				else
				{
					_actor.buffComponent.RemoveBuffByBuffId(14413011);
				}
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		UpdateSkillInfo();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnterBattle);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeaveBattle);
	}

	private void UpdateSkillInfo()
	{
		if (string.Equals(((PlayerAdventureActor)_actor).GetLocalData("IsStrengthSkill"), bool.TrueString))
		{
			SwitchSkillToStrength();
		}
		else
		{
			SwitchSkillToNormal();
		}
		_playerSkillCd.SetSkillTotalSection(ActionKey.A, GetDodgeSkillTotalSection(), forceMaxSection: true);
		_playerSkillCd.SetSkillTotalSection(ActionKey.B, GetSkillTotalSection(), forceMaxSection: true);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514404, out var _))
		{
			_playerSkillCd.ModifySectionResumeTimeAmend(-Config_MainControl.reduceSkillCD_P4, ActionKey.B);
		}
		else
		{
			_playerSkillCd.ResetSectionResumeTimeAmend(ActionKey.B);
		}
	}

	private int GetSkillTotalSection()
	{
		int originalTotalSectionAmount = _playerSkillCd.GetSkillCD(ActionKey.B).originalTotalSectionAmount;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514410, out var _))
		{
			return originalTotalSectionAmount + 1;
		}
		return originalTotalSectionAmount;
	}

	private int GetDodgeSkillTotalSection()
	{
		int originalTotalSectionAmount = _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var _))
		{
			return originalTotalSectionAmount + 1;
		}
		return originalTotalSectionAmount;
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		switch (castSkillEvent.skillEventInfo.skillId)
		{
		case 14431000:
		{
			int normalSkillUseTimes = GetNormalSkillUseTimes();
			normalSkillUseTimes++;
			int num = 2;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514403, out var _))
			{
				num = 1;
			}
			if (normalSkillUseTimes >= num)
			{
				SwitchSkillToStrength();
			}
			SetNormalSkillUseTimes(normalSkillUseTimes);
			break;
		}
		case 14431001:
			SwitchSkillToNormal();
			SetNormalSkillUseTimes(0);
			break;
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514407, out var perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			TryTriggerPerkLogic_P7(attackEvent.to);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514409, out perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_MainControl.damageTag_SkillTrigger_P9) && attackEvent.to is MonsterAdventureActor monsterAdventureActor && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			SwitchSkillToStrength();
			SetNormalSkillUseTimes(0);
		}
	}

	protected override void OnSelfSummonedAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfSummonedAttacked(attackEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514407, out var _) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			TryTriggerPerkLogic_P7(attackEvent.to);
		}
	}

	private void TryTriggerPerkLogic_P7(LogicEntity target)
	{
		if (target == null)
		{
			return;
		}
		if (_triggerTimes_P7 < CommonUtils.GetScriptValue(_actor, 14407013))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14407011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				string text = Config_MainControl.areaEffectKeyList_P7.get_Item(TSRandom.Range(0, Config_MainControl.areaEffectKeyList_P7.Count));
				if (!string.IsNullOrEmpty(text))
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, text, target.tsTransform.Position);
				}
				_triggerTimes_P7++;
			}
		}
		if (_triggerCDCor_P7 == null)
		{
			_triggerCDCor_P7 = _actor.StartLogicCoroutine(PerkLogic_P7());
		}
	}

	private IEnumerator PerkLogic_P7()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(CommonUtils.GetScriptValue(_actor, 14407012)));
		_triggerTimes_P7 = 0;
		_triggerCDCor_P7 = null;
	}

	protected override void OnSelfBeAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfBeAttacked(attackEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514412, out var _))
		{
			_actor.buffComponent.AddBuff(14412011, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514402, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P2))
		{
			AdventureActor.AddFromAttr(14402011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514404, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			AdventureActor.AddFromAttr(14404011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddDamage_P5) && _actor.buffComponent.CheckBuffByBuffID(14405011))
		{
			AdventureActor.AddFromAttr(14405001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514406, out perkLevel))
		{
			int num = 0;
			if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddDamage_P6))
			{
				num = _actor.buffComponent.GetBuffNumByID(14406012);
			}
			else if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddDamage_P2_P6))
			{
				num = _actor.buffComponent.GetBuffNumByID(14406012);
				if (num <= 0)
				{
					num = _actor.logicVariable.GetLogicTagValue("AdditionalAttrCount_P2_P6").AsInt();
				}
			}
			if (num > 0)
			{
				AdventureActor.AddFromAttr(14406001, _actor, num);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514408, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14408011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(14408001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514409, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_DamageTrigger_P9))
		{
			AdventureActor.AddFromAttr(14409001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514410, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P10))
		{
			AdventureActor.AddFromAttr(14410001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddBuff_P5) && (_lastTriggerTime_P5 <= 0 || _actor.LogicTime - _lastTriggerTime_P5 > Config_MainControl.triggerCD_AddBuff_P5))
		{
			_actor.buffComponent.AddBuffNum(14405011, 5, _actor);
			_lastTriggerTime_P5 = _actor.LogicTime;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514406, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddBuff_P6))
		{
			_actor.buffComponent.AddBuff(14406011, _actor);
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14406011);
			if (_lastTriggerTime_P6 <= 0 || _actor.LogicTime - _lastTriggerTime_P6 > scriptValue)
			{
				_actor.buffComponent.AddBuff(14406012, _actor);
				_lastTriggerTime_P6 = _actor.LogicTime;
			}
		}
	}

	protected override void OnKillTarget(AdventureActorDiedEvent diedEvent)
	{
		base.OnKillTarget(diedEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514409, out var _) && CommonUtils.CheckHitByTag(diedEvent.damageTag, Config_MainControl.damageTag_SkillTrigger_P9))
		{
			SwitchSkillToStrength();
			SetNormalSkillUseTimes(0);
		}
	}

	private void OnPlayerEnterBattle(IEvent evt)
	{
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514413, out var _) || TriggerPerk_P13)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.isAssist && actorL.actived && actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				TriggerPerk_P13 = true;
				break;
			}
		}
	}

	private void OnPlayerLeaveBattle(IEvent evt)
	{
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514413, out var _) || !TriggerPerk_P13)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.isAssist && actorL.actived && actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				return;
			}
		}
		TriggerPerk_P13 = false;
	}

	private int GetNormalSkillUseTimes()
	{
		if (CommonUtils.TryParseStringParamToInt(((PlayerAdventureActor)_actor).GetLocalData("UseNormalSkillTimes"), out var intValue))
		{
			return intValue;
		}
		return 0;
	}

	private void SetNormalSkillUseTimes(int times)
	{
		((PlayerAdventureActor)_actor).SetLocalData("UseNormalSkillTimes", times.ToString());
	}

	private void SwitchSkillToNormal()
	{
		if (_playerSkillCd.GetCurrentBindSkillId(ActionKey.B) != 14431000)
		{
			((PlayerAdventureActor)_actor).playerSkillCd.BindSkillIdToButton(ActionKey.B, 14431000);
			SkillInfo skillCD = _playerSkillCd.GetSkillCD(14431000);
			SkillInfo skillCD2 = _playerSkillCd.GetSkillCD(14431001);
			if (skillCD != null && skillCD2 != null)
			{
				skillCD.sectionResumeTime = skillCD2.sectionResumeTime;
				skillCD.sectionResumeTimePercentAmend = skillCD2.sectionResumeTimePercentAmend;
				skillCD.sectionResumeTimeAmend = skillCD2.sectionResumeTimeAmend;
				skillCD.currentResumeTime = skillCD2.currentResumeTime;
				skillCD.totalSectionAmount = skillCD2.totalSectionAmount;
				skillCD.currentSectionAmount = skillCD2.currentSectionAmount;
				skillCD.beginResume = true;
				_playerSkillCd.DoSyncSkillBtnToLua(skillCD);
			}
			((PlayerAdventureActor)_actor).SetLocalData("IsStrengthSkill", bool.FalseString);
		}
	}

	private void SwitchSkillToStrength()
	{
		if (_playerSkillCd.GetCurrentBindSkillId(ActionKey.B) != 14431001)
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 14431001);
			SkillInfo skillCD = _playerSkillCd.GetSkillCD(14431000);
			SkillInfo skillCD2 = _playerSkillCd.GetSkillCD(14431001);
			if (skillCD != null && skillCD2 != null)
			{
				skillCD2.sectionResumeTime = skillCD.sectionResumeTime;
				skillCD2.sectionResumeTimePercentAmend = skillCD.sectionResumeTimePercentAmend;
				skillCD2.sectionResumeTimeAmend = skillCD.sectionResumeTimeAmend;
				skillCD2.currentResumeTime = skillCD.currentResumeTime;
				skillCD2.totalSectionAmount = skillCD.totalSectionAmount;
				skillCD2.currentSectionAmount = skillCD.currentSectionAmount;
				skillCD2.beginResume = true;
				_playerSkillCd.DoSyncSkillBtnToLua(skillCD2);
			}
			((PlayerAdventureActor)_actor).SetLocalData("IsStrengthSkill", bool.TrueString);
		}
	}

	private void Clear()
	{
		_lastTriggerTime_P5 = 0;
		_lastTriggerTime_P6 = 0;
		_triggerTimes_P7 = 0;
		if (_triggerCDCor_P7 != null)
		{
			_actor.StopLogicCoroutine(_triggerCDCor_P7);
		}
		_triggerCDCor_P7 = null;
		TriggerPerk_P13 = false;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnterBattle);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnPlayerLeaveBattle);
		Clear();
	}
}
