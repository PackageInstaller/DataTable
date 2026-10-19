using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("随机整数", "Function", new string[] { "random", "int", "value", "float" })]
public class FunctionRandomInt : ConfigFunction<int>
{
	public Vector2Int range;

	protected override int Evaluate(ActionMemory memory)
	{
		return UnityEngine.Random.Range(range.x, range.y + 1);
	}
}
