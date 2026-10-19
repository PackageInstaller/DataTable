using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class PermissionLevelConditionParam
{
	public int level;

	public List<int> systemIds = new List<int>();
}
