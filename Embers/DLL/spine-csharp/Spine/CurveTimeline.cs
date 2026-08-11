using System;

namespace Spine;

public abstract class CurveTimeline : Timeline
{
	public const int LINEAR = 0;

	public const int STEPPED = 1;

	public const int BEZIER = 2;

	public const int BEZIER_SIZE = 18;

	internal float[] curves;

	public CurveTimeline(int frameCount, int bezierCount, params string[] propertyIds)
		: base(frameCount, propertyIds)
	{
		curves = new float[frameCount + bezierCount * 18];
		curves[frameCount - 1] = 1f;
	}

	public void SetLinear(int frame)
	{
		curves[frame] = 0f;
	}

	public void SetStepped(int frame)
	{
		curves[frame] = 1f;
	}

	public float GetCurveType(int frame)
	{
		return (int)curves[frame];
	}

	public void Shrink(int bezierCount)
	{
		int num = FrameCount + bezierCount * 18;
		if (curves.Length > num)
		{
			float[] destinationArray = new float[num];
			Array.Copy(curves, 0, destinationArray, 0, num);
			curves = destinationArray;
		}
	}

	public void SetBezier(int bezier, int frame, int value, float time1, float value1, float cx1, float cy1, float cx2, float cy2, float time2, float value2)
	{
		float[] array = curves;
		int i = FrameCount + bezier * 18;
		if (value == 0)
		{
			array[frame] = 2 + i;
		}
		float num = (time1 - cx1 * 2f + cx2) * 0.03f;
		float num2 = (value1 - cy1 * 2f + cy2) * 0.03f;
		float num3 = ((cx1 - cx2) * 3f - time1 + time2) * 0.006f;
		float num4 = ((cy1 - cy2) * 3f - value1 + value2) * 0.006f;
		float num5 = num * 2f + num3;
		float num6 = num2 * 2f + num4;
		float num7 = (cx1 - time1) * 0.3f + num + num3 * (1f / 6f);
		float num8 = (cy1 - value1) * 0.3f + num2 + num4 * (1f / 6f);
		float num9 = time1 + num7;
		float num10 = value1 + num8;
		for (int num11 = i + 18; i < num11; i += 2)
		{
			array[i] = num9;
			array[i + 1] = num10;
			num7 += num5;
			num8 += num6;
			num5 += num3;
			num6 += num4;
			num9 += num7;
			num10 += num8;
		}
	}

	public float GetBezierValue(float time, int frameIndex, int valueOffset, int i)
	{
		float[] array = curves;
		if (array[i] > time)
		{
			float num = frames[frameIndex];
			float num2 = frames[frameIndex + valueOffset];
			return num2 + (time - num) / (array[i] - num) * (array[i + 1] - num2);
		}
		int num3 = i + 18;
		for (i += 2; i < num3; i += 2)
		{
			if (array[i] >= time)
			{
				float num4 = array[i - 2];
				float num5 = array[i - 1];
				return num5 + (time - num4) / (array[i] - num4) * (array[i + 1] - num5);
			}
		}
		frameIndex += FrameEntries;
		float num6 = array[num3 - 2];
		float num7 = array[num3 - 1];
		return num7 + (time - num6) / (frames[frameIndex] - num6) * (frames[frameIndex + valueOffset] - num7);
	}
}
