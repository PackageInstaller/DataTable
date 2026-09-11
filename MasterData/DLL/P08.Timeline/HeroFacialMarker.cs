using UnityEngine.Animations;
using UnityEngine.Timeline;

public class HeroFacialMarker : Marker, INotificationOptionProvider, IHeroUITimelineMarker
{
	public string matchedTalking;

	public NotificationFlags flags => NotificationFlags.Retroactive;

	public void OnBindingTrack(HeroUITimelineMarkerContext context)
	{
	}

	public void AfterBuildGraph(HeroUITimelineMarkerContext context)
	{
		if (!(matchedTalking == context.brain.talking) && context.output.IsPlayableOutputOfType<AnimationPlayableOutput>())
		{
			((AnimationPlayableOutput)context.output).SetTarget(null);
		}
	}
}
