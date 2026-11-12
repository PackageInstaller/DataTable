using System.Collections;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_PuTongSheJi : SkillSimpleBase
{
	private const string combo_Attack = "NormalAttack";

	private int loopCount = 1;

	private float warningDelay = 0.5f;

	private const string warningAlias = "FX/Warning/fx_warning_line_0_5h_15m";

	private const float warningScale = 2f;

	private long fxWarningLine;

	private int loopIndex;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(fxWarningLine);
	}

	protected override IEnumerator DoMainLogic()
	{
		loopIndex = 0;
		LogicEntity target = GetAttackTarget();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 12, AdventureActor.MovementMode.Run, 5);
				yield return WaitMoveStatus();
				StopMove();
			}
			BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
			BeginAttack(1, "NormalAttack", flushInputedKeys: true);
			yield return WaitTime(warningDelay);
			fxWarningLine = PlayEffect("FX/Warning/fx_warning_line_0_5h_15m", 1f, default, default, default, 2f);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected override void OnComboLoop(int comboIndex)
	{
		loopIndex++;
		if (loopIndex >= loopCount)
		{
			StopEffect(fxWarningLine);
			StopLookAt();
			CancelAttack();
		}
	}
}
