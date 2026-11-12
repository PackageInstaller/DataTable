using System.Collections;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_KuiLeiDunCi : SkillSimpleBase
{
	private const string combo_Attack = "NormalAttack";

	private FP stabPause = 0.2f;

	private const string warningAlias = "FX/Warning/fx_warning_square_3side_p_2x4";

	private FP warningScale = 1f;

	private FP windupTime = 1f;

	private FP warningDelay = 0.1f;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 2, AdventureActor.MovementMode.Run, 5);
				BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
				yield return WaitMoveStatus();
				StopMove();
				StopWaitLookAt();
			}
			BeginLookAt_NotWait(target, warningDelay, GetRotSpdInSkill());
			BeginAttack(1, "NormalAttack", flushInputedKeys: true);
			yield return WaitTime(warningDelay);
			StopWaitLookAt();
			Skill_KuiLeiDunCi skill_KuiLeiDunCi = this;
			float duration = (float)(windupTime - warningDelay);
			TSVector2 position = GetPosition();
			FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
			float spawnSize = (float)warningScale;
			skill_KuiLeiDunCi.PlayEarlyWarningEffect("FX/Warning/fx_warning_square_3side_p_2x4", duration, default, position, tSVectToAngle, spawnSize);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
