namespace Spine;

public abstract class CurveTimeline2 : CurveTimeline
{
	public const int ENTRIES = 3;

	internal const int VALUE1 = 1;

	internal const int VALUE2 = 2;

	public override int FrameEntries => 3;

	public CurveTimeline2(int frameCount, int bezierCount, string propertyId1, string propertyId2)
		: base(frameCount, bezierCount, propertyId1, propertyId2)
	{
	}

	public void SetFrame(int frame, float time, float value1, float value2)
	{
		frame *= 3;
		frames[frame] = time;
		frames[frame + 1] = value1;
		frames[frame + 2] = value2;
	}
}
