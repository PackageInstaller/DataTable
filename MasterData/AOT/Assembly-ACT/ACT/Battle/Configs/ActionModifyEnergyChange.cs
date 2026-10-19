namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改能量", "Action", new string[] { "modify", "energy", "change" })]
public class ActionModifyEnergyChange : ConfigAction
{
	public ModifyEnergyType type;

	public ConfigFunction<float> modifyValue;

	public override void Do(ActionMemory memory)
	{
		float value = modifyValue.Return(memory);
		switch (type)
		{
		case ModifyEnergyType.NormalEnergy:
			if (memory.evt is EvtBeforeModifyNormalEnergy evtBeforeModifyNormalEnergy)
			{
				evtBeforeModifyNormalEnergy.value = value;
			}
			break;
		case ModifyEnergyType.SpecialEnergy:
			if (memory.evt is EvtBeforeModifySpecialEnergy evtBeforeModifySpecialEnergy)
			{
				evtBeforeModifySpecialEnergy.value = value;
			}
			break;
		}
	}
}
