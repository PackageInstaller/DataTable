using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("获取生命值", "Function", new string[] { "get", "hp" })]
public class FunctionGetHP : ConfigFunction<int>
{
	public GetHPMode getHPMode;

	protected override int Evaluate(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		return getHPMode switch
		{
			GetHPMode.HP => compAbility.hp, 
			GetHPMode.MaxHP => compAbility.maxHP, 
			GetHPMode.Config => compAbility.hp, 
			_ => throw new NotImplementedException(), 
		};
	}
}
