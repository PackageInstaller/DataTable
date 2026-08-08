using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class HeroUITimelineSignalReceiver : MonoBehaviour, INotificationReceiver
{
	public HeroUITimelineBrain brain;

	public Dictionary<TrackAsset, int> trackOutputIndex = new Dictionary<TrackAsset, int>();

	public void OnNotify(Playable origin, INotification notification, object context)
	{
		if (notification is IHeroUITimelineNotification heroUITimelineNotification)
		{
			heroUITimelineNotification.OnNotify(new HeroUITimelineNotificationContext
			{
				playable = origin,
				brain = brain,
				receiver = this
			});
		}
	}
}
