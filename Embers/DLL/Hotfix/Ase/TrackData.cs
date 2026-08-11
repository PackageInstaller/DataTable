using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public struct TrackData
{
	[HideInInspector]
	public int trackIndex;

	public List<FusionTrackEntryData> tracks;
}
