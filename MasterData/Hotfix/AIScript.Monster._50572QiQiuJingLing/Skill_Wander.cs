using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Wander : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopDash();
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(Check());
		Skill_Wander skill_Wander = this;
		TSVector2 logicTagTSVector2Value = GetLogicTagTSVector2Value(_actor, "SpawnPosition");
		FP radius = 5;
		FP innerRadius = 3;
		DeterministicShape shape = skill_Wander.GetShapeData(DeterministicShape.ShapeType.Circle, logicTagTSVector2Value, default, default, radius, innerRadius);
		while (true)
		{
			TSVector2 point = GetShapeRandomPoint(shape, _actor, isReachable: true);
			int num = 0;
			while (Distance(point, GetPosition()) <= 2 && num <= 5)
			{
				point = GetShapeRandomPoint(shape, _actor, isReachable: true);
				num++;
			}
			FP distance = Distance(point, GetPosition());
			yield return BeginLookAtByPos(point, 0, 90);
			BeginDash(1, point - GetPosition(), 1, distance, 0, comboWithAttack: false, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			yield return WaitTime(1);
		}
	}

	private IEnumerator Check()
	{
		while (GetBuffNum(_actor, 505719901) <= 0)
		{
			yield return null;
		}
		InterruptSkill();
	}
}
