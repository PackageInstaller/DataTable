using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Bombing : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		if (TSRandom.Range(0, 2) == 0)
		{
			BeginAttack(0, "");
			yield return WaitCombo(ComboAttackType.isComboFinish);
			BeginAttack(1, "");
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, "");
			yield return WaitCombo(ComboAttackType.isComboFinish);
			BeginAttack(0, "");
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		BeginAttack(2, "");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP innerRadius_First_GenerateBaoLin_Bombing = Config.innerRadius_First_GenerateBaoLin_Bombing;
			FP outerRadius_First_GenerateBaoLin_Bombing = Config.outerRadius_First_GenerateBaoLin_Bombing;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, outerRadius_First_GenerateBaoLin_Bombing, innerRadius_First_GenerateBaoLin_Bombing), 1, Config.interval_First_GenerateBaoLin_Bombing));
		}
		else if (comboIndex == 1 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position2 = _actor.tsTransform.Position;
			FP outerRadius_First_GenerateBaoLin_Bombing = 0;
			FP innerRadius_First_GenerateBaoLin_Bombing = Config.radius_Second_GenerateBaoLin_Bombing;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, innerRadius_First_GenerateBaoLin_Bombing, outerRadius_First_GenerateBaoLin_Bombing), 1, Config.interval_Second_GenerateBaoLin_Bombing));
		}
		else if (comboIndex == 2 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position3 = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offset_Third_GenerateBaoLin_Bombing;
			FP width_Third_GenerateBaoLin_Bombing = Config.width_Third_GenerateBaoLin_Bombing;
			FP length_Third_GenerateBaoLin_Bombing = Config.length_Third_GenerateBaoLin_Bombing;
			FP innerRadius_First_GenerateBaoLin_Bombing = _actor.tsTransform.Rotation;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Rectangle, position3, width_Third_GenerateBaoLin_Bombing, length_Third_GenerateBaoLin_Bombing, default, default, default, innerRadius_First_GenerateBaoLin_Bombing), 1, Config.interval_Third_GenerateBaoLin_Bombing));
		}
	}
}
