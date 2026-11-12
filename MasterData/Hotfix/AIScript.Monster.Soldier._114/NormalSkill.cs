using System;

namespace AIScript.Monster.Soldier._114;

public class NormalSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Atk";

	private readonly string comboTag_State1 = "Atk_N";

	private readonly string comboTag_State2 = "Atk_P";

	public void OnStart()
	{
		string actionTag = GetComboTag();
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private string GetComboTag()
	{
		BuffCom buffComponent = _actor.buffComponent;
		if (buffComponent == null)
		{
			return comboTag;
		}
		if (buffComponent.CheckBuffByBuffID(250105502))
		{
			return comboTag_State2;
		}
		if (buffComponent.CheckBuffByBuffID(250105501))
		{
			return comboTag_State1;
		}
		return comboTag;
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
