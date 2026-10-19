using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("获取技能层数", "Function", new string[] { "get", "ability", "stack", "change" })]
public class FunctionGetAbilityStackChange : ConfigFunction<int>
{
	public bool abs = true;

	protected override int Evaluate(ActionMemory memory)
	{
		int change = (memory.evt as EvtAbilityStackChange).change;
		if (!abs)
		{
			return change;
		}
		return Mathf.Abs(change);
	}
}
