using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class FusionSettingData
{
	public bool openMix;

	public float touchInterval;

	[HideInInspector]
	public string idleName;

	[HideInInspector]
	public FusionTrackEntryData idleMainTrack;

	[HideInInspector]
	public FusionTrackEntryData idleFaceTrack;

	[HideInInspector]
	public FusionTrackEntryData idleTalkTrack;

	[HideInInspector]
	public TrackData idleExtraTracks;

	[HideInInspector]
	public BubbleData idleBubbleData;

	[HideInInspector]
	public List<AudioClipData> idleAudioTracks = new List<AudioClipData>();

	[HideInInspector]
	public List<FusionData> idleSpineList = new List<FusionData>();

	[HideInInspector]
	public List<FusionData> newSpineList;
}
