using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("TimeLine2TimeLine事件触发器")]
public class TimeLine2TimeLineEventTrigger : TimelineEventTrigger
{
	public float waitBlackScreenTime = 1.2f;

	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public override string TriggerName => "TimeLine-TimeLine事件触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (storyEventExcuteType == StoryEventExcuteType.Start)
		{
			await UniTask.WaitForSeconds(waitBlackScreenTime);
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId);
		}
		else
		{
			await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId);
			await UniTask.WaitForSeconds(waitBlackScreenTime);
			Singleton<Story>.Instance.ExecuteEvent(eventTriggers);
		}
	}
}
