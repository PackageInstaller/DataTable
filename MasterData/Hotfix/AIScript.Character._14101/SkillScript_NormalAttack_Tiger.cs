using System;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_NormalAttack_Tiger : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackStage_Tiger");
		num = TSMath.Clamp(num, 0, Config_Support.comboTagList_NormalAttack_Tiger.Count - 1).AsInt();
		string actionTag = Config_Support.comboTagList_NormalAttack_Tiger.get_Item(num);
		LogicEntity monsterTarget = _actor.monsterTarget;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, monsterTarget, null, default, null, null, onComboFinish, onInterrupt);
		int num2 = num + 1;
		num2 = ((num2 < Config_Support.comboTagList_NormalAttack_Tiger.Count) ? num2 : 0);
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage_Tiger", num2);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
