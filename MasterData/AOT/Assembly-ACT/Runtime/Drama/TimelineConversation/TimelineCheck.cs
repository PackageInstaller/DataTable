using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Runtime.Drama.TimelineConversation;

public class TimelineCheck : MonoBehaviour
{
	private void Start()
	{
		PlayableDirector component = gameObject.GetComponent<PlayableDirector>();
		if (component == null)
		{
			return;
		}
		foreach (TrackAsset outputTrack in (component.playableAsset as TimelineAsset).GetOutputTracks())
		{
			Object genericBinding = component.GetGenericBinding(outputTrack);
			Debug.Log("Track: " + outputTrack.name + ", Binding: " + (genericBinding ? genericBinding.name : "NULL"));
		}
	}
}
