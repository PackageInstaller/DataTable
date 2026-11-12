using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_ClawAttack : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtMonsterTarget(Config.turnDuration_Claw, Config.turnSpeed_Claw);
		BeginAttack(0, "WingStrike_1");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(1, "WingStrike_2");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin_Left"))
		{
			GenerateLeftBaoLin();
		}
		else if (comboIndex == 0 && string.Equals(eventName, "BaoLin_Right"))
		{
			GenerateRightBaoLin();
		}
		else if (comboIndex == 1 && string.Equals(eventName, "BaoLin"))
		{
			GenerateLeftBaoLin();
			GenerateRightBaoLin();
		}
	}

	private void GenerateLeftBaoLin()
	{
		TSVector2 position = _actor.tsTransform.Position;
		FP radius_GenerateBaoLin_Left_Claw = Config.radius_GenerateBaoLin_Left_Claw;
		FP innerRadius = 0;
		FP angle_GenerateBaoLin_Left_Claw = Config.angle_GenerateBaoLin_Left_Claw;
		FP rotation = _actor.tsTransform.Rotation + Config.offsetAngle_GenerateBaoLin_Left_Claw;
		StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius_GenerateBaoLin_Left_Claw, innerRadius, angle_GenerateBaoLin_Left_Claw, rotation), 5, Config.interval_GenerateBaoLin_Left_Claw));
	}

	private void GenerateRightBaoLin()
	{
		TSVector2 position = _actor.tsTransform.Position;
		FP radius_GenerateBaoLin_Right_Claw = Config.radius_GenerateBaoLin_Right_Claw;
		FP innerRadius = 0;
		FP angle_GenerateBaoLin_Right_Claw = Config.angle_GenerateBaoLin_Right_Claw;
		FP rotation = _actor.tsTransform.Rotation + Config.offsetAngle_GenerateBaoLin_Right_Claw;
		StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius_GenerateBaoLin_Right_Claw, innerRadius, angle_GenerateBaoLin_Right_Claw, rotation), 5, Config.interval_GenerateBaoLin_Right_Claw));
	}
}
