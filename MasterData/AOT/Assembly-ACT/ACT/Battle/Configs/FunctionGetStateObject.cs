namespace ACT.Battle.Configs;

public class FunctionGetStateObject : ConfigFunction<float>
{
	public int swid;

	protected override float Evaluate(ActionMemory memory)
	{
		return MonoECS.instance.ruleManager.SharedGetState(swid);
	}
}
