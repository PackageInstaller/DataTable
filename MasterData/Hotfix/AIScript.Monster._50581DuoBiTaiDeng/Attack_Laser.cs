using System.Collections;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Attack_Laser : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505810099))
		{
			_actionKey = Attack_2;
		}
		else
		{
			_actionKey = Attack_1;
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 1, 120);
		yield return WaitTime(5.0);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
