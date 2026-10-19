using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class PlayerLevelRangeConditionParam
{
	public int minLevel;

	public int maxLevel;

	public List<int> guideSystemIds = new List<int>();
}
