using Config;
using Google.Protobuf.Collections;

public struct FixedCurve
{
	public int Index;

	public int Evalue(int time, RepeatedField<Keyframe> keyframes)
	{
		if (!PreEvalue(time, ref Index, keyframes, out var from, out var to))
		{
			return from.Value;
		}
		return Evaluate(time, from, to).integer;
	}

	private static bool PreEvalue(int time, ref int index, RepeatedField<Keyframe> keyframes, out Keyframe from, out Keyframe to)
	{
		if (index >= keyframes.Count)
		{
			from = keyframes.get_Item(keyframes.Count - 1);
			to = null;
			return false;
		}
		Keyframe keyframe = keyframes.get_Item(index);
		if (time > keyframe.Time)
		{
			index++;
		}
		if (index - 1 >= 0 && index < keyframes.Count)
		{
			from = keyframes.get_Item(index - 1);
			to = keyframes.get_Item(index);
			return true;
		}
		from = keyframe;
		to = null;
		return false;
	}

	private static VFactor Evaluate(int time, Keyframe from, Keyframe to)
	{
		float num = (float)(to.Time - from.Time) / 1000f;
		float t = 0f;
		float m = 0f;
		float m2 = 0f;
		if (0f != num)
		{
			t = (float)(time - from.Time) / 1000f / num;
			m = (float)from.OutSlope * num / 1000f;
			m2 = (float)to.InSlope * num / 1000f;
		}
		return HermiteInterpolate(t, (float)from.Value / 1000f, m, m2, (float)to.Value / 1000f);
	}

	private static VFactor HermiteInterpolate(float t, float p0, float m0, float m1, float p1)
	{
		float num = t * t;
		float num2 = num * t;
		float num3 = 2f * num2 - 3f * num + 1f;
		float num4 = num2 - 2f * num + t;
		float num5 = num2 - num;
		float num6 = -2f * num2 + 3f * num;
		return (VFactor)((num3 * p0 + num4 * m0 + num5 * m1 + num6 * p1) * 1000f);
	}
}
