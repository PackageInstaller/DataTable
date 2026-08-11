using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class TaskIndexStateConditionAdd : ConditionAddBase
{
	[Tooltip("条件配置")]
	public bool invertCondition;

	public List<OpenCondition> TaskConditions = new List<OpenCondition>();
}
