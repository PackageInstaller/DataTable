using System;
using System.Runtime.CompilerServices;

namespace AIScript.Monster.Soldier._113;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] comboTag = new ComboInputBuffer.ActionKey[3];

	private readonly ComboInputBuffer.ActionKey[] actionKeys_HasBuff;

	public void OnStart()
	{
		if (_actor.buffComponent != null && _actor.buffComponent.CheckBuffByBuffID(250104201))
		{
			ComboInputBuffer.ActionKey[] keys = actionKeys_HasBuff;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			ComboInputBuffer.ActionKey[] keys2 = comboTag;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(keys2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
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

	public NormalSkill()
	{
		//IL_0019: Field data (rva=0x5b0) could not be found in any section!
		//IL_0019: Field data (rva=0x5b0) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._11047585FE102FBB5CADB42446612A578D88C6EF5ED076BB7AC360C4F9E4373D));
		actionKeys_HasBuff = array;
		base._002Ector();
	}
}
