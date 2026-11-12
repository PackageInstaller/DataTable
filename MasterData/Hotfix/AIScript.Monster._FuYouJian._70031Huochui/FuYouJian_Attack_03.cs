using System.Collections;
using TrueSync;

namespace AIScript.Monster._FuYouJian._70031Huochui;

public class FuYouJian_Attack_03 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string Dash_Event = "Dash";

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Z,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string KillActors_Event = "KillActors";

	private LogicEntity AttackTarget;

	private readonly string FuYouJianFxAlias = "fx_700311FuYouJian_loop_attack_03_bullet_start";

	private static readonly string PlayEffect_Event = "PlayEffect";

	private static readonly string DelEffectL1_Event = "DelEffectL1";

	private static readonly string DelEffectR1_Event = "DelEffectR1";

	private static readonly string DelEffectL2_Event = "DelEffectL2";

	private static readonly string DelEffectR2_Event = "DelEffectR2";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		RemoveBuffFromTarget(_actor, 990010040);
		BeginAttack(1, _actionKey1);
		BeginLookAt_NotWait(AttackTarget, 3, 80);
		yield return WaitCustomEvent(PlayEffect_Event);
		long FxLoopA = PlayEffect(FuYouJianFxAlias, 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.5, 0)), GetTSVectToAngle(GetForward(), 0), 1f, actorScale: true);
		long FxLoopC = PlayEffect(FuYouJianFxAlias, 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1.5, 0)), GetTSVectToAngle(GetForward(), 0), 1f, actorScale: true);
		long FxLoopB = PlayEffect(FuYouJianFxAlias, 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(3, 0)), GetTSVectToAngle(GetForward(), 0), 1f, actorScale: true);
		long FxLoopD = PlayEffect(FuYouJianFxAlias, 1f, 1.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-3, 0)), GetTSVectToAngle(GetForward(), 0), 1f, actorScale: true);
		yield return WaitCustomEvent(DelEffectL1_Event);
		StopEffect(FxLoopA);
		yield return WaitCustomEvent(DelEffectR1_Event);
		StopEffect(FxLoopC);
		yield return WaitCustomEvent(DelEffectL2_Event);
		StopEffect(FxLoopB);
		yield return WaitCustomEvent(DelEffectR2_Event);
		StopEffect(FxLoopD);
		yield return WaitCustomEvent(Dash_Event);
		StopLookAt();
		FP fP = Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) + 5f;
		if (fP < 10)
		{
			fP += (FP)10;
		}
		BeginDashActorForward(1, 80, fP, 540, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
