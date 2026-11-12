using System.Collections;
using TrueSync;

namespace AIScript.Monster._1st._70031Huochui;

public class Skill_GuangRenHuanQuan : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private LogicEntity AttackTarget;

	private static readonly string AreaEffectAlias = "1st_Skill_03_GuangRenHuanQuan_AreaEffect";

	private static readonly string DownEffect = "fx_70031Huochui_base_Skill_03_1st_start";

	private readonly TSVector2 centerPosition1 = new TSVector2(0, 0);

	private readonly TSVector2 centerPosition2 = new TSVector2(0, 10);

	private readonly TSVector2 centerPosition3 = new TSVector2(0, -10);

	private readonly TSVector2 centerPosition4 = new TSVector2(8.7, 5.12);

	private readonly TSVector2 centerPosition5 = new TSVector2(8.7, -5.12);

	private readonly TSVector2 centerPosition6 = new TSVector2(-8.7, 5.12);

	private readonly TSVector2 centerPosition7 = new TSVector2(-8.7, -5.12);

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
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(AreaEffect());
		yield return WaitCustomEvent(StopAttack_Event);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator AreaEffect()
	{
		yield return WaitTime(0.5);
		long FxLoopA = PlayEffect(DownEffect, 1f, 0, centerPosition1, GetRotation());
		long FxLoopB = PlayEffect(DownEffect, 1f, 0, centerPosition2, GetRotation());
		long FxLoopC = PlayEffect(DownEffect, 1f, 0, centerPosition3, GetRotation());
		long FxLoopD = PlayEffect(DownEffect, 1f, 0, centerPosition4, GetRotation());
		long FxLoopE = PlayEffect(DownEffect, 1f, 0, centerPosition5, GetRotation());
		long FxLoopF = PlayEffect(DownEffect, 1f, 0, centerPosition6, GetRotation());
		long FxLoopG = PlayEffect(DownEffect, 1f, 0, centerPosition7, GetRotation());
		yield return WaitTime(1.03f);
		StopEffect(FxLoopA);
		StopEffect(FxLoopB);
		StopEffect(FxLoopC);
		StopEffect(FxLoopD);
		StopEffect(FxLoopE);
		StopEffect(FxLoopF);
		StopEffect(FxLoopG);
		PlayAreaEffect(AreaEffectAlias, centerPosition1);
		PlayAreaEffect(AreaEffectAlias, centerPosition2);
		PlayAreaEffect(AreaEffectAlias, centerPosition3);
		PlayAreaEffect(AreaEffectAlias, centerPosition4);
		PlayAreaEffect(AreaEffectAlias, centerPosition5);
		PlayAreaEffect(AreaEffectAlias, centerPosition6);
		PlayAreaEffect(AreaEffectAlias, centerPosition7);
	}
}
