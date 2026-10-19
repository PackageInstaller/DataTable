using UnityEngine;

namespace XPostProcessing;

public class VolumeUtility
{
	private static int resetFrameCount;

	private static Color srcColor;

	private static Color dstColor;

	public static Color GetRandomLerpColor(int RandomFrameCount, float lerpSpeed)
	{
		if (resetFrameCount == 0)
		{
			srcColor = new Color(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f), 1f);
		}
		dstColor = Color.Lerp(dstColor, srcColor, lerpSpeed);
		resetFrameCount++;
		if (resetFrameCount > RandomFrameCount)
		{
			resetFrameCount = 0;
		}
		return dstColor;
	}

	public static Color RandomColor()
	{
		return new Color(Random.value, Random.value, Random.value, Random.value);
	}
}
