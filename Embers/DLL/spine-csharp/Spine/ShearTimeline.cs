namespace Spine;

public class ShearTimeline : CurveTimeline2, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ShearTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 5 + "|" + boneIndex, 6 + "|" + boneIndex)
	{
		this.boneIndex = boneIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Bone bone = skeleton.bones.Items[boneIndex];
		if (!bone.active)
		{
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			switch (blend)
			{
			case MixBlend.Setup:
				bone.shearX = bone.data.shearX;
				bone.shearY = bone.data.shearY;
				break;
			case MixBlend.First:
				bone.shearX += (bone.data.shearX - bone.shearX) * alpha;
				bone.shearY += (bone.data.shearY - bone.shearY) * alpha;
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 3);
		int num2 = (int)curves[num / 3];
		float num3;
		float num4;
		switch (num2)
		{
		case 0:
		{
			float num5 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			float num6 = (time - num5) / (array[num + 3] - num5);
			num3 += (array[num + 3 + 1] - num3) * num6;
			num4 += (array[num + 3 + 2] - num4) * num6;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			break;
		}
		switch (blend)
		{
		case MixBlend.Setup:
			bone.shearX = bone.data.shearX + num3 * alpha;
			bone.shearY = bone.data.shearY + num4 * alpha;
			break;
		case MixBlend.First:
		case MixBlend.Replace:
			bone.shearX += (bone.data.shearX + num3 - bone.shearX) * alpha;
			bone.shearY += (bone.data.shearY + num4 - bone.shearY) * alpha;
			break;
		case MixBlend.Add:
			bone.shearX += num3 * alpha;
			bone.shearY += num4 * alpha;
			break;
		}
	}
}
