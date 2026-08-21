public class AgentActionAbilityEnter : AgentAction
{
	public int mFrameCount;

	public float mTimeScale = 1f;

	public int mAblityID;

	public AgentActionAbilityEnter()
		: base(AgentActionFactory.E_Type.AbilityEnter)
	{
	}

	public override void Reset()
	{
		base.Reset();
		mTimeScale = 1f;
		mFrameCount = 0;
		mAblityID = 0;
	}
}
