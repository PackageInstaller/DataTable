using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_4_XiaoFa : SkillSimpleBase
{
	private readonly Dictionary<int, TSVector2> MonsterID_LocalPos_Dic = new Dictionary<int, TSVector2>
	{
		[8210431] = new TSVector2(15, 0),
		[8210432] = new TSVector2(-15, 0),
		[8210441] = new TSVector2(0, 0),
		[8210453] = new TSVector2(10, 0)
	};

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

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
		BeginLookAtCameraDir(DirectionType.Down);
		BeginAttack(1, startKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
