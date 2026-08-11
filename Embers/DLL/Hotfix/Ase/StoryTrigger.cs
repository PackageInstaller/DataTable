using System.Collections.Generic;

namespace Ase;

[Trigger("播放剧情触发器")]
public class StoryTrigger : BaseTrigger
{
	public int timeLineID;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public override string TriggerName => "播放剧情触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (storyEventExcuteType == StoryEventExcuteType.Start)
		{
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, timeLineID);
		}
		else
		{
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, timeLineID);
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
		}
	}
}
