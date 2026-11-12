#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._11501;

public class SkillScript_NormalAttack_Support : SkillAdvancedBase
{
	private int _stage;

	private List<string> _curComboTagList;

	private string _comboTag;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		if (_stage < 0)
		{
			NovaLogger.Error($"非法的普攻段数:{_stage}");
			OnFinish();
			return;
		}
		_curComboTagList = Config_Support.comboTagList_NormalAttack;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511523, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			_curComboTagList = Config_Support.comboTagList_NormalAttack_P23;
		}
		_comboTag = ((_stage < _curComboTagList.Count) ? _curComboTagList.get_Item(_stage) : null);
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			NovaLogger.Error($"该普攻段数未配置,普攻段数:{_stage}");
			OnFinish();
			return;
		}
		string comboTag = _comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < _curComboTagList.Count) ? num : 0);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "115_SupportAttack") || !CommonUtils.HavePersonalPerk(_actor.dataID, 511524, out var _))
		{
			return;
		}
		CommonUtils.TryParseStringParamToInt(((PlayerAdventureActor)_actor).GetLocalData("HitTimes_P24"), out var intValue);
		intValue++;
		if (intValue >= 8)
		{
			((PlayerAdventureActor)_actor).SetLocalData("HitTimes_P24", "0");
			if (ILRuntimeAPI.CreateSkill(11532003, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
			{
				OnFinish();
			}
		}
		else
		{
			((PlayerAdventureActor)_actor).SetLocalData("HitTimes_P24", intValue.ToString());
		}
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_stage = 0;
		_comboTag = null;
	}
}
