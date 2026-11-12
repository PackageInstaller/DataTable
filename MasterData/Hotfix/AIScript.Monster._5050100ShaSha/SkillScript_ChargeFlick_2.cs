using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_ChargeFlick_2 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected FP RotateSpeed = 150;

	protected FP recoveryRotateSpeed = 40;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
