using P08Main.Loading;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldLoadingEnterBehaviour : PlayableBehaviour
{
	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			if (SkuldT0GameLoading.Instance != null && SkuldT0GameLoading.Instance.hasLoading)
			{
				SkuldT0GameLoading.Instance.EnterLoading();
			}
			if (HorusT0GameLoading.Instance != null && HorusT0GameLoading.Instance.hasLoading)
			{
				HorusT0GameLoading.Instance.EnterLoading();
			}
		}
	}
}
