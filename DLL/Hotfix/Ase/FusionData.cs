using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace Ase;

[Serializable]
public class FusionData
{
	public string name;

	public TrackData mainTrack;

	public TrackData faceTrack;

	public TrackData talkTrack;

	public List<TrackData> extraTracks = new List<TrackData>();

	public BubbleData bubbleData;

	public float length = 3f;

	[SerializeField]
	[FormerlySerializedAs("audioTracks")]
	public List<AudioClipData> audioTracksDatas = new List<AudioClipData>();
}
