using System;

namespace AIScript.Monster.Soldier._139;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[5];

	private readonly ComboInputBuffer.ActionKey[] actionKeys_HasBuff = new ComboInputBuffer.ActionKey[5]
	{
		(ComboInputBuffer.ActionKey)1096774245,
		(ComboInputBuffer.ActionKey)1701406819,
		(ComboInputBuffer.ActionKey)1701668214,
		(ComboInputBuffer.ActionKey)1281324142,
		(ComboInputBuffer.ActionKey)1663971958
	};

	public const int buffId_Trigger = 250105101;

	public void OnStart()
	{
		if (_actor.buffComponent != null && _actor.buffComponent.CheckBuffByBuffID(250105101))
		{
			ComboInputBuffer.ActionKey[] keys = actionKeys_HasBuff;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			ComboInputBuffer.ActionKey[] keys2 = actionKeys;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(keys2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onInterrupt, onComboFinish);
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
		_skill.Clear();
	}
}
