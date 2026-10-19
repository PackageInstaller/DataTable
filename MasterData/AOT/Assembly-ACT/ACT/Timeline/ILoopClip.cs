using UnityEngine.Timeline;

namespace ACT.Timeline;

public interface ILoopClip
{
	TimelineClip Clip { get; set; }
}
