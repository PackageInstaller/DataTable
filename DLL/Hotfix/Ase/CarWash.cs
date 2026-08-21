using UnityEngine;

namespace Ase;

[RequireComponent(typeof(MeshCollider))]
public class CarWash : MonoBehaviour
{
	public Texture2D MaskTex;

	public Vector2 pixelUV;

	public float brushSize = 200f;

	public float brushStronger = 0.2f;

	public Color colorCover = new Color(0.13f, 0.13f, 0.2f, 1f);

	public float halfAlphaDec = 0.4f;

	private bool isAllOpen;

	private void Update()
	{
		if (!MaskTex)
		{
			Texture2D texture2D = new Texture2D(1024, 1024, TextureFormat.RGBA32, 1, linear: false);
			Color[] array = new Color[1024 * 1024];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = colorCover;
			}
			texture2D.SetPixels(array);
			MaskTex = texture2D;
		}
		if (isAllOpen)
		{
			return;
		}
		int num = (int)Mathf.Round(brushSize);
		int num2 = Mathf.FloorToInt(pixelUV.x * (float)MaskTex.width);
		int num3 = Mathf.FloorToInt(pixelUV.y * (float)MaskTex.height);
		int num4 = Mathf.Clamp(num2 - num / 2, 0, MaskTex.width - 1);
		int num5 = Mathf.Clamp(num3 - num / 2, 0, MaskTex.height - 1);
		int num6 = Mathf.Clamp(num2 + num / 2, 0, MaskTex.width) - num4;
		int num7 = Mathf.Clamp(num3 + num / 2, 0, MaskTex.height) - num5;
		float[] array2 = new float[num * num];
		int num8 = Mathf.FloorToInt(num / 2);
		int num9 = num8 * num8;
		for (int j = 0; j < num; j++)
		{
			int num10 = j - num8;
			for (int k = 0; k < num; k++)
			{
				int num11 = k - num8;
				int num12 = num10 * num10 + num11 * num11;
				if (num12 > num9)
				{
					array2[k * num + j] = 0f;
				}
				else
				{
					array2[k * num + j] = 1f - (float)num12 / (float)num9;
				}
			}
		}
		Color[] pixels = MaskTex.GetPixels(num4, num5, num6, num7, 0);
		for (int l = 0; l < num7; l++)
		{
			for (int m = 0; m < num6; m++)
			{
				int num13 = l * num6 + m;
				float t = array2[Mathf.Clamp(num5 + l - (num3 - num / 2), 0, num - 1) * num + Mathf.Clamp(num4 + m - (num2 - num / 2), 0, num - 1)] * brushStronger;
				pixels[num13] = Color.Lerp(pixels[num13], Color.clear, t);
			}
		}
		MaskTex.SetPixels(num4, num5, num6, num7, pixels, 0);
		MaskTex.Apply();
	}

	public float GetPixelAlpha(Vector2 pixelUV)
	{
		int x = Mathf.FloorToInt(pixelUV.x * (float)MaskTex.width);
		int y = Mathf.FloorToInt(pixelUV.y * (float)MaskTex.height);
		return MaskTex.GetPixel(x, y).a;
	}

	public void Reset()
	{
		if (!(MaskTex == null))
		{
			Color[] array = new Color[MaskTex.width * MaskTex.height];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = colorCover;
			}
			MaskTex.SetPixels(array);
			MaskTex.Apply();
			isAllOpen = false;
		}
	}

	public void SetHalf()
	{
		if (!(MaskTex == null))
		{
			Color[] pixels = MaskTex.GetPixels();
			for (int i = 0; i < pixels.Length; i++)
			{
				pixels[i].a = pixels[i].a - halfAlphaDec;
			}
			MaskTex.SetPixels(pixels);
			MaskTex.Apply();
			isAllOpen = false;
		}
	}

	public void SetNone()
	{
		if (!(MaskTex == null))
		{
			Color[] pixels = MaskTex.GetPixels();
			for (int i = 0; i < pixels.Length; i++)
			{
				pixels[i].a = 0f;
			}
			MaskTex.SetPixels(pixels);
			MaskTex.Apply();
			isAllOpen = true;
		}
	}

	public void SetMapContour(Sprite map, Vector2 uvRatio)
	{
		if (MaskTex == null)
		{
			return;
		}
		Color[] pixels = map.texture.GetPixels();
		int width = map.texture.width;
		int height = map.texture.height;
		int num = Mathf.Max(width, height);
		Color[] pixels2 = MaskTex.GetPixels();
		int width2 = MaskTex.width;
		int height2 = MaskTex.height;
		Color color = Color.white;
		for (int i = 0; i < pixels2.Length; i++)
		{
			int num2 = i / width2;
			int num3 = i - num2 * width2;
			int num4 = num2 * num / height2;
			int num5 = num3 * num / width2;
			if (num4 >= height || num5 >= width)
			{
				color.a = 0f;
			}
			else
			{
				int num6 = num4 * width + num5;
				color = pixels[num6];
			}
			color.r = pixels2[i].r;
			color.g = pixels2[i].g;
			color.b = pixels2[i].b;
			pixels2[i] = color;
		}
		MaskTex.SetPixels(pixels2);
		MaskTex.Apply();
	}

	protected void OnDestroy()
	{
		if (MaskTex != null)
		{
			Texture2D maskTex = MaskTex;
			MaskTex = null;
			Object.Destroy(maskTex);
		}
	}
}
