public class AIWaitCommand : AICommand
{
	public bool mSucceedWhenTimeOut;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
	}

	protected override void OnTimeout()
	{
		if (mSucceedWhenTimeOut)
		{
			mStatus = AIProcessor.AICommandStatus.Success;
		}
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		return AIProcessor.AICommandStatus.Running;
	}
}
