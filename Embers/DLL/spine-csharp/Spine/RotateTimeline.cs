namespace Spine;

public class RotateTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public RotateTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 0 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.rotation = GetRelativeValue(time, alpha, blend, bone.rotation, bone.data.rotation);
		}
	}
}
