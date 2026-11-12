#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill3_LeiDian_P2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] LeiDian_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly ComboInputBuffer.ActionKey[] LeiDian_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private static readonly ComboInputBuffer.ActionKey[] LeiDian_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_4 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

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
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		GetAttackTarget();
		BeginLookAtByPos(new TSVector2(0, -1), 1, 700);
		BeginAttack(1, _LeiDianKey, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 505810099);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
