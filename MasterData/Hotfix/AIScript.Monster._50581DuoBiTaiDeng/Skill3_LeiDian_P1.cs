#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill3_LeiDian_P1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] LeiDian_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly ComboInputBuffer.ActionKey[] LeiDian_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly ComboInputBuffer.ActionKey[] LeiDian_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected ComboInputBuffer.ActionKey[] _LeiDianKey;

	protected int keyIndex = 2;

	protected override void OnSkillEnable()
	{
		FP randomValue = GetRandomValue(1, 4, isInt: true);
		if (randomValue == 1)
		{
			_LeiDianKey = LeiDian_1;
		}
		else if (randomValue == 2)
		{
			_LeiDianKey = LeiDian_2;
		}
		else
		{
			_LeiDianKey = LeiDian_3;
		}
		NovaLogger.Debug($"按键: {_LeiDianKey[0]}");
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		BeginLookAtByPos(new TSVector2(0, -1), 1, 700);
		BeginAttack(1, _LeiDianKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
