using System.Collections.Generic;

namespace UnityEngine;

public interface IAnimationClipSource
{
	void GetAnimationClips(List<AnimationClip> results);
}
