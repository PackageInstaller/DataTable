using System.Collections;
using AIScript.Monster.Trap;
using TrueSync;

namespace AIScript.Monster._99091SawTrap;

public class Skill_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly string FXAlias = "Actor/Monster/99051FlameTrap/FX/fx_99051FlameTrap_Attack_start_Prologue";

	private TSVector2 FXPosition;

	private FP FXRotation;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		if (_actor == null)
		{
			FXPosition = TSVector2.zero;
		}
		else
		{
			FXPosition = GetEntityPositionObsoleted(_actor);
		}
		if (_actor == null)
		{
			FXRotation = 0;
		}
		else
		{
			FXRotation = GetEntityAngle(_actor);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(2);
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(99999);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
