public class AgentActionPause : AgentAction
{
	public float mTimeScale;

	public AgentActionPause()
		: base(AgentActionFactory.E_Type.ActionPause)
	{
	}

	public override void Reset()
	{
		mTimeScale = 1f;
	}
}
