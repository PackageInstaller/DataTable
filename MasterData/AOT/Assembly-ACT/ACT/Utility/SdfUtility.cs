using System;
using UnityEngine;

namespace ACT.Utility;

public static class SdfUtility
{
	private const float DistanceInfinity = 1E+10f;

	private const int VectorInfinity = 32767;

	private const int OutputDownsampleFactor = 8;

	public static Texture2D GenerateSdf(Texture2D source, float spread, bool whiteIsInside = true, byte threshold = 128)
	{
		ValidateSource(source, spread);
		int width = source.width;
		int height = source.height;
		int num = width * height;
		Color32[] pixels = source.GetPixels32();
		float[] array = new float[num];
		float[] array2 = new float[num];
		float[] array3 = new float[num];
		float[] array4 = new float[num];
		float[] intermediate = new float[num];
		int num2 = Mathf.Max(width, height);
		float[] inputLine = new float[num2];
		float[] outputLine = new float[num2];
		int[] parabolaIndices = new int[num2];
		float[] intersections = new float[num2 + 1];
		for (int i = 0; i < num; i++)
		{
			bool flag = IsInsidePixel(pixels[i], whiteIsInside, threshold);
			array[i] = (flag ? 1E+10f : 0f);
			array2[i] = (flag ? 0f : 1E+10f);
		}
		DistanceTransform2D(array, array3, intermediate, width, height, inputLine, outputLine, parabolaIndices, intersections);
		DistanceTransform2D(array2, array4, intermediate, width, height, inputLine, outputLine, parabolaIndices, intersections);
		Color32[] array5 = new Color32[num];
		float normalization = 1f / (2f * spread);
		for (int j = 0; j < num; j++)
		{
			float signedDistance = Mathf.Sqrt(array3[j]) - Mathf.Sqrt(array4[j]);
			array5[j] = EncodeSdfSample(signedDistance, normalization);
		}
		return CreateSdfTexture(source, width, height, array5);
	}

	public static Texture2D GenerateSdf8Ssedt(Texture2D source, float spread, bool whiteIsInside = true, byte threshold = 128)
	{
		ValidateSource(source, spread);
		int width = source.width;
		int height = source.height;
		int num = width * height;
		Color32[] pixels = source.GetPixels32();
		Vector2Int[] array = new Vector2Int[num];
		Vector2Int[] array2 = new Vector2Int[num];
		for (int i = 0; i < num; i++)
		{
			bool flag = IsInsidePixel(pixels[i], whiteIsInside, threshold);
			array[i] = (flag ? new Vector2Int(32767, 32767) : Vector2Int.zero);
			array2[i] = (flag ? Vector2Int.zero : new Vector2Int(32767, 32767));
		}
		SequentialEuclideanDistanceTransform8(array, width, height);
		SequentialEuclideanDistanceTransform8(array2, width, height);
		Color32[] array3 = new Color32[num];
		float normalization = 1f / (2f * spread);
		for (int j = 0; j < num; j++)
		{
			float signedDistance = VectorLength(array[j]) - VectorLength(array2[j]);
			array3[j] = EncodeSdfSample(signedDistance, normalization);
		}
		return CreateSdfTexture(source, width, height, array3);
	}

