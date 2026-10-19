using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置技能实体限制", "Action", new string[] { "set", "ability", "entity", "limit", "skill", "cd" })]
public class ActionSetAbilityEntityLimit : ConfigAction
{
	public enum CalType
	{
		Base,
		Add,
		Mul
	}

	public AbilityEntityType[] abilityEntityTypes;

	public CalType calType;

	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		float num = value.Return(memory);
		SystemProduct systemProduct = Singleton<GameManager>.instance.ecsManager.systemProduct;
		AbilityEntityType[] array = abilityEntityTypes;
		foreach (AbilityEntityType key in array)
		{
			switch (calType)
			{
			case CalType.Base:
				systemProduct.productEntityCountLimit[key] += num;
				break;
			case CalType.Add:
				systemProduct.productEntityCountAdd[key] += num;
				break;
			case CalType.Mul:
				systemProduct.productEntityCountMul[key] *= num;
				break;
			}
		}
	}
}
