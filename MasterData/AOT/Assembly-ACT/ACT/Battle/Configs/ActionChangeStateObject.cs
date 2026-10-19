namespace ACT.Battle.Configs;

public class ActionChangeStateObject : ConfigAction
{
	public int swid;

	public int newState;

	public override void Do(ActionMemory memory)
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, newState);
	}
}
