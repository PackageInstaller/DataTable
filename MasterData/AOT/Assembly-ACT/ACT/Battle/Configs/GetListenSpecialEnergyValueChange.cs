namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取特殊能量值", "Function", new string[] { "get", "listen", "special", "energy", "value", "change", "float", "int" })]
public class GetListenSpecialEnergyValueChange : ConfigFunction<float>
{
	public enum SpecialEnergyValueChangeType
	{
		pre,
		cur
	}

	public SpecialEnergyValueChangeType type;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		if (memory.evt is EvtModifySpecialEnergy evtModifySpecialEnergy)
		{
			switch (type)
			{
			case SpecialEnergyValueChangeType.pre:
				result = evtModifySpecialEnergy.preValue;
				break;
			case SpecialEnergyValueChangeType.cur:
				result = evtModifySpecialEnergy.curValue;
				break;
			}
		}
		return result;
	}
}
