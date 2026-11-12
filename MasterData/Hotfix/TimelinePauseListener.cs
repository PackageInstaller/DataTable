using System.Collections.Generic;
using UnityEngine.Playables;

public class TimelinePauseListener : LogicEntity
{
	public List<PlayableDirector> pauseTimelineList;

	protected override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("PAUSE_LOGIC", OnLogicPaused);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("RESUME_LOGIC", OnLogicResumed);
	}

	protected void OnLogicPaused(IEvent _)
	{
		List<PlayableDirector> list = pauseTimelineList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (PlayableDirector pauseTimeline in pauseTimelineList)
		{
			pauseTimeline?.Pause();
		}
	}

	protected void OnLogicResumed(IEvent _)
	{
		List<PlayableDirector> list = pauseTimelineList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (PlayableDirector pauseTimeline in pauseTimelineList)
		{
			pauseTimeline?.Resume();
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PAUSE_LOGIC", OnLogicPaused);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("RESUME_LOGIC", OnLogicResumed);
	}
}
