using System;

namespace AIScript.Character._11501;

public class SkillScript_NormalAttack_Single_MainControl : SkillScript_FunnelFire_MainControl
{
	private int _stage;

	private string _comboTag;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		_comboTag = ((_stage < Config_MainControl.comboTagList_Single.Count) ? Config_MainControl.comboTagList_Single.get_Item(_stage) : null);
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			OnFinish();
			return;
		}
		string comboTag = _comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack?.InterruptAttack();
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
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < Config_MainControl.comboTagList_Single.Count) ? num : 0);
		_comboTag = null;
		_stage = 0;
	}
}
