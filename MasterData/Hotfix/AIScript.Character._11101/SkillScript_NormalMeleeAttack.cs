using System;
using AIScript.Utils;

namespace AIScript.Character._11101;

public class SkillScript_NormalMeleeAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			CommonUtils.GetAssistantAttackTarget(_actor);
		}
		else
		{
			_ = _actor.attackTarget;
		}
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}
}
