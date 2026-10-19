using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("整数线性运算", "Function", new string[] { "int", "linear", "operation", "value", "float" })]
public class FunctionIntLinearOperation : ConfigFunction<int>
{
	public ConfigFunction<int> X;

	public float A;

	public float B;

	protected override int Evaluate(ActionMemory memory)
	{
		return Mathf.RoundToInt(A * (float)X.Return(memory) + B);
	}
}
