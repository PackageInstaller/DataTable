using UnityEngine;
using UnityEngine.Playables;

namespace Ase;

public class AnimationSwitchBehaviour : PlayableBehaviour
{
	public string animationName;

	private bool finished;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.PrepareFrame(playable, info);
		if (Application.isPlaying && !finished)
		{
			finished = true;
			((Animator)((playerData is Animator) ? playerData : null)).CrossFade(animationName, 0f);
		}
	}
}
