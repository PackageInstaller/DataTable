using System;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public sealed class ConversationCGBehaviour : PlayableBehaviour
{
	public ConversationCGClip clip;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying && !(clip == null))
		{
			MonoConversationCG cG = GetCG();
			if ((bool)cG)
			{
				cG.SetImage(clip.cgId, clip.PreloadedSprite);
				cG.SetAlpha(0f);
			}
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || clip == null)
		{
			return;
		}
		MonoConversationCG cG = GetCG();
		if ((bool)cG)
		{
			double num = Math.Max(0.0, playable.GetTime());
			float num2 = 1f;
			if (clip.fadeInTime > 0f)
			{
				num2 = Mathf.Min(num2, Mathf.Clamp01((float)(num / (double)clip.fadeInTime)));
			}
			double duration = playable.GetDuration();
			if (clip.fadeOutTime > 0f && duration > 0.0)
			{
				num2 = Mathf.Min(num2, Mathf.Clamp01((float)((duration - num) / (double)clip.fadeOutTime)));
			}
			cG.SetImage(clip.cgId, clip.PreloadedSprite);
			cG.SetAlpha(num2);
		}
	}

	private static MonoConversationCG GetCG()
	{
		return MonoConversationCG.Instance;
	}
}
