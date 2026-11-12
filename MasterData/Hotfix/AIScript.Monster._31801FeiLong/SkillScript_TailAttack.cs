using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_TailAttack : SkillScript_Base
{
	private FP _singleAngleWithTarget;

	protected override IEnumerator DoMainLogic()
	{
		_singleAngleWithTarget = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		bool logicTagToggle = _actor.logicVariable.GetLogicTagToggle("SkillStrength");
		if (_singleAngleWithTarget >= 0)
		{
			BeginAttack(0, logicTagToggle ? "TailStrike_Plus_Left" : "TailStrike_Left");
		}
		else
		{
			BeginAttack(0, logicTagToggle ? "TailStrike_Plus_Right" : "TailStrike_Right");
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP outerRadius_GenerateBaoLin_Tail = Config.outerRadius_GenerateBaoLin_Tail;
			FP innerRadius_GenerateBaoLin_Tail = Config.innerRadius_GenerateBaoLin_Tail;
			FP angle_GenerateBaoLin_Tail = Config.angle_GenerateBaoLin_Tail;
			FP rotation = _actor.tsTransform.Rotation + ((_singleAngleWithTarget >= 0) ? Config.offsetAngle_GenerateBaoLin_Tail : (-Config.offsetAngle_GenerateBaoLin_Tail));
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, outerRadius_GenerateBaoLin_Tail, innerRadius_GenerateBaoLin_Tail, angle_GenerateBaoLin_Tail, rotation), 6, Config.interval_GenerateBaoLin_Tail));
		}
		else if (comboIndex == 0 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position2 = _actor.tsTransform.Position;
			FP rotation = Config.outerRadius_GenerateBaoLin_Tail_Strength;
			FP angle_GenerateBaoLin_Tail = Config.innerRadius_GenerateBaoLin_Tail_Strength;
			FP innerRadius_GenerateBaoLin_Tail = Config.angle_GenerateBaoLin_Tail_Strength;
			FP outerRadius_GenerateBaoLin_Tail = _actor.tsTransform.Rotation + ((_singleAngleWithTarget >= 0) ? Config.offsetAngle_GenerateBaoLin_Tail_Strength : (-Config.offsetAngle_GenerateBaoLin_Tail_Strength));
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle_GenerateBaoLin_Tail, innerRadius_GenerateBaoLin_Tail, outerRadius_GenerateBaoLin_Tail), 9, Config.interval_GenerateBaoLin_Tail_Strength));
		}
	}
}
