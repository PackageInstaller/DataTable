namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取能量", "Function", new string[] { "get", "consume", "energy" })]
public class GetConsumeEnergy : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (memory.evt is EvtModifyNormalEnergy { state: ActionChangeNormalEnergy.State.Normal } evtModifyNormalEnergy)
		{
			return evtModifyNormalEnergy.preValue - evtModifyNormalEnergy.curValue;
		}
		return 0f;
	}
}
