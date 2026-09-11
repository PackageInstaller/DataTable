public class AgentActionSubJoystickCommandUpdate : AgentAction
{
	public int CommandCode;

	public int TimelineID;

	public AgentActionSubJoystickCommandUpdate()
		: base(AgentActionFactory.E_Type.SubJoystickUpdate)
	{
	}

	public override void Reset()
	{
		base.Reset();
		CommandCode = 0;
		TimelineID = 0;
	}
}
