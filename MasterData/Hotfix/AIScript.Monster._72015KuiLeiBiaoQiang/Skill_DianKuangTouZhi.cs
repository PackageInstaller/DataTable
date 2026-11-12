using System.Collections;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_DianKuangTouZhi : SkillSimpleBase
{
	private const string combo_Throw = "Skill1";

	private int loopCount = 1;

	private FP throwRadius = 1.5f;

	private const string warningAlias = "FX/Warning/fx_warning_circular_1";

	private const string area_throw = "AreaEffect_72015_Skill2_TouZhi";

	private FP warningDuration = 2.75f;

	private FP throwBufferTime = 0f;

	private long warningFxId;

	private long areaEffectId;

	private TSVector2 trapPos;

	private int loopIndex;

	protected override IEnumerator DoMainLogic()
	{
		loopIndex = 0;
		LogicEntity target = GetAttackTarget();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 8, AdventureActor.MovementMode.Run, 5);
				yield return WaitMoveStatus();
				StopMove();
			}
			BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
			BeginAttack(1, "Skill1", flushInputedKeys: true);
			StartCor(TargetedWarningCor(target));
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopLookAt();
		StopAreaEffect(areaEffectId);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		loopIndex++;
		if (loopIndex >= loopCount)
		{
			StartCor(StopLookAtDelay(0.3f));
			CancelAttack();
		}
	}

	private IEnumerator StopLookAtDelay(FP delay)
	{
		yield return WaitTime(delay);
		StopLookAt();
	}

	private IEnumerator TargetedWarningCor(LogicEntity target)
	{
		Skill_DianKuangTouZhi skill_DianKuangTouZhi = this;
		Skill_DianKuangTouZhi skill_DianKuangTouZhi2 = this;
		float duration = (float)warningDuration;
		TSVector2 entityPosition = GetEntityPosition(target);
		float spawnSize = (float)throwRadius;
		skill_DianKuangTouZhi.warningFxId = skill_DianKuangTouZhi2.PlayEarlyWarningEffect("FX/Warning/fx_warning_circular_1", duration, default, entityPosition, default, spawnSize);
		FP elapsed = 0;
		FP lockBeforeEnd = 0.3f;
		bool posLocked = false;
		for (; elapsed < warningDuration; elapsed += (FP)0.03f)
		{
			if (!posLocked && elapsed >= warningDuration - lockBeforeEnd)
			{
				posLocked = true;
			}
			if (!posLocked)
			{
				trapPos = GetEntityPosition(target);
				ModifyEffectPosition(warningFxId, trapPos);
			}
			yield return WaitTime(0.03);
		}
		ModifyEffectPosition(warningFxId, trapPos);
		yield return null;
		CompleteEarlyWarningEffect(warningFxId);
		yield return WaitTime(throwBufferTime);
		areaEffectId = PlayAreaEffect("AreaEffect_72015_Skill2_TouZhi", trapPos, GetTSVectToAngle(GetForward(), 0));
	}
}
