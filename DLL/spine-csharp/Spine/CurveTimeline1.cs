using System;

namespace Spine;

public abstract class CurveTimeline1 : CurveTimeline
{
	public const int ENTRIES = 2;

	internal const int VALUE = 1;

	public override int FrameEntries => 2;

	public CurveTimeline1(int frameCount, int bezierCount, string propertyId)
		: base(frameCount, bezierCount, propertyId)
	{
	}

	public void SetFrame(int frame, float time, float value)
	{
		frame <<= 1;
		frames[frame] = time;
		frames[frame + 1] = value;
	}

	public float GetCurveValue(float time)
	{
		float[] array = frames;
		int num = array.Length - 2;
		for (int i = 2; i <= num; i += 2)
		{
			if (array[i] > time)
			{
				num = i - 2;
				break;
			}
		}
		int num2 = (int)curves[num >> 1];
		switch (num2)
		{
		case 0:
		{
			float num3 = array[num];
			float num4 = array[num + 1];
			return num4 + (time - num3) / (array[num + 2] - num3) * (array[num + 2 + 1] - num4);
		}
		case 1:
			return array[num + 1];
		default:
			return GetBezierValue(time, num, 1, num2 - 2);
		}
	}

	public float GetRelativeValue(float time, float alpha, MixBlend blend, float current, float setup)
	{
		if (time < frames[0])
		{
			return blend switch
			{
				MixBlend.Setup => setup, 
				MixBlend.First => current + (setup - current) * alpha, 
				_ => current, 
			};
		}
		float num = GetCurveValue(time);
		switch (blend)
		{
		case MixBlend.Setup:
			return setup + num * alpha;
		case MixBlend.First:
		case MixBlend.Replace:
			num += setup - current;
			break;
		}
		return current + num * alpha;
	}

	public float GetAbsoluteValue(float time, float alpha, MixBlend blend, float current, float setup)
	{
		if (time < frames[0])
		{
			return blend switch
			{
				MixBlend.Setup => setup, 
				MixBlend.First => current + (setup - current) * alpha, 
				_ => current, 
			};
		}
		float curveValue = GetCurveValue(time);
		if (blend == MixBlend.Setup)
		{
			return setup + (curveValue - setup) * alpha;
		}
		return current + (curveValue - current) * alpha;
	}

	public float GetAbsoluteValue(float time, float alpha, MixBlend blend, float current, float setup, float value)
	{
		if (time < frames[0])
		{
			return blend switch
			{
				MixBlend.Setup => setup, 
				MixBlend.First => current + (setup - current) * alpha, 
				_ => current, 
			};
		}
		if (blend == MixBlend.Setup)
		{
			return setup + (value - setup) * alpha;
		}
		return current + (value - current) * alpha;
	}

	public float GetScaleValue(float time, float alpha, MixBlend blend, MixDirection direction, float current, float setup)
	{
		float[] array = frames;
		if (time < array[0])
		{
			return blend switch
			{
				MixBlend.Setup => setup, 
				MixBlend.First => current + (setup - current) * alpha, 
				_ => current, 
			};
		}
		float num = GetCurveValue(time) * setup;
		if (alpha == 1f)
		{
			if (blend == MixBlend.Add)
			{
				return current + num - setup;
			}
			return num;
		}
		if (direction == MixDirection.Out)
		{
			switch (blend)
			{
			case MixBlend.Setup:
				return setup + (Math.Abs(num) * (float)Math.Sign(setup) - setup) * alpha;
			case MixBlend.First:
			case MixBlend.Replace:
				return current + (Math.Abs(num) * (float)Math.Sign(current) - current) * alpha;
			}
		}
		else
		{
			switch (blend)
			{
			case MixBlend.Setup:
			{
				float num2 = Math.Abs(setup) * (float)Math.Sign(num);
				return num2 + (num - num2) * alpha;
			}
			case MixBlend.First:
			case MixBlend.Replace:
			{
				float num2 = Math.Abs(current) * (float)Math.Sign(num);
				return num2 + (num - num2) * alpha;
			}
			}
		}
		return current + (num - setup) * alpha;
	}
}
