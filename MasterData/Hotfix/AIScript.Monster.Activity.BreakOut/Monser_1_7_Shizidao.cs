using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_1_7_Shizidao : SkillSimpleBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private TSVector2 targetPosition1;

	private TSVector2 targetPosition2;

	private string tag1 = "Monster1";

	private string tag2 = "Monster2";

	private string tag3 = "Monster3";

	private int time = 10000;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1f);
		if (GetMonsterTagValue(_actor, 1) == tag1)
		{
			while (time > 0)
			{
				BeginLookAtCameraDir(DirectionType.Right, default, 400);
				yield return WaitTime(1);
				targetPosition1 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				MoveToPosition(targetPosition1, 0.1, AdventureActor.MovementMode.Run, 10);
				yield return WaitMoveStatus();
				yield return WaitTime(1);
				BeginLookAtCameraDir(DirectionType.Left, default, 400);
				yield return WaitTime(1);
				targetPosition2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				MoveToPosition(targetPosition2, 0.1, AdventureActor.MovementMode.Run, 10);
				yield return WaitMoveStatus();
				yield return WaitTime(1);
				BeginLookAtCameraDir(DirectionType.Right, default, 400);
				yield return WaitTime(1);
				time--;
			}
		}
		else
		{
			while (time > 0)
			{
				BeginLookAtCameraDir(DirectionType.Left, default, 400);
				yield return WaitTime(1);
				targetPosition1 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				MoveToPosition(targetPosition1, 0.1, AdventureActor.MovementMode.Run, 10);
				yield return WaitMoveStatus();
				yield return WaitTime(1);
				BeginLookAtCameraDir(DirectionType.Right, default, 400);
				yield return WaitTime(1);
				targetPosition2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				MoveToPosition(targetPosition2, 0.1, AdventureActor.MovementMode.Run, 10);
				yield return WaitMoveStatus();
				yield return WaitTime(1);
				BeginLookAtCameraDir(DirectionType.Left, default, 400);
				yield return WaitTime(1);
				time--;
			}
		}
		yield return WaitTime(99999);
	}
}
