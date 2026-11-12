using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_FireBreath : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "FanFire");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		WaitLookAt(GetAttackTarget(isUpToDate: true), -1, Config.rotateSpeed_FireBreath);
		yield return WaitTime(Config.loopTime_FireBreath);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offset_GenerateBaoLin_FireBreath;
			FP radius_GenerateBaoLin_FireBreath = Config.radius_GenerateBaoLin_FireBreath;
			FP innerRadius = 0;
			FP angle_GenerateBaoLin_FireBreath = Config.angle_GenerateBaoLin_FireBreath;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius_GenerateBaoLin_FireBreath, innerRadius, angle_GenerateBaoLin_FireBreath), 4, Config.interval_GenerateBaoLin_FireBreath));
		}
		else if (comboIndex == 0 && string.Equals(eventName, "BaoLin_Fire"))
		{
			TSVector2 position2 = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offset_Attack_FireBreath;
			FP angle_GenerateBaoLin_FireBreath = Config.radius_Attack_FireBreath;
			FP innerRadius = 0;
			FP radius_GenerateBaoLin_FireBreath = Config.angle_Attack_FireBreath;
			DetonateBaoLin(GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, angle_GenerateBaoLin_FireBreath, innerRadius, radius_GenerateBaoLin_FireBreath));
		}
	}
}
