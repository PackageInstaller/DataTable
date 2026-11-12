using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_2_7_Normal_2 : SkillSimpleBase
{
	private readonly int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private TSVector2 targetPosition1;

	private TSVector2 targetPosition2;

	private readonly string tag1 = "Monster1";

	private int time = 10000;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1f);
		while (time > 0)
		{
			BeginLookAtCameraDir(DirectionType.Left, default, 400);
			yield return WaitTime(1);
			targetPosition1 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8.5));
			MoveToPosition(targetPosition1, 0.1, AdventureActor.MovementMode.Run, 8);
			yield return WaitMoveStatus();
			yield return WaitTime(1);
			BeginLookAtCameraDir(DirectionType.Right, default, 400);
			yield return WaitTime(1);
			targetPosition2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8.5));
			MoveToPosition(targetPosition2, 0.1, AdventureActor.MovementMode.Run, 8);
			yield return WaitMoveStatus();
			yield return WaitTime(1);
			time--;
		}
		yield return WaitTime(99999);
	}
}
