using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

public class CriAtomClip : PlayableAsset, ITimelineClipAsset
{
	public string cueSheet;

	public string cueName;

	public bool stopWithoutRelease;

	public bool muted;

	public bool ignoreBlend;

	public bool loopWithinClip;

	public bool stopAtClipEnd = true;

	public CriAtomBehaviour templateBehaviour = new CriAtomBehaviour();

	[SerializeField]
	[HideInInspector]
	private double clipDuration;

	public ClipCaps clipCaps => ClipCaps.Looping | ClipCaps.SpeedMultiplier | ClipCaps.Blending;

	public override double duration
	{
		get
		{
			if (!(clipDuration > 0.0))
			{
				return 2.0;
			}
			return clipDuration;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<CriAtomBehaviour>.Create(graph, templateBehaviour);
	}

	public void SetClipDuration(double clipDuration)
	{
		this.clipDuration = clipDuration;
	}
}
