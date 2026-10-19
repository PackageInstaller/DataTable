namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改状态", "Action", new string[] { "change", "state", "status", "tag" })]
public class ActionChangeState : ConfigAction
{
	public int state;

	public override void Do(ActionMemory memory)
	{
	}
}
