using Animancer;
using T0World;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldBedEmojiNodeeBehaviour : PlayableBehaviour
{
	public bool endingHideEmoji;

	private AnimancerComponent cachedAnimancerCom;

	private const float EMOTE_FADE_IN_TIME = 0.3f;

	private const float EMOTE_FADE_OUT_TIME = 0.3f;

	private AnimancerLayer BaseLayer
	{
		get
		{
			if (!cachedAnimancerCom)
			{
				return null;
			}
			return cachedAnimancerCom.Layers.get_Item(0);
		}
	}

	private AnimancerLayer EmoteLayer
	{
		get
		{
			if (!cachedAnimancerCom)
			{
				return null;
			}
			return cachedAnimancerCom.Layers.get_Item(1);
		}
	}

	private void CacheAnimancerCom(Animator animator)
	{
		if (!cachedAnimancerCom && (bool)animator)
		{
			cachedAnimancerCom = animator.GetComponentInChildren<AnimancerComponent>();
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		Animator animator = info.output.GetUserData() as Animator;
		CacheAnimancerCom(animator);
		EmoteLayer.StartFade(1f, 0.3f);
		if (T0BedGame.bedGame != null)
		{
			T0BedGame.bedGame.PlayEmoji();
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (endingHideEmoji)
		{
			Animator animator = info.output.GetUserData() as Animator;
			CacheAnimancerCom(animator);
			if ((bool)T0BedGame.bedGame)
			{
				T0BedGame.bedGame.StopEmoji();
			}
			EmoteLayer?.StartFade(0f, 0.3f);
		}
	}
}
