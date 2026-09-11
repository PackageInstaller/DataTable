using System.Collections.Generic;

public class AgentActionAbilityLeave : AgentAction
{
	internal uint mFrameCount;

	internal List<Int2> mTracks = new List<Int2>();

	public AgentActionAbilityLeave()
		: base(AgentActionFactory.E_Type.AbilityLeave)
	{
	}

	public override void Reset()
	{
		base.Reset();
		mFrameCount = 0u;
		if (mTracks != null)
		{
			mTracks.Clear();
		}
	}
}
