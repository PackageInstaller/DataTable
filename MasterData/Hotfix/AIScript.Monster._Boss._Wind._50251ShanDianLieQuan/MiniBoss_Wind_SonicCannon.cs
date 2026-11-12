using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Wind._50251ShanDianLieQuan;

public class MiniBoss_Wind_SonicCannon : SkillSimpleBase
{
	private readonly string Charge = "SonicCannon_Charge";

	private readonly string Fire = "SonicCannon_Fire";

	private readonly string Daze = "SonicCannon_Daze";

	private TSVector2 SkillPos;

	private DeterministicShape Shape01;

	private LogicEntity Targetenemy;

	private int FireTimes;

	protected override void OnSkillEnable()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			FireTimes = 3;
		}
		else
		{
			FireTimes = 2;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		MiniBoss_Wind_SonicCannon miniBoss_Wind_SonicCannon = this;
		TSVector2 position = GetPosition();
		miniBoss_Wind_SonicCannon.PlayEffect("fx_m50251_base_Wind_Atk03_Disappear", 1f, default, position, default, 1f, actorScale: true);
		yield return WaitTime(0.1);
		SetHideModelEnable();
		BeginLookAtCameraDir_NotWait(DirectionType.UP, 0.1, 3600);
		yield return WaitFrame(30);
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		MiniBoss_Wind_SonicCannon miniBoss_Wind_SonicCannon2 = this;
		MiniBoss_Wind_SonicCannon miniBoss_Wind_SonicCannon3 = this;
		TSVector2 zero = TSVector2.zero;
		FP radius = 14;
		FP innerRadius = 13;
		FP angle = 60;
		FP rotation = tSVectToAngle;
		miniBoss_Wind_SonicCannon2.Shape01 = miniBoss_Wind_SonicCannon3.GetShapeData(DeterministicShape.ShapeType.Fan, zero, default, default, radius, innerRadius, angle, rotation);
		SkillPos = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		Teleport(SkillPos);
		PlayEffect("fx_m50251_base_Wind_Atk03_Appear", 1f, 0, SkillPos, 0, 1f, actorScale: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.1, 3600);
		yield return WaitTime(0.15);
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		for (int i = 1; i <= FireTimes; i++)
		{
			GetEnemy();
			BeginAttack(1, Charge, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(Targetenemy, 0.7, 60);
			yield return WaitCustomEvent("End");
			BeginAttack(2, Fire, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("StartRotate");
			if (GetMonsterTagValue(_actor, 1) == "Hard")
			{
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 1.4, 45);
			}
			yield return WaitTime(1.4);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		RemoveBuffFromTarget(_actor, 502510015);
		yield return WaitFrame(8);
		BeginAttack(3, Daze, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 502510002);
		yield return WaitTime(1.9);
		RemoveBuffFromTarget(_actor, 502510002);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
