#define LOG_ERROR
using System;

namespace AIScript.Character._15801;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	private string _comboTag;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		_comboTag = ((_stage < Config.comboTagList_NormalAttack.Count) ? Config.comboTagList_NormalAttack.get_Item(_stage) : null);
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
