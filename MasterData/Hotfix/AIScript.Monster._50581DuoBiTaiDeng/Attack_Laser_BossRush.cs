using System.Collections;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Attack_Laser_BossRush : SkillSimpleBase
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
		if (!(target == null))
		{
			int[] array = new int[3] { 1802659152, 1701336156, 1113548141 };
			int[] array2 = array;
			foreach (int attackIndex in array2)
			{
				BeginLookAt_NotWait(target, 0.2, 400);
				yield return WaitTime(0.2);
				BeginAttack(attackIndex, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAt_NotWait(target, 1, 120);
				yield return WaitTime(2.5);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			yield return WaitTime(4);
		}
	}
}
