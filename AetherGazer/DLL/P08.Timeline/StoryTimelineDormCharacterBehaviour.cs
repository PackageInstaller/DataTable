using UnityEngine.Playables;

public abstract class StoryTimelineDormCharacterBehaviour : PlayableBehaviour
{
	private bool isRunning;

	public void SetWeight(float weight)
	{
		if (isRunning && weight == 0f)
		{
			isRunning = false;
			Exit();
		}
		if (!isRunning && weight == 1f)
		{
			isRunning = true;
			Enter();
		}
	}

	protected abstract void Enter();

	protected abstract void Exit();
}