	private static void ValidateSource(Texture2D source, float spread)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (!source.isReadable)
		{
			throw new ArgumentException("The source texture must have Read/Write enabled.", "source");
		}
		if (spread <= 0f)
		{
			throw new ArgumentOutOfRangeException("spread", "Spread must be greater than zero.");
		}
	}

	private static bool IsInsidePixel(Color32 pixel, bool whiteIsInside, byte threshold)
	{
		bool flag = pixel.r >= threshold;
		if (!whiteIsInside)
		{
			return !flag;
		}
		return flag;
	}

	private static Color32 EncodeSdfSample(float signedDistance, float normalization)
	{
		byte b = (byte)Mathf.RoundToInt(Mathf.Clamp01(0.5f + signedDistance * normalization) * 255f);
		byte b2 = b;
		return new Color32(b, b2, b2, byte.MaxValue);
	}

	private static Texture2D CreateSdfTexture(Texture2D source, int sourceWidth, int sourceHeight, Color32[] sourcePixels)
	{
		GetOutputDimensions(sourceWidth, sourceHeight, out var outputWidth, out var outputHeight);
		Color32[] pixels = DownsamplePixels(sourcePixels, sourceWidth, sourceHeight, outputWidth, outputHeight);
		Texture2D texture2D = new Texture2D(outputWidth, outputHeight, TextureFormat.RGBA32, mipChain: false, linear: true);
		texture2D.name = source.name + "_SDF";
		texture2D.filterMode = source.filterMode;
		texture2D.wrapMode = source.wrapMode;
		texture2D.SetPixels32(pixels);
		texture2D.Apply(updateMipmaps: false, makeNoLongerReadable: false);
		return texture2D;
	}

	private static void GetOutputDimensions(int sourceWidth, int sourceHeight, out int outputWidth, out int outputHeight)
	{
		outputWidth = Mathf.Max(1, Mathf.CeilToInt((float)sourceWidth / 8f));
		outputHeight = Mathf.Max(1, Mathf.RoundToInt((float)outputWidth * ((float)sourceHeight / (float)sourceWidth)));
		outputHeight = Mathf.Min(sourceHeight, outputHeight);
	}

	private static Color32[] DownsamplePixels(Color32[] sourcePixels, int sourceWidth, int sourceHeight, int outputWidth, int outputHeight)
	{
		Color32[] array = new Color32[outputWidth * outputHeight];
		for (int i = 0; i < outputHeight; i++)
		{
			int num = i * sourceHeight / outputHeight;
			int num2 = Mathf.Min(sourceHeight, Mathf.Max(num + 1, (i + 1) * sourceHeight / outputHeight));
			for (int j = 0; j < outputWidth; j++)
			{
				int num3 = j * sourceWidth / outputWidth;
				int num4 = Mathf.Min(sourceWidth, Mathf.Max(num3 + 1, (j + 1) * sourceWidth / outputWidth));
				int num5 = 0;
				int num6 = 0;
				for (int k = num; k < num2; k++)
				{
					int num7 = k * sourceWidth;
					for (int l = num3; l < num4; l++)
					{
						num5 += sourcePixels[num7 + l].r;
						num6++;
					}
				}
				byte b = (byte)((num6 != 0) ? ((byte)Mathf.RoundToInt((float)num5 / (float)num6)) : 0);
				array[i * outputWidth + j] = new Color32(b, b, b, byte.MaxValue);
			}
		}
		return array;
	}

	private static float VectorLength(Vector2Int vector)
	{
		if (Mathf.Abs(vector.x) >= 32767 || Mathf.Abs(vector.y) >= 32767)
		{
			return 1E+10f;
		}
		return Mathf.Sqrt((float)vector.x * (float)vector.x + (float)vector.y * (float)vector.y);
	}

	private static void SequentialEuclideanDistanceTransform8(Vector2Int[] vectors, int width, int height)
	{
		for (int i = 0; i < height; i++)
		{
			int num = i * width;
			for (int j = 0; j < width; j++)
			{
				int num2 = num + j;
				Vector2Int vector2Int = vectors[num2];
				if (j > 0)
				{
					vector2Int = MinVector(vector2Int, OffsetVector(vectors[num2 - 1], 1, 0));
				}
				if (i > 0)
				{
					int num3 = num2 - width;
					vector2Int = MinVector(vector2Int, OffsetVector(vectors[num3], 0, 1));
					if (j > 0)
					{
						vector2Int = MinVector(vector2Int, OffsetVector(vectors[num3 - 1], 1, 1));
					}
					if (j + 1 < width)
					{
						vector2Int = MinVector(vector2Int, OffsetVector(vectors[num3 + 1], -1, 1));
					}
				}
				vectors[num2] = vector2Int;
			}
		}
		for (int num4 = height - 1; num4 >= 0; num4--)
		{
			int num5 = num4 * width;
			for (int num6 = width - 1; num6 >= 0; num6--)
			{
				int num7 = num5 + num6;
				Vector2Int vector2Int2 = vectors[num7];
				if (num6 + 1 < width)
				{
					vector2Int2 = MinVector(vector2Int2, OffsetVector(vectors[num7 + 1], -1, 0));
				}
				if (num4 + 1 < height)
				{
					int num8 = num7 + width;
					vector2Int2 = MinVector(vector2Int2, OffsetVector(vectors[num8], 0, -1));
					if (num6 > 0)
					{
						vector2Int2 = MinVector(vector2Int2, OffsetVector(vectors[num8 - 1], 1, -1));
					}
					if (num6 + 1 < width)
					{
						vector2Int2 = MinVector(vector2Int2, OffsetVector(vectors[num8 + 1], -1, -1));
					}
				}
				vectors[num7] = vector2Int2;
			}
		}
	}

	private static Vector2Int OffsetVector(Vector2Int vector, int offsetX, int offsetY)
	{
		if (Mathf.Abs(vector.x) >= 32767 || Mathf.Abs(vector.y) >= 32767)
		{
			return new Vector2Int(32767, 32767);
		}
		int num = vector.x + offsetX;
		int num2 = vector.y + offsetY;
		if (Mathf.Abs(num) >= 32767 || Mathf.Abs(num2) >= 32767)
		{
			return new Vector2Int(32767, 32767);
		}
		return new Vector2Int(num, num2);
	}

	private static Vector2Int MinVector(Vector2Int a, Vector2Int b)
	{
		if (VectorLengthSq(a) > VectorLengthSq(b))
		{
			return b;
		}
		return a;
	}

	private static long VectorLengthSq(Vector2Int vector)
	{
		if (Mathf.Abs(vector.x) >= 32767 || Mathf.Abs(vector.y) >= 32767)
		{
			return 2305843009213693951L;
		}
		long num = vector.x;
		long num2 = vector.y;
		return num * num + num2 * num2;
	}

	private static void DistanceTransform2D(float[] seed, float[] distance, float[] intermediate, int width, int height, float[] inputLine, float[] outputLine, int[] parabolaIndices, float[] intersections)
	{
		for (int i = 0; i < width; i++)
		{
			for (int j = 0; j < height; j++)
			{
				inputLine[j] = seed[j * width + i];
			}
			DistanceTransform1D(inputLine, outputLine, height, parabolaIndices, intersections);
			for (int k = 0; k < height; k++)
			{
				intermediate[k * width + i] = outputLine[k];
			}
		}
		for (int l = 0; l < height; l++)
		{
			int num = l * width;
			for (int m = 0; m < width; m++)
			{
				inputLine[m] = intermediate[num + m];
			}
			DistanceTransform1D(inputLine, outputLine, width, parabolaIndices, intersections);
			for (int n = 0; n < width; n++)
			{
				distance[num + n] = outputLine[n];
			}
		}
	}

	private static void DistanceTransform1D(float[] input, float[] output, int length, int[] parabolaIndices, float[] intersections)
	{
		bool flag = false;
		for (int i = 0; i < length; i++)
		{
			if (input[i] < 1E+10f)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			for (int j = 0; j < length; j++)
			{
				output[j] = 1E+10f;
			}
			return;
		}
		int num = 0;
		parabolaIndices[0] = 0;
		intersections[0] = float.NegativeInfinity;
		intersections[1] = float.PositiveInfinity;
		for (int k = 1; k < length; k++)
		{
			int num2 = parabolaIndices[num];
			float num3;
			for (num3 = (input[k] + (float)(k * k) - (input[num2] + (float)(num2 * num2))) / (2f * (float)(k - num2)); num3 <= intersections[num]; num3 = (input[k] + (float)(k * k) - (input[num2] + (float)(num2 * num2))) / (2f * (float)(k - num2)))
			{
				num--;
				num2 = parabolaIndices[num];
			}
			num++;
			parabolaIndices[num] = k;
			intersections[num] = num3;
			intersections[num + 1] = float.PositiveInfinity;
		}
		int l = 0;
		for (int m = 0; m < length; m++)
		{
			for (; intersections[l + 1] < (float)m; l++)
			{
			}
			float num4 = m - parabolaIndices[l];
			output[m] = num4 * num4 + input[parabolaIndices[l]];
		}
	}
}
