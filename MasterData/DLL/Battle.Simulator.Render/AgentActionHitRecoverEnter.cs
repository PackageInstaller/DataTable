public class AgentActionHitRecoverEnter : AgentAction
{
	public int TimelineID;

	public bool IsReset;

	public string effectName = string.Empty;

	public AgentActionHitRecoverEnter()
		: base(AgentActionFactory.E_Type.HitRecoverEnter)
	{
	}

	public override void Reset()
	{
		TimelineID = 0;
		IsReset = false;
		effectName = string.Empty;
	}
}
