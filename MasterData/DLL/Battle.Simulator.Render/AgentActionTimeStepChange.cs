public class AgentActionTimeStepChange : AgentAction
{
	public int mAbilityID;

	public float mTimeScale = 1f;

	public bool mIsIdle;

	public AgentActionTimeStepChange()
		: base(AgentActionFactory.E_Type.TimeStepChange)
	{
	}

	public override void Reset()
	{
		mIsIdle = false;
		mAbilityID = 0;
		mTimeScale = 1f;
	}
}
