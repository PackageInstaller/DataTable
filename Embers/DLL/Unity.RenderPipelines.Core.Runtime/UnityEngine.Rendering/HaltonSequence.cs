namespace UnityEngine.Rendering;

public static class HaltonSequence
{
	public static float Get(int index, int radix)
	{
		float num = 0f;
		float num2 = 1f / (float)radix;
		while (index > 0)
		{
			num += (float)(index % radix) * num2;
			index /= radix;
			num2 /= (float)radix;
		}
		return num;
	}
}
