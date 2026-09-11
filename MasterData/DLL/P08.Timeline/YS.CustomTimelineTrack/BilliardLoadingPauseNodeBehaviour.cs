using P08Main.Loading;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class BilliardLoadingPauseNodeBehaviour : PlayableBehaviour
{
	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			if (BilliardGameLoadingDay.Instance != null && BilliardGameLoadingDay.Instance.hasLoading)
			{
				BilliardGameLoadingDay.Instance.PuaseTimeline();
			}
			if (BilliardGameLoadingNight.Instance != null && BilliardGameLoadingNight.Instance.hasLoading)
			{
				BilliardGameLoadingNight.Instance.PuaseTimeline();
			}
			if (SkuldT0GameLoading.Instance != null && SkuldT0GameLoading.Instance.hasLoading)
			{
				SkuldT0GameLoading.Instance.PuaseTimeline();
			}
			if (OathGameLoading.Instance != null && OathGameLoading.Instance.hasLoading)
			{
				OathGameLoading.Instance.PuaseTimeline();
			}
			if (HorusT0GameLoading.Instance != null && HorusT0GameLoading.Instance.hasLoading)
			{
				HorusT0GameLoading.Instance.PuaseTimeline();
			}
		}
	}
}
