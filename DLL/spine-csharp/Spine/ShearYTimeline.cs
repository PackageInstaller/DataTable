namespace Spine;

public class ShearYTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ShearYTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 6 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.shearY = GetRelativeValue(time, alpha, blend, bone.shearY, bone.data.shearY);
		}
	}
}
