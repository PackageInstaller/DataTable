using System;
using System.Collections.Generic;

namespace AIScript.Character._14501;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk_1",
		[2] = "Atk_2",
		[3] = "Atk_3"
	};

	private int atkIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		atkIndex = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string actionTag = dicKey.get_Item(atkIndex);
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
	}
}
