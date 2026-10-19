using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public sealed class ConversationCGMixerBehaviour : PlayableBehaviour
{
	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		MonoConversationCG cG = GetCG();
		if (!cG)
		{
			return;
		}
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			if (playable.GetInputWeight(i) > 0f)
			{
				return;
			}
		}
		cG.ClearImage();
	}

	public override void OnGraphStop(Playable playable)
	{
		if (Application.isPlaying)
		{
			GetCG()?.ClearImage();
		}
	}

	private static MonoConversationCG GetCG()
	{
		return MonoConversationCG.Instance;
	}
}
