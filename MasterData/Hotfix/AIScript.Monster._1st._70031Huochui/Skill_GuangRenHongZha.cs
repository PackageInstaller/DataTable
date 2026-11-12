using System.Collections;
using TrueSync;

namespace AIScript.Monster._1st._70031Huochui;

public class Skill_GuangRenHongZha : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string BladeEffect_Event = "BladeEffect";

	private static readonly string DiffuseRing_Event = "DiffuseRing";

	private static readonly string EndRing_Event = "EndRing";

	private readonly string BladeEffect = "fx_70031HuoChui_loop_Skill_04_1st_Loop_blade";

	private static readonly string DiffuseRingArea = "1st_Skill_04_GuangRenHongZha_Area";

	private long FxLoopA;

	private LogicEntity AttackTarget;

	protected override void OnSkillDisable()
	{
		StopEffect(FxLoopA);
	}

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		BeginAttack(1, _actionKey1);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopLookAt();
		yield return WaitCustomEvent(BladeEffect_Event);
		FxLoopA = PlayEffect(BladeEffect, 1f, 0, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCustomEvent(DiffuseRing_Event);
		PlayAreaEffect(DiffuseRingArea, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCustomEvent(EndRing_Event);
		StopEffect(FxLoopA);
		yield return WaitCustomEvent(StopAttack_Event);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
