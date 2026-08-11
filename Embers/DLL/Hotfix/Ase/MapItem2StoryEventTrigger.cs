using System.Collections.Generic;

namespace Ase;

[Trigger("交互物2剧情触发器")]
public class MapItem2StoryEventTrigger : MapItemEventTrigger
{
	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public override string TriggerName => "交互物-剧情触发器";

	public override void OnDisposed()
	{
	}

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (storyEventExcuteType == StoryEventExcuteType.Start)
		{
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId);
		}
		else
		{
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId);
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
		}
	}
}
