using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_4_ShiZiDao : SkillSimpleBase
{
	private readonly Dictionary<int, TSVector2> MonsterID_LocalPos_Dic = new Dictionary<int, TSVector2>
	{
		[8210421] = new TSVector2(6, 6),
		[8210422] = new TSVector2(-6, 6),
		[8210342] = new TSVector2(0, -8),
		[8210451] = new TSVector2(-5, 0),
		[8210452] = new TSVector2(5, 0)
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
