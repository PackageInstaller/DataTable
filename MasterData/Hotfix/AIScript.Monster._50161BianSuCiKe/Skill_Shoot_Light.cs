using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot_Light : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly ComboInputBuffer.ActionKey[] Null_Combo = new ComboInputBuffer.ActionKey[0];

	private static readonly FP searchDistanc = 11;

	private static readonly List<FP> searchAngles = new List<FP>
	{
		50, 30, 10, -10, -30, -50, 70, -70, 90, -90,
		0
	};

	private TSVector2 ShootPosition;

	private TSVector2 ShootTargetPosition;

	private static readonly TSVector2 ShootPositionOffset = new TSVector2(0.3, 2.8);

	private long ChargeFX;

	private long AimlineFX;

	private long LaserFX;

	private CoroutineNode LaserAttackNode;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(0.5);
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginAttack(2, Shoot_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 1800);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), ShootPositionOffset);
		ChargeFX = PlayEffect("LaserCharge", 1f, position: GetPosition(), fxPositionY: 1.7, angle: default, spawnSize: 0.75f);
		AimlineFX = PlayEarlyWarningEffect("AimlineFX", 1f, 1.7, ShootPosition, GetRotation());
		yield return WaitTime(0.8);
		PlayEffect("LaserStart");
		yield return WaitTime(0.2);
		StopEffect(ChargeFX);
		LaserFX = PlayEffect("LaserFX");
		StartCor(ref LaserAttackNode, LaserAttack());
		yield return WaitTime(0.25);
		StopEffect(LaserFX);
		StopCor(LaserAttackNode);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}

	private IEnumerator LaserAttack()
	{
		Skill_Shoot_Light skill_Shoot_Light = this;
		TSVector2 position = TransLocalPosToWorldPos(ShootPosition, GetForward(), new TSVector2(0, 12.5));
		FP width = 1;
		FP length = 25;
		FP rotation = GetRotation();
		DeterministicShape AttackShape = skill_Shoot_Light.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		Skill_Shoot_Light skill_Shoot_Light2 = this;
		rotation = 0.5;
		FP hitStrenth = 4;
		HitFeatureData HitFeature = skill_Shoot_Light2.GetHitFeatureData(HitBox.FeatureFlag.Stiff, default, default, UseAtttackForward: false, default, null, null, rotation, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		while (true)
		{
			AreaHit_Simple(_actor, AttackShape, HitFeature, 50161211, 1, HitBox.HurtAnimType.Small, "LaserHitFX");
			yield return WaitTime(0.1);
		}
	}
}
