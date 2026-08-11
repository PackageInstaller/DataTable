namespace Spine;

public class ScaleYTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ScaleYTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 4 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.scaleY = GetScaleValue(time, alpha, blend, direction, bone.scaleY, bone.data.scaleY);
		}
	}
}
