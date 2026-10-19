namespace ACT.Battle.Configs;

[AbilityTypeMetadata("添加角色能量", "Action", new string[] { "add", "character", "energy" })]
public class ActionAddCharacterEnergy : ConfigAction
{
	public enum FloatType
	{
		dynamicFloat,
		functionFloat
	}

	public FloatType floatType;

	public DynamicFloat energyValue;

	public ConfigFunction<float> functionEnergyValue;

	public bool isAll;

	public bool isNeedCharacterChargeRate;

	public override void Do(ActionMemory memory)
	{
		float value = ((floatType == FloatType.dynamicFloat) ? energyValue.GetFloat(memory.ability) : functionEnergyValue.Return(memory));
		if (isAll)
		{
			SystemAbility.AddUltimateSkillValueForPlayer(MonoECS.instance.localPlayer, value, useOffsiteParam: false, isNeedCharacterChargeRate);
		}
		else
		{
			SystemAbility.AddUltimateSkillValue(memory.target.entity, value, offsite: false, isNeedCharacterChargeRate);
		}
	}
}
