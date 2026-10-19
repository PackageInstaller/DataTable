namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取累积伤害", "Function", new string[] { "accumulate", "damage" })]
public class AccumulateDamage : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		if (memory.evt is EvtAccumulateDamage evtAccumulateDamage)
		{
			result = evtAccumulateDamage.AccumulatedDamage;
		}
		return result;
	}
}
