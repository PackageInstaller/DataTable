namespace Spine;

public class ShearXTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ShearXTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 5 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.shearX = GetRelativeValue(time, alpha, blend, bone.shearX, bone.data.shearX);
		}
	}
}
