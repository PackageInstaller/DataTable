using P08Main.Loading;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class BilliardLoadingCloseNodeBehaviour : PlayableBehaviour
{
	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			if (BilliardGameLoadingDay.Instance != null && BilliardGameLoadingDay.Instance.hasLoading)
			{
				BilliardGameLoadingDay.Instance.TimelineFinished();
			}
			if (BilliardGameLoadingNight.Instance != null && BilliardGameLoadingNight.Instance.hasLoading)
			{
				BilliardGameLoadingNight.Instance.TimelineFinished();
			}
			if (SkuldT0GameLoading.Instance != null && SkuldT0GameLoading.Instance.hasLoading)
			{
				SkuldT0GameLoading.Instance.TimelineFinished();
			}
			if (OathGameLoading.Instance != null && OathGameLoading.Instance.hasLoading)
			{
				OathGameLoading.Instance.TimelineFinished();
			}
			if (HorusT0GameLoading.Instance != null && HorusT0GameLoading.Instance.hasLoading)
			{
				HorusT0GameLoading.Instance.TimelineFinished();
			}
		}
	}
}
