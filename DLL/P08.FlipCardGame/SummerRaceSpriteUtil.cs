using UnityEngine;

public static class SummerRaceSpriteUtil
{
	private static Sprite cachedSquare;

	private static Sprite cachedCircle;

	private static Texture2D cachedTexture;

	private static Texture2D cachedCircleTexture;

	private static Sprite cachedSoftOval;

	private static Texture2D cachedSoftOvalTexture;

	public static Sprite GetSquareSprite()
	{
		if (cachedSquare != null)
		{
			return cachedSquare;
		}
		if (cachedTexture == null)
		{
			cachedTexture = new Texture2D(16, 16, TextureFormat.RGBA32, mipChain: false);
			cachedTexture.name = "SummerRace_SquareTex";
			cachedTexture.wrapMode = TextureWrapMode.Clamp;
			cachedTexture.filterMode = FilterMode.Point;
			Color32[] array = new Color32[256];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			}
			cachedTexture.SetPixels32(array);
			cachedTexture.Apply(updateMipmaps: false, makeNoLongerReadable: true);
		}
		cachedSquare = Sprite.Create(cachedTexture, new Rect(0f, 0f, cachedTexture.width, cachedTexture.height), new Vector2(0.5f, 0.5f), 16f);
		cachedSquare.name = "SummerRace_Square";
		return cachedSquare;
	}

	public static Sprite GetCircleSprite()
	{
		if (cachedCircle != null)
		{
			return cachedCircle;
		}
		if (cachedCircleTexture == null)
		{
			cachedCircleTexture = new Texture2D(32, 32, TextureFormat.RGBA32, mipChain: false);
			cachedCircleTexture.name = "SummerRace_CircleTex";
			cachedCircleTexture.wrapMode = TextureWrapMode.Clamp;
			cachedCircleTexture.filterMode = FilterMode.Bilinear;
			Color32[] array = new Color32[1024];
			float num = 15.5f;
			Vector2 b = new Vector2(num, num);
			for (int i = 0; i < 32; i++)
			{
				for (int j = 0; j < 32; j++)
				{
					int num2 = i * 32 + j;
					float num3 = Vector2.Distance(new Vector2(j, i), b);
					array[num2] = ((num3 <= num) ? new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue) : new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 0));
				}
			}
			cachedCircleTexture.SetPixels32(array);
			cachedCircleTexture.Apply(updateMipmaps: false, makeNoLongerReadable: true);
		}
		cachedCircle = Sprite.Create(cachedCircleTexture, new Rect(0f, 0f, cachedCircleTexture.width, cachedCircleTexture.height), new Vector2(0.5f, 0.5f), cachedCircleTexture.width);
		cachedCircle.name = "SummerRace_Circle";
		return cachedCircle;
	}

	public static Sprite GetSoftOvalShadowSprite()
	{
		if (cachedSoftOval != null)
		{
			return cachedSoftOval;
		}
		if (cachedSoftOvalTexture == null)
		{
			cachedSoftOvalTexture = new Texture2D(128, 32, TextureFormat.RGBA32, mipChain: false);
			cachedSoftOvalTexture.name = "SummerRace_SoftOvalShadowTex";
			cachedSoftOvalTexture.wrapMode = TextureWrapMode.Clamp;
			cachedSoftOvalTexture.filterMode = FilterMode.Bilinear;
			Color32[] array = new Color32[4096];
			Vector2 vector = new Vector2(63.5f, 15.5f);
			float num = 1f / Mathf.Max(1f, vector.x);
			float num2 = 1f / Mathf.Max(1f, vector.y);
			for (int i = 0; i < 32; i++)
			{
				for (int j = 0; j < 128; j++)
				{
					float num3 = ((float)j - vector.x) * num;
					float num4 = ((float)i - vector.y) * num2;
					float value = Mathf.Sqrt(num3 * num3 + num4 * num4);
					byte a = (byte)Mathf.Clamp(Mathf.RoundToInt(Mathf.SmoothStep(1f, 0f, Mathf.InverseLerp(0.42f, 1f, value)) * 255f), 0, 255);
					array[i * 128 + j] = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, a);
				}
			}
			cachedSoftOvalTexture.SetPixels32(array);
			cachedSoftOvalTexture.Apply(updateMipmaps: false, makeNoLongerReadable: true);
		}
		cachedSoftOval = Sprite.Create(cachedSoftOvalTexture, new Rect(0f, 0f, cachedSoftOvalTexture.width, cachedSoftOvalTexture.height), new Vector2(0.5f, 0.5f), cachedSoftOvalTexture.width);
		cachedSoftOval.name = "SummerRace_SoftOvalShadow";
		return cachedSoftOval;
	}
}
