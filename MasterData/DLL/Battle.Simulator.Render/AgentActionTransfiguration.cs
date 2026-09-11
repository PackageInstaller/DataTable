public class AgentActionTransfiguration : AgentAction
{
	public int oldRoleID;

	public int newRoleID;

	public AgentActionTransfiguration()
		: base(AgentActionFactory.E_Type.Transfiguration)
	{
	}

	public override void Reset()
	{
		base.Reset();
		oldRoleID = 0;
		newRoleID = 0;
	}
}
