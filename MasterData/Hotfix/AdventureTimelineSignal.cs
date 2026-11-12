using UnityEngine;

public class AdventureTimelineSignal : MonoBehaviour
{
	public void StartSignal(bool isStart)
	{
		AdventureLevelTimelineLoadingViewEvent adventureLevelTimelineLoadingViewEvent = AdventureLevelTimelineLoadingViewEvent.Generate();
		adventureLevelTimelineLoadingViewEvent.isStart = isStart;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelTimelineLoadingViewEvent);
	}
}
