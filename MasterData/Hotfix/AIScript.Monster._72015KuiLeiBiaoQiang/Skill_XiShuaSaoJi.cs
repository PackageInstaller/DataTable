using System.Collections;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_XiShuaSaoJi : SkillSimpleBase
{
	private const string combo_Sweep = "Skill2";

	private FP sweepRadius = 4f;

	private FP sweepAngle = 180f;

	private const string warningAlias = "FX/Warning/fx_warning_fan_180c_4r";

	private FP windupTime = 2.4f;

	private FP warningDelay = 0.525f;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 2.5, AdventureActor.MovementMode.Run, 5);
				yield return WaitMoveStatus();
				StopMove();
			}
			BeginLookAt_NotWait(target, warningDelay, GetRotSpdInSkill());
			BeginAttack(1, "Skill2", flushInputedKeys: true);
			yield return WaitTime(warningDelay);
			StopWaitLookAt();
			Skill_XiShuaSaoJi skill_XiShuaSaoJi = this;
			float duration = (float)(windupTime - warningDelay);
			TSVector2 position = GetPosition();
			FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
			skill_XiShuaSaoJi.PlayEarlyWarningEffect("FX/Warning/fx_warning_fan_180c_4r", duration, default, position, tSVectToAngle);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
