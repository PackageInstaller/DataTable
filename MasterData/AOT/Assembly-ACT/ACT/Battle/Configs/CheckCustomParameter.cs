using System;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断自定义参数", "Predicate", new string[] { "check", "custom", "parameter", "predicate", "condition" })]
public class CheckCustomParameter : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		throw new NotImplementedException();
	}
}
