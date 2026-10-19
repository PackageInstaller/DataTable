using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改动态变量", "Action", new string[] { "modify", "dynamic", "var" })]
public class ActionModifyDynamicVar : ConfigAction
{
	public string name;

	public ModifyType modifyType;

	public EnergyValueType energyValueType;

	public float value;

	public DynamicFloat mulKey;

	public ConfigFunction<float> customValue;

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component) || !component.vars.TryGetValue(name, out var dynamicValue))
		{
			return;
		}
		float num = energyValueType switch
		{
			EnergyValueType.skill => mulKey.GetFloat(memory.ability), 
			EnergyValueType.value => value, 
			EnergyValueType.custom => customValue.Return(memory), 
			_ => 0f, 
		};
		float num2 = 0f;
		switch (modifyType)
		{
		case ModifyType.Set:
			if (defaultAuth == AbilityAuth.Server)
			{
				num2 = num;
			}
			else if (defaultAuth == AbilityAuth.Owner)
			{
				dynamicValue.value = num;
				num2 = dynamicValue.value;
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		case ModifyType.Add:
			if (defaultAuth == AbilityAuth.Server)
			{
				num2 = dynamicValue.value + num;
			}
			else if (defaultAuth == AbilityAuth.Owner)
			{
				dynamicValue.value += num;
				num2 = dynamicValue.value;
			}
			else if (!LuminApplication.LogEnabled)
			{
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		dynamicValue.value = num2;
	}
}
