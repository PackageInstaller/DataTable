using System;
using Unity.Collections;
using UnityEngine;

public class TextureUtil
{
	public static bool SampleSpriteIsBlack(Sprite sprite, int sampleWidthRate = 10, int sampleHeightRate = 10)
	{
		if (sprite == null)
		{
			return true;
		}
		try
		{
			NativeArray<Color> rawTextureData = sprite.texture.GetRawTextureData<Color>();
			int num = 0;
			int num2 = sampleWidthRate * sampleHeightRate;
			if (rawTextureData.IsCreated)
			{
				int num3 = (int)sprite.rect.height;
				int num4 = (int)sprite.rect.width;
				int length = rawTextureData.Length;
				int num5 = (int)((float)num4 * 1f / (float)sampleWidthRate);
				int num6 = (int)((float)num3 * 1f / (float)sampleHeightRate);
				for (int i = 0; i < sampleHeightRate; i++)
				{
					for (int j = 0; j < sampleWidthRate; j++)
					{
						int num7 = Math.Max(0, Math.Min(num4 - 1, num5 * j));
						int num8 = Math.Max(0, Math.Min(num3 - 1, num6 * i));
						if (num4 * num8 + num7 < length)
						{
							Color color = rawTextureData[num4 * num8 + num7];
							if (!((double)Mathf.Abs(color.r) < 1E-06) || !((double)Mathf.Abs(color.g) < 1E-06) || !((double)Mathf.Abs(color.b) < 1E-06))
							{
								break;
							}
							num++;
						}
						else
						{
							num2--;
						}
					}
				}
				if (num == num2)
				{
					return true;
				}
				return false;
			}
			return true;
		}
		catch
		{
			return true;
		}
	}
}
