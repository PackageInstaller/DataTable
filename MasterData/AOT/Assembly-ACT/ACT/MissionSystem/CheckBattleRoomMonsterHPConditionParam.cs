using ACT.Battle;
using UnityEngine;

namespace ACT.MissionSystem;

public class CheckBattleRoomMonsterHPConditionParam
{
	[Header("战斗房交互物Id")]
	public int battleRoomId;

	[Header("怪物血量百分比")]
	public int hpPercent;

	[Header("比较")]
	public ACT.Battle.Condition comparer = ACT.Battle.Condition.Less;
}
