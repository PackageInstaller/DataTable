using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_HeatDischarge : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "CircleFire");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(Config.loopTime_HeatDischarge);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			StartCor(GenerateBaoLin());
		}
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin_Fire"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP radius = Config.radius_Attack_HeatDischarge;
			FP innerRadius = 0;
			DetonateBaoLin(GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius));
		}
	}

	private IEnumerator GenerateBaoLin()
	{
		int totalCount = 8;
		int count = 2;
		int index = 0;
		while (totalCount > 0)
		{
			if (count > totalCount)
			{
				count = totalCount;
			}
			TSVector2 position = _actor.tsTransform.Position;
			FP radius_GenerateBaoLin_HeatDischarge = Config.radius_GenerateBaoLin_HeatDischarge;
			FP innerRadius = 0;
			FP angle = 90;
			FP fP = index;
			FP angle2 = _actor.tsTransform.Forward.GetAngle();
			FP rotation = fP % angle2;
			yield return StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius_GenerateBaoLin_HeatDischarge, innerRadius, angle, rotation), count, Config.interval_GenerateBaoLin_HeatDischarge));
			totalCount -= count;
			index++;
		}
	}
}
