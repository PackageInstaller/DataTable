using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("获取跳跃数量", "Function", new string[] { "get", "jump", "count", "value", "float", "int" })]
public class FunctionGetJumpCount : ConfigFunction<int>
{
	public GetJumpCountMode getJumpCountMode;

	protected override int Evaluate(ActionMemory memory)
	{
		return getJumpCountMode switch
		{
			GetJumpCountMode.Runtime => memory.target.entity.GetCompMotion().JumpInAirCount, 
			GetJumpCountMode.Config => memory.target.entity.GetConfig().jumpInAirCount, 
			_ => throw new NotImplementedException(), 
		};
	}
}
