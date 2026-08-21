using System.Collections.Generic;

namespace Ase;

[Trigger("怪物组2播放剧情触发器")]
public class MonsterGroup2StoryEventTrigger : MonsterGroupEventTrigger
{
	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public override string TriggerName => "怪物组-播放剧情触发器";

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
