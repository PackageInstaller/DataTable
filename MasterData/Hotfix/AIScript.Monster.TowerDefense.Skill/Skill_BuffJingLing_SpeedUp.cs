using System.Collections;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_BuffJingLing_SpeedUp : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SupportAttack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AddBuff");
		Skill_BuffJingLing_SpeedUp skill_BuffJingLing_SpeedUp = this;
		TSVector2 position = GetPosition();
		FP radius = 7.5;
		DeterministicShape shapeData = skill_BuffJingLing_SpeedUp.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		foreach (LogicEntity item in GetTargetsFromShape(shapeData, GetTargetsByFaction(isFriend: true)))
		{
			AddBuffToTarget(item, 808010110);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
