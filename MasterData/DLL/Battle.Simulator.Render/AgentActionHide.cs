public class AgentActionHide : AgentAction
{
	public bool IsHide;

	public AgentActionHide()
		: base(AgentActionFactory.E_Type.Hide)
	{
	}
}
