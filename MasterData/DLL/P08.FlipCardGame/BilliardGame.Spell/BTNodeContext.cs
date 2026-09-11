namespace BilliardGame.Spell;

public struct BTNodeContext
{
	public int index;

	public BTNodeStatus Status;

	public float pushTime;

	public float popTime;

	public int curChildIndex;

	public int executionCount;

	public int randomNodeExecuted;

	public void Reset()
	{
		Status = BTNodeStatus.Inactive;
		executionCount = 0;
		randomNodeExecuted = 0;
	}
}
