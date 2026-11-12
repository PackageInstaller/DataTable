using System.Collections;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_BlackHole : SkillSimpleBase
{
	private LogicEntity target;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(0, "BlackHole", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayAreaEffect("BlackHole_Area", GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPositionObsoleted(target), default, default, 6), _actor, isReachable: true));
	}
}
