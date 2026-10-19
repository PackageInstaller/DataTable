using System;
using ACT.Battle;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class CheckBattleRoomWavesConditionParam
{
	[Header("战斗房交互物Id")]
	public int battleRoomId;

	[Header("波次")]
	public int waves;

	[Header("比较")]
	public ACT.Battle.Condition comparer = ACT.Battle.Condition.Less;
}
