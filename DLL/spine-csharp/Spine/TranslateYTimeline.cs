namespace Spine;

public class TranslateYTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public TranslateYTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 2 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.y = GetRelativeValue(time, alpha, blend, bone.y, bone.data.y);
		}
	}
}
