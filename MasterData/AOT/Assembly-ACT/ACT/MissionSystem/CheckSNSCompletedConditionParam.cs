using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class CheckSNSCompletedConditionParam
{
	public int snsId;

	[Header("等待回到battlemain界面才算完成")]
	public bool waitBattleMain = true;
}
