using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_3_ShiZiDao : SkillSimpleBase
{
	private readonly Dictionary<int, TSVector2> MonsterID_LocalPos_Dic = new Dictionary<int, TSVector2>
	{
		[8210321] = new TSVector2(7, 0),
		[8210322] = new TSVector2(-7, 0),
		[8210342] = new TSVector2(0, -8),
		[8210371] = new TSVector2(0, 13)
	};

	private TSVector2 targetPosition;

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), GetLogicTagTSVector2Value(_actor, "SpawnPos")) < 0.5)
		{
			targetPosition = TransLocalPosToWorldPos(GetPosition(), TSVector2.up, MonsterID_LocalPos_Dic.get_Item(_actor.dataID));
		}
		else
		{
			targetPosition = GetLogicTagTSVector2Value(_actor, "SpawnPos");
		}
		yield return BeginLookAtByPos(targetPosition, default, 180);
		MoveToPosition(targetPosition, 0.1, AdventureActor.MovementMode.Run, 10);
		yield return WaitMoveStatus();
	}
}
