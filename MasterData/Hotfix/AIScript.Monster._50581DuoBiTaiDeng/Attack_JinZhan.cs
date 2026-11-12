using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Attack_JinZhan : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected int keyIndex = 1;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		List<ComboInputBuffer.ActionKey[]> attacks = new List<ComboInputBuffer.ActionKey[]> { Attack_1, Attack_2, Attack_3 };
		attacks = attacks.OrderBy((ComboInputBuffer.ActionKey[] x) => TSRandom.CallNext()).ToList();
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		foreach (ComboInputBuffer.ActionKey[] attack in attacks)
		{
			BeginLookAt_NotWait(target, 0.4, 300);
			yield return WaitTime(0.4);
			BeginAttack(keyIndex, attack, flushInputedKeys: true, forceInterruptAttack: true);
			AimAtTarget(target, 280);
			yield return WaitTime(0.3);
			CancelAim();
			keyIndex++;
			yield return WaitCombo(ComboAttackType.isComboFinish);
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 6)
			{
				break;
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
