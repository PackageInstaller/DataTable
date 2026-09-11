using Dorm;

public class StoryTimelineDormCharacterAnimNodeBehaviour : StoryTimelineDormCharacterBehaviour
{
	public int actorIndex;

	public string prefabPath;

	public bool appleRootMotion;

	protected override void Enter()
	{
		if (DormStoryManager.instance.hasInited)
		{
			DormStoryManager.instance.PlayTimeline(actorIndex, prefabPath, appleRootMotion);
		}
	}

	protected override void Exit()
	{
	}
}
