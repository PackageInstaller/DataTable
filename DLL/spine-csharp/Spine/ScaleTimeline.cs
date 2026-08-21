using System;

namespace Spine;

public class ScaleTimeline : CurveTimeline2, IBoneTimeline
{
	private readonly int boneIndex;

	public int BoneIndex => boneIndex;

	public ScaleTimeline(int frameCount, int bezierCount, int boneIndex)
		: base(frameCount, bezierCount, 3 + "|" + boneIndex, 4 + "|" + boneIndex)
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
				bone.scaleX = bone.data.scaleX;
				bone.scaleY = bone.data.scaleY;
				break;
			case MixBlend.First:
				bone.scaleX += (bone.data.scaleX - bone.scaleX) * alpha;
				bone.scaleY += (bone.data.scaleY - bone.scaleY) * alpha;
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
		num3 *= bone.data.scaleX;
		num4 *= bone.data.scaleY;
		if (alpha == 1f)
		{
			if (blend == MixBlend.Add)
			{
				bone.scaleX += num3 - bone.data.scaleX;
				bone.scaleY += num4 - bone.data.scaleY;
			}
			else
			{
				bone.scaleX = num3;
				bone.scaleY = num4;
			}
		}
		else if (direction == MixDirection.Out)
		{
			switch (blend)
			{
			case MixBlend.Setup:
			{
				float scaleX = bone.data.scaleX;
				float scaleY = bone.data.scaleY;
				bone.scaleX = scaleX + (Math.Abs(num3) * (float)Math.Sign(scaleX) - scaleX) * alpha;
				bone.scaleY = scaleY + (Math.Abs(num4) * (float)Math.Sign(scaleY) - scaleY) * alpha;
				break;
			}
			case MixBlend.First:
			case MixBlend.Replace:
			{
				float scaleX = bone.scaleX;
				float scaleY = bone.scaleY;
				bone.scaleX = scaleX + (Math.Abs(num3) * (float)Math.Sign(scaleX) - scaleX) * alpha;
				bone.scaleY = scaleY + (Math.Abs(num4) * (float)Math.Sign(scaleY) - scaleY) * alpha;
				break;
			}
			case MixBlend.Add:
				bone.scaleX += (num3 - bone.data.scaleX) * alpha;
				bone.scaleY += (num4 - bone.data.scaleY) * alpha;
				break;
			}
		}
		else
		{
			switch (blend)
			{
			case MixBlend.Setup:
			{
				float scaleX = Math.Abs(bone.data.scaleX) * (float)Math.Sign(num3);
				float scaleY = Math.Abs(bone.data.scaleY) * (float)Math.Sign(num4);
				bone.scaleX = scaleX + (num3 - scaleX) * alpha;
				bone.scaleY = scaleY + (num4 - scaleY) * alpha;
				break;
			}
			case MixBlend.First:
			case MixBlend.Replace:
			{
				float scaleX = Math.Abs(bone.scaleX) * (float)Math.Sign(num3);
				float scaleY = Math.Abs(bone.scaleY) * (float)Math.Sign(num4);
				bone.scaleX = scaleX + (num3 - scaleX) * alpha;
				bone.scaleY = scaleY + (num4 - scaleY) * alpha;
				break;
			}
			case MixBlend.Add:
				bone.scaleX += (num3 - bone.data.scaleX) * alpha;
				bone.scaleY += (num4 - bone.data.scaleY) * alpha;
				break;
			}
		}
	}
}
