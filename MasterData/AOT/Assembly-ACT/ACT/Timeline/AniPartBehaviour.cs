using ACT.Battle;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class AniPartBehaviour : PlayableBehaviour
{
	public AniPartControl.PartType partType;

	public bool isReverse;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		AniPartControl aniPartControl = playerData as AniPartControl;
		if (aniPartControl == null || aniPartControl.aniParts == null || !aniPartControl.aniParts.TryGetValue(partType, out var value))
		{
			return;
		}
		double duration = playable.GetDuration();
		float num = (float)(playable.GetTime() / duration);
		if (isReverse)
		{
			num = 1f - num;
		}
		float curVal = Mathf.Clamp01(num);
		AniPart[] array = value;
		foreach (AniPart aniPart in array)
		{
			if (aniPart != null)
			{
				aniPart.curVal = curVal;
				aniPart.running = true;
				aniPart.UpdateCurPlaybackProgress(0f);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		AniPartControl aniPartControl = info.output.GetUserData() as AniPartControl;
		if (aniPartControl == null || aniPartControl.aniParts == null || !aniPartControl.aniParts.TryGetValue(partType, out var value))
		{
			return;
		}
		AniPart[] array = value;
		foreach (AniPart aniPart in array)
		{
			if (aniPart != null)
			{
				aniPart.running = false;
			}
		}
	}
}
