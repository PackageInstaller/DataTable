using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class KillDynamicMonsterConditionParam
{
	public List<int> monsterIds = new List<int>();

	public int count;
}
