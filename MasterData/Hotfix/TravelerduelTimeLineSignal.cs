using UnityEngine;

public class TravelerduelTimeLineSignal : MonoBehaviour
{
	public void StartSignal(bool isStart)
	{
		AdventureLevelTimelineLoadingViewEvent adventureLevelTimelineLoadingViewEvent = AdventureLevelTimelineLoadingViewEvent.Generate();
		adventureLevelTimelineLoadingViewEvent.isStart = isStart;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelTimelineLoadingViewEvent);
	}
}
