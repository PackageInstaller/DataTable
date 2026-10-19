using System;
using System.Collections.Generic;

namespace ACT.Sound;

public class CGAudioInstance
{
	public uint AudioId;

	public string EventPath;

	public IntPtr Handle;

	public readonly List<CGTimelineMarker> Markers = new List<CGTimelineMarker>();
}
