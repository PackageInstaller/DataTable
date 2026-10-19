namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取普通能量值", "Function", new string[] { "get", "listen", "normal", "energy", "value", "change", "float", "int" })]
public class GetListenNormalEnergyValueChange : ConfigFunction<float>
{
	public enum NormalEnergyValueChangeType
	{
		pre,
		cur
	}

	public NormalEnergyValueChangeType type;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		if (memory.evt is EvtModifyNormalEnergy evtModifyNormalEnergy)
		{
			switch (type)
			{
			case NormalEnergyValueChangeType.pre:
				result = evtModifyNormalEnergy.preValue;
				break;
			case NormalEnergyValueChangeType.cur:
				result = evtModifyNormalEnergy.curValue;
				break;
			}
		}
		return result;
	}
}
