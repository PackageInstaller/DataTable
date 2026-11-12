using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_LaserShoot : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private LogicEntity AttackTarget;

	private long LaserLaunch_Collect_HeadFX;

	private long AimFX;

	private long LaserFX;

	private long LaserDecoration1FX;

	private long LaserDecoration2FX;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
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
		yield return StartCor(FlashBeforeAttackForFengNiao(11, 8, 30, 240, 12, 4));
		yield return WaitLookAt(AttackTarget, 0.1, 1800);
		BeginAttack(1, Shoot_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 999, 50);
		LaserLaunch_Collect_HeadFX = PlayEffect("LaserLaunch_Collect_Head_lv1FX");
		yield return WaitCustomEvent("Aimeline");
		Skill_LaserShoot skill_LaserShoot = this;
		Skill_LaserShoot skill_LaserShoot2 = this;
		FP rotation = GetRotation();
		skill_LaserShoot.AimFX = skill_LaserShoot2.PlayEffect("Laser_AimFX", 1f, default, default, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(LaserAttackCor(10, 1));
		CancelAttack();
		FlowerShootStart();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
			Skill_LaserShoot skill_LaserShoot = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 26.7));
			FP width = 1.5;
			FP length = 50;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skill_LaserShoot.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
			Skill_LaserShoot skill_LaserShoot2 = this;
			rotation = 0.5;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_LaserShoot2.GetHitFeatureData(HitBox.FeatureFlag.Stiff, default, default, UseAtttackForward: false, default, null, null, rotation, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 155100501, 0.5, HitBox.HurtAnimType.Large, "HittedFX_Magic");
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
