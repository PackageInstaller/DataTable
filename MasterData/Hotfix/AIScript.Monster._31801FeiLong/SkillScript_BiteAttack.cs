using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_BiteAttack : SkillScript_Base
{
	private FP _singleAngleWithTarget;

	protected override IEnumerator DoMainLogic()
	{
		_singleAngleWithTarget = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (_singleAngleWithTarget >= 0)
		{
			BeginAttack(0, "Tearing_Left");
		}
		else
		{
			BeginAttack(0, "Tearing_Right");
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (_actor.logicVariable.GetLogicTagToggle("SkillStrength"))
		{
			_singleAngleWithTarget = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
			if (_singleAngleWithTarget >= 0)
			{
				BeginAttack(1, "Tearing_2_Left");
			}
			else
			{
				BeginAttack(1, "Tearing_2_Right");
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP outerRadius_GenerateBaoLin_Bite = Config.outerRadius_GenerateBaoLin_Bite;
			FP innerRadius_GenerateBaoLin_Bite = Config.innerRadius_GenerateBaoLin_Bite;
			FP angle_GenerateBaoLin_Bite = Config.angle_GenerateBaoLin_Bite;
			FP rotation = _actor.tsTransform.Rotation + ((_singleAngleWithTarget >= 0) ? Config.offsetAngle_GenerateBaoLin_Bite : (-Config.offsetAngle_GenerateBaoLin_Bite));
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, outerRadius_GenerateBaoLin_Bite, innerRadius_GenerateBaoLin_Bite, angle_GenerateBaoLin_Bite, rotation), 3, Config.interval_GenerateBaoLin_Bite));
		}
		else if (comboIndex == 1 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position2 = _actor.tsTransform.Position;
			FP rotation = Config.outerRadius_GenerateBaoLin_Bite_Strength;
			FP angle_GenerateBaoLin_Bite = Config.innerRadius_GenerateBaoLin_Bite_Strength;
			FP innerRadius_GenerateBaoLin_Bite = Config.angle_GenerateBaoLin_Bite_Strength;
			FP outerRadius_GenerateBaoLin_Bite = _actor.tsTransform.Rotation + ((_singleAngleWithTarget >= 0) ? Config.offsetAngle_GenerateBaoLin_Bite_Strength : (-Config.offsetAngle_GenerateBaoLin_Bite_Strength));
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle_GenerateBaoLin_Bite, innerRadius_GenerateBaoLin_Bite, outerRadius_GenerateBaoLin_Bite), 3, Config.interval_GenerateBaoLin_Bite_Strength));
		}
	}
}
