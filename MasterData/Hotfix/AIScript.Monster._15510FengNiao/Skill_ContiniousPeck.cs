using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_ContiniousPeck : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] ContiniousPeck_Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] ContiniousPeck_NormalEnd_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] ContiniousPeck_AnotherAttack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] ContiniousPeck_Laser_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly FP TraceSpeed = 2;

	private static readonly FP TraceTime = 2;

	private LogicEntity AttackTarget;

	private FP Phase;

	private long LaserLaunch_Collect_HeadFX;

	private long AimFX;

	private long LaserFX;

	private long LaserDecoration1FX;

	private long LaserDecoration2FX;

	private FP Difficulty;

	private bool IsBossRush;

	private bool IsUpgrade;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		IsBossRush = GetLogicTagToggleValue(_actor, "IsBossRush");
		if (!IsBossRush)
		{
			if (Phase == 1)
			{
				IsUpgrade = false;
			}
			else
			{
				IsUpgrade = true;
			}
		}
		else if (Phase == 1 || Phase == 2)
		{
			IsUpgrade = false;
		}
		else
		{
			IsUpgrade = true;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(LaserFX);
		StopEffect(LaserDecoration1FX);
		StopEffect(LaserDecoration2FX);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitLookAt(AttackTarget, 0.25, 720);
		BeginAttack(1, ContiniousPeck_Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Dash");
		yield return StartCor(FlashBeforeAttackForFengNiao(3, 2, 30, 360, 12, 1, IsCombo: true));
		yield return WaitLookAt(AttackTarget, 0.03, 9999);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(1, TraceSpeed, TraceSpeed * TraceTime, 50, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false);
		yield return WaitDashFinish();
		if (!IsUpgrade)
		{
			BeginAttack(1, ContiniousPeck_NormalEnd_Combo);
			FlowerShootStart();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= 6 && Difficulty != 3)
		{
			PlayEffect("YuJingFlash", 1f, 2, GetPosition(), default, 1.2f);
			BeginAttack(1, ContiniousPeck_AnotherAttack_Combo);
			BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 0.3, 600);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			BeginDashActorForward(1, TraceSpeed, TraceSpeed * TraceTime, 50, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false);
			if (IsBossRush)
			{
				BeginLookAtMonsterTarget(TraceTime, 40);
			}
			yield return WaitDashFinish();
			BeginAttack(1, ContiniousPeck_AnotherAttack_Combo);
			FlowerShootStart();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			yield return WaitLookAt(AttackTarget, 0.1, 1800);
			BeginAttack(1, ContiniousPeck_Laser_Combo);
			BeginLookAt_NotWait(AttackTarget, 999, 50);
			LaserLaunch_Collect_HeadFX = PlayEffect("LaserLaunch_Collect_Head_lv1FX");
			yield return WaitCustomEvent("Aimeline");
			Skill_ContiniousPeck skill_ContiniousPeck = this;
			Skill_ContiniousPeck skill_ContiniousPeck2 = this;
			FP rotation = GetRotation();
			skill_ContiniousPeck.AimFX = skill_ContiniousPeck2.PlayEffect("Laser_AimFX", 1f, default, default, rotation);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return StartCor(LaserAttackCor(2, 1));
			CancelAttack();
			FlowerShootStart();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator LaserAttackCor(int AimDurationFrame, int LaserDurationFrame)
	{
		int LaserDurationCount = 0;
		yield return WaitFrame(AimDurationFrame);
		StopEffect(LaserLaunch_Collect_HeadFX);
		StopEffect(AimFX);
		PlayEffect("Laser_ReadyFX");
		StopWaitLookAt();
		yield return WaitFrame(10);
		LaserDecoration1FX = PlayEffect("LaserDecorationFX1");
		yield return WaitFrame(1);
		LaserDecoration2FX = PlayEffect("LaserDecorationFX2");
		yield return WaitFrame(4);
		LaserFX = PlayEffect("LaserFX");
		while (LaserDurationCount < LaserDurationFrame)
		{
			Skill_ContiniousPeck skill_ContiniousPeck = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 26.7));
			FP width = 1.5;
			FP length = 50;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skill_ContiniousPeck.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
			Skill_ContiniousPeck skill_ContiniousPeck2 = this;
			rotation = 0.5;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_ContiniousPeck2.GetHitFeatureData(HitBox.FeatureFlag.Stiff, default, default, UseAtttackForward: false, default, null, null, rotation, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 155100301, 0.5, HitBox.HurtAnimType.Large, "HittedFX_Magic");
			LaserDurationCount++;
			yield return null;
		}
		yield return WaitFrame(LaserDurationFrame);
		StopEffect(LaserFX);
		StopEffect(LaserDecoration1FX);
		StopEffect(LaserDecoration2FX);
		PlayEffect("LaserEndFX");
	}
}
