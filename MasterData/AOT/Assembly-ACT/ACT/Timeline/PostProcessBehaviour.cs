using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering;

namespace ACT.Timeline;

[Serializable]
public class PostProcessBehaviour : PlayableBehaviour
{
	[HideInInspector]
	public Volume volume;

	public VolumeProfile profile;

	public int layer;

	public AnimationCurve weightCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (profile != null)
		{
			QuickVolume();
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (volume != null)
		{
			UnityEngine.Object.DestroyImmediate(volume.gameObject);
		}
	}

	private void QuickVolume()
	{
		if (volume == null)
		{
			volume = new GameObject().AddComponent<Volume>();
			volume.gameObject.layer = layer;
			volume.gameObject.hideFlags = HideFlags.DontSave | HideFlags.NotEditable;
			volume.gameObject.name = "PostProcessBehaviourVolume [Profile " + profile.name + "]";
			volume.weight = 0f;
			volume.priority = 1f;
			volume.isGlobal = true;
			volume.profile = profile;
		}
	}

	public void ChangeWeight(float time)
	{
		if (!(volume == null))
		{
			volume.weight = weightCurve.Evaluate(time);
		}
	}
}
