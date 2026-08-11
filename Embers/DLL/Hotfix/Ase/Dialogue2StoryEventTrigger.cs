using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("对话链2剧情事件触发器")]
public class Dialogue2StoryEventTrigger : DialogueChainEventTrigger
{
	public int storyId;

	public StoryEventExcuteType storyEventExcuteType = StoryEventExcuteType.End;

	public List<TimelineEventTrigger> eventTriggers = new List<TimelineEventTrigger>();

	public override string TriggerName => "NPC-剧情事件触发器";

	protected override async UniTask DoExecuteAsync()
	{
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
