namespace Spine;

public class ScaleXTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ScaleXTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 3 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.scaleX = GetScaleValue(time, alpha, blend, direction, bone.scaleX, bone.data.scaleX);
		}
	}
}
