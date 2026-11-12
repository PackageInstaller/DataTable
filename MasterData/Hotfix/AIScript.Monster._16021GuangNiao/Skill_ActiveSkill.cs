using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._16021GuangNiao;

public class Skill_ActiveSkill : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_AddBuff = "AddBuff";

	private static readonly int BuffID = 160210110;

	private static readonly int BuffID2 = 160210120;

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 990031100);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		AddBuffToTarget(_actor, 990031100);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.1);
		RemoveBuffFromTarget(_actor, 990031100);
		yield return WaitTime(0.2);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (!(eventName == custom_AddBuff))
		{
			return;
		}
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		TSVector2 position = GetPosition();
		FP radius = 12;
		FP innerRadius = 0;
		FP angle = 360;
		FP rotation = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		foreach (LogicEntity item in GetTargetsFromShape(shapeData, targetsByFaction))
		{
			AddBuffToTarget(item, BuffID2);
		}
	}
}
