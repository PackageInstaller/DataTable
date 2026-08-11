namespace Spine;

public class InheritTimeline : Timeline, IBoneTimeline
{
	public const int ENTRIES = 2;

	public const int INHERIT = 1;

	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public override int FrameEntries => 2;

	public InheritTimeline(int frameCount, int boneIndex)
		: base(frameCount, 7 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public void SetFrame(int frame, float time, Inherit inherit)
	{
		frame *= 2;
		frames[frame] = time;
		frames[frame + 1] = (float)inherit;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (!bone.active)
		{
			return;
		}
		if (direction == MixDirection.Out)
		{
			if (blend == MixBlend.Setup)
			{
				bone.inherit = bone.data.inherit;
			}
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			if (blend == MixBlend.Setup || blend == MixBlend.First)
			{
				bone.inherit = bone.data.inherit;
			}
		}
		else
		{
			bone.inherit = InheritEnum.Values[(int)array[Timeline.Search(array, time, 2) + 1]];
		}
	}
}
