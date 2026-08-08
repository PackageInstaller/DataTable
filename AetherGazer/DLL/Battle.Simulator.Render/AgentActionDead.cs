public class AgentActionDead : AgentAction
{
	public int DamageAmount;

	public AgentActionDead()
		: base(AgentActionFactory.E_Type.Dead)
	{
	}
}
