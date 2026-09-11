public class AgentActionHurt : AgentAction
{
	public long DamageAmount;

	public DamageType damageType;

	public int ActionID;

	public int SourceID;

	public int ThrownID;

	public int partID;

	public AgentActionHurt()
		: base(AgentActionFactory.E_Type.Hurt)
	{
	}
}
