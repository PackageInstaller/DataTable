using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断派生Sub类型", "Predicate", new string[] { "check", "derivative", "sub", "type", "predicate", "condition" })]
public class CheckDerivativeSubType : ConfigPredicate
{
	public DerivativeSubType derivativeSubType;

	public override bool Check(ActionMemory memory)
	{
		CompProduct compProduct = memory.target.entity.GetCompProduct();
		if (compProduct != null)
		{
			return compProduct.derivativeSubType.HasFlag(derivativeSubType);
		}
		return false;
	}
}
