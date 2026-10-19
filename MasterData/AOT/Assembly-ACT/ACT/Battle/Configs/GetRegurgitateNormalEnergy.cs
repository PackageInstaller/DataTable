namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取返还普通能量", "Function", new string[] { "get", "regurgitate", "normal", "energy" })]
public class GetRegurgitateNormalEnergy : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (memory.evt is EvtRegurgitateNormalEnergy evtRegurgitateNormalEnergy)
		{
			return evtRegurgitateNormalEnergy.value;
		}
		return 0f;
	}
}
