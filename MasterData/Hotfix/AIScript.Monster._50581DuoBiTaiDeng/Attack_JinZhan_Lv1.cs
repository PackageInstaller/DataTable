using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Attack_JinZhan_Lv1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected int keyIndex = 1;

	protected override void OnSkillEnable()
	{
		FP randomValue = GetRandomValue(1, 4, isInt: true);
		if (randomValue == 1)
		{
			_actionKey = Attack_1;
		}
		else if (randomValue == 2)
		{
			_actionKey = Attack_2;
		}
		else
		{
			_actionKey = Attack_3;
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
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(keyIndex, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		keyIndex++;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
