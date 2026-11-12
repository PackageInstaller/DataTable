using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_WindBlade_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] WindBlade_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private bool IsUpdate;

	private FP Phase;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		if (Phase == 1 || Phase == 2)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0, 200);
		BeginAttack(1, WindBlade_Combo, flushInputedKeys: true);
		WaitLookAt_NoWait(GetAttackTarget(), 999, 50);
		if (IsUpdate)
		{
			yield return WaitCustomEvent("ExtraBladeStartFX");
			PlayEffect("ExtraWindBladeFX1");
			PlayEffect("ExtraWindBladeFX2");
		}
		yield return WaitCustomEvent("StopTurn");
		Skill_WindBlade_BossRush skill_WindBlade_BossRush = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_WindBlade_BossRush.PlayEarlyWarningEffect("CrushWarningLine2", 0.76f, default, position, rotation, 0.75f);
		if (IsUpdate)
		{
			Skill_WindBlade_BossRush skill_WindBlade_BossRush2 = this;
			position = GetPosition();
			rotation = GetRotation() + 60;
			skill_WindBlade_BossRush2.PlayEarlyWarningEffect("CrushWarningLine2", 0.76f, default, position, rotation, 0.75f);
			Skill_WindBlade_BossRush skill_WindBlade_BossRush3 = this;
			position = GetPosition();
			rotation = GetRotation() - 60;
			skill_WindBlade_BossRush3.PlayEarlyWarningEffect("CrushWarningLine2", 0.76f, default, position, rotation, 0.75f);
		}
		StopWaitLookAt();
		if (IsUpdate)
		{
			yield return WaitCustomEvent("ExtraBladeAttack");
			ShootAndAttack(60);
			ShootAndAttack(-60);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ShootAndAttack(FP Rotation)
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), Rotation), new TSVector2(0, 2.1));
		TSVector2 position2 = GetPosition();
		FP radius = 3;
		FP angle = 120;
		FP rotation = Rotation;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, radius, default, angle, rotation);
		FP knockBackForce = 25;
		FP knockBackDistance = 4;
		rotation = 4;
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, rotation);
		Shoot("Weapon_Blade", position, 1.6, default, RotateTo(GetForward(), Rotation));
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 50571042, default, HitBox.HurtAnimType.Small, "WindBlade_HittedFX");
	}
}
