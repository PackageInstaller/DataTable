public class SimGameOverEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public GameOverState state;

	public E_BattleResult isVectory;

	public int timeScale = 100;

	public int countdown;

	public override void OnEnterPool()
	{
		state = GameOverState.start;
		isVectory = E_BattleResult.None;
		timeScale = 100;
		countdown = 0;
	}

	public static SimGameOverEvent Claim(GameOverState state, E_BattleResult isVectory, int timeScale, int countdown)
	{
		SimGameOverEvent simGameOverEvent = FrameObjectPool<SimGameOverEvent>.Claim();
		simGameOverEvent.state = state;
		simGameOverEvent.isVectory = isVectory;
		simGameOverEvent.timeScale = timeScale;
		simGameOverEvent.countdown = countdown;
		return simGameOverEvent;
	}

	public override void Release()
	{
		FrameObjectPool<SimGameOverEvent>.Release(this);
	}
}
