using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct ConfigMotionFrameRange
{
	public int startFrame;

	public int endFrame;

	public int sourceTotalFrames;

	public bool HasFrame => startFrame > 0;
}
