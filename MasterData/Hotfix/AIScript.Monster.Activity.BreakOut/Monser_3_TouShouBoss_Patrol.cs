using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_3_TouShouBoss_Patrol : SkillSimpleBase
{
	private readonly List<TSVector2> PositionList = new List<TSVector2>
	{
		new TSVector2(-5.5, 7),
		new TSVector2(5.5, 7)
	};

	private int PositionIndex;

	protected override IEnumerator DoMainLogic()
	{
		yield return null;
		Singleton<BrickBreakerManager>.Instance.SetAllBouncePoleProximityBoost(_actor, 0, 120);
		PositionIndex = (int)(long)GetLogicTagFpValue(_actor, "PositionListIndex");
		TSVector2 targetPosition = PositionList.get_Item(PositionIndex);
		if (PositionIndex < PositionList.Count - 1)
		{
			PositionIndex++;
		}
		else
		{
			PositionIndex = 0;
		}
		SetLogicTagFpValue(_actor, "PositionListIndex", PositionIndex);
		yield return BeginLookAtByPos(targetPosition, default, 180);
		MoveToPosition(targetPosition, 0.1, AdventureActor.MovementMode.Run, 10);
		yield return WaitMoveStatus();
		Singleton<BrickBreakerManager>.Instance.SetAllBouncePoleProximityBoost(_actor, 6, 120);
	}
}
