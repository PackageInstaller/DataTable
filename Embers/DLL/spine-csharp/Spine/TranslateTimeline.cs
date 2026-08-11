namespace Spine;

public class TranslateTimeline : CurveTimeline2, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public TranslateTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 1 + "|" + boneIndex, 2 + "|" + boneIndex)
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
				bone.x = bone.data.x;
				bone.y = bone.data.y;
				break;
			case MixBlend.First:
				bone.x += (bone.data.x - bone.x) * alpha;
				bone.y += (bone.data.y - bone.y) * alpha;
				break;
			}
			return;
		}
		GetCurveValue(out var x, out var y, time);
		switch (blend)
		{
		case MixBlend.Setup:
			bone.x = bone.data.x + x * alpha;
			bone.y = bone.data.y + y * alpha;
			break;
		case MixBlend.First:
		case MixBlend.Replace:
			bone.x += (bone.data.x + x - bone.x) * alpha;
			bone.y += (bone.data.y + y - bone.y) * alpha;
			break;
		case MixBlend.Add:
			bone.x += x * alpha;
			bone.y += y * alpha;
			break;
		}
	}

	public void GetCurveValue(out float x, out float y, float time)
	{
		int num = Timeline.Search(frames, time, 3);
		int num2 = (int)curves[num / 3];
		switch (num2)
		{
		case 0:
		{
			float num3 = frames[num];
			x = frames[num + 1];
			y = frames[num + 2];
			float num4 = (time - num3) / (frames[num + 3] - num3);
			x += (frames[num + 3 + 1] - x) * num4;
			y += (frames[num + 3 + 2] - y) * num4;
			break;
		}
		case 1:
			x = frames[num + 1];
			y = frames[num + 2];
			break;
		default:
			x = GetBezierValue(time, num, 1, num2 - 2);
			y = GetBezierValue(time, num, 2, num2 + 18 - 2);
			break;
		}
	}
}
