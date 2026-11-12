#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Character._14001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	private List<string> _comboTagList;

	private string _comboTag;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		_comboTagList = Config.comboTagList_NormalAttack;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514023, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514028, out perkLevel))
			{
				_comboTagList = Config_Support.comboTagList_NormalAttack_P23_P28;
			}
			else
			{
				_comboTagList = Config_Support.comboTagList_NormalAttack_P23;
			}
		}
		_comboTag = ((_stage < _comboTagList.Count) ? _comboTagList.get_Item(_stage) : null);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
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
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < Config.comboTagList_NormalAttack.Count) ? num : 0);
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
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
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		_stage = 0;
		_comboTag = null;
	}
}
