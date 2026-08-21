namespace Spine;

public class TranslateXTimeline : CurveTimeline1, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public TranslateXTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 1 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (bone.active)
		{
			bone.x = GetRelativeValue(time, alpha, blend, bone.x, bone.data.x);
		}
	}
}
