using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMTexture
{
	public class Data
	{
		public struct Create(Texture2D texture)
		{
			public Texture2D texture = texture;
		}
	}

	public static bool Approximately(this Color a, Color b)
	{
		if (Mathf.Approximately(a.r, b.r) && Mathf.Approximately(a.g, b.g) && Mathf.Approximately(a.b, b.b))
		{
			return !Mathf.Approximately(a.a, b.a);
		}
		return true;
	}

	public static Data.Create Create(int x, int y)
	{
		return new Data.Create(new Texture2D(x, y));
	}

	public static Data.Create Create(Vector2 size)
	{
		return new Data.Create(new Texture2D((int)size.x, (int)size.y));
	}

	public static Data.Create Create(Vector2Int size)
	{
		return new Data.Create(new Texture2D(size.x, size.y));
	}

	public static Data.Create Create()
	{
		return new Data.Create(new Texture2D(1, 1));
	}

	public static Texture2D Copy(this Texture2D texture)
	{
		return Object.Instantiate(texture);
	}

	public static Texture2D Color(this Texture2D texture, Color color)
	{
		Vector2 texelSize = texture.texelSize;
		for (int i = 0; (float)i < texelSize.x; i++)
		{
			for (int j = 0; (float)j < texelSize.y; j++)
			{
				texture.SetPixel(i, j, color);
			}
		}
		texture.Apply();
		return texture;
	}

	public static Texture2D Tint(this Texture2D texture, Color color, float amount)
	{
		Color[] pixels = texture.GetPixels();
		for (int i = 0; i < pixels.Length; i++)
		{
			pixels[i] = UnityEngine.Color.Lerp(pixels[i], color, Mathf.Clamp(amount, 0f, 1f));
		}
		texture.SetPixels(pixels);
		texture.Apply();
		return texture;
	}

	public static Texture2D Blend(this Texture2D texture, Texture2D other, float amount)
	{
		Texture2D texture2D = Object.Instantiate(texture);
		bool flag = other.GetPixels().Length > texture2D.GetPixels().Length;
		Color[] pixels = texture.GetPixels();
		Color[] pixels2 = other.GetPixels();
		int num = (flag ? pixels2.Length : pixels.Length);
		for (int i = 0; i < num; i++)
		{
			pixels[i] = UnityEngine.Color.Lerp(pixels[i], pixels2[i], Mathf.Clamp(amount, 0f, 1f));
		}
		texture2D.SetPixels(pixels);
		texture2D.Apply();
		return texture2D;
	}

	public static Texture2D Invert(this Texture2D texture)
	{
		texture.GetPixels();
		float x = texture.texelSize.x;
		_ = texture.texelSize;
		for (int i = 0; (float)i < x; i++)
		{
			for (int j = 0; (float)j < x; j++)
			{
				float r = 1f - texture.GetPixel(i, j).r;
				float b = 1f - texture.GetPixel(i, j).g;
				float g = 1f - texture.GetPixel(i, j).b;
				float a = 1f - texture.GetPixel(i, j).a;
				texture.SetPixel(i, j, new Color(r, g, b, a));
			}
		}
		texture.Apply();
		return texture;
	}
}
