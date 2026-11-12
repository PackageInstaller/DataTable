using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_Spore : SkillSimpleBase
{
	private LogicEntity target;

	private bool dashTag;

	private readonly int OneShootIndex;

	private readonly string OneShootKey = "OneShoot";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget(target)))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		Dash dash = BeginDash(10, GetEntityPositionObsoleted(target) - GetPosition(), 6, 24, 80, comboWithAttack: false, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: true, 0.5);
		dashTag = true;
		for (int i = 0; i < 8; i++)
		{
			if (!dashTag)
			{
				break;
			}
			dash._direction = GetEntityPositionObsoleted(target) - GetPosition();
			yield return WaitTime(0.5);
		}
		StopDash();
		yield return WaitMoveStatus();
	}

	protected override void OnDashFinish(int index)
	{
		if (index == 10)
		{
			dashTag = false;
		}
	}

	protected override void DashFinishByActor(int index)
	{
		if (index == 10)
		{
			dashTag = false;
		}
	}
}
