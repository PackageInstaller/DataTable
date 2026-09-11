using Entitas;

internal class PredictionMovementSystem : ISystem, IExecuteSystem
{
	private SimContext mSimContext;

	public PredictionMovementSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Execute()
	{
		Process_MoveDirection();
	}

	private void Process_MoveDirection()
	{
	}
}
