using System.Collections;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_ChargeAttack : SkillSimpleBase
{
	private bool breakOff;

	private long fxWarningLine;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
		breakOff = false;
	}

	protected override void OnSkillDisable()
	{
		if (breakOff)
		{
			StopEffect(fxWarningLine);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		fxWarningLine = WarningLine();
		yield return WaitLookAt(GetAttackTarget(), 2, GetRotSpdInSkill() * 0.4);
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1));
		PlayEffect("AttackHint", 0.8f, 1, position);
		yield return WaitTime(0.5);
		StopEffect(fxWarningLine);
		breakOff = false;
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private long WarningLine()
	{
		long result = PlayEffect("fx_m50551cancha_loop_redline_common");
		breakOff = true;
		return result;
	}
}
