using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断派生类型", "Predicate", new string[] { "check", "derivative", "type", "predicate", "condition" })]
public class CheckDerivativeType : ConfigPredicate
{
	public DerivativeType derivativeType;

	public override bool Check(ActionMemory memory)
	{
		CompProduct compProduct = memory.target.entity.GetCompProduct();
		if (compProduct != null)
		{
			return compProduct.derivativeType.HasFlag(derivativeType);
		}
		return false;
	}
}
