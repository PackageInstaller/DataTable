namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取能量值", "Function", new string[] { "get", "energy", "change", "value", "float", "int" })]
public class GetEnergyChangeValue : ConfigFunction<float>
{
	public ModifyEnergyType type;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		switch (type)
		{
		case ModifyEnergyType.NormalEnergy:
			if (memory.evt is EvtBeforeModifyNormalEnergy evtBeforeModifyNormalEnergy)
			{
				result = evtBeforeModifyNormalEnergy.value;
			}
			break;
		case ModifyEnergyType.SpecialEnergy:
			if (memory.evt is EvtBeforeModifySpecialEnergy evtBeforeModifySpecialEnergy)
			{
				result = evtBeforeModifySpecialEnergy.value;
			}
			break;
		}
		return result;
	}
}
