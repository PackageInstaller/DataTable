using UnityEngine;

namespace Cinemachine.Utility;

public static class SplineHelpers
{
	public static Vector3 Bezier3(float t, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3)
	{
		t = Mathf.Clamp01(t);
		float num = 1f - t;
		return num * num * num * p0 + 3f * num * num * t * p1 + 3f * num * t * t * p2 + t * t * t * p3;
	}

	public static Vector3 BezierTangent3(float t, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3)
	{
		t = Mathf.Clamp01(t);
		return (-3f * p0 + 9f * p1 - 9f * p2 + 3f * p3) * (t * t) + (6f * p0 - 12f * p1 + 6f * p2) * t - 3f * p0 + 3f * p1;
	}

	public static void BezierTangentWeights3(Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, out Vector3 w0, out Vector3 w1, out Vector3 w2)
	{
		w0 = -3f * p0 + 9f * p1 - 9f * p2 + 3f * p3;
		w1 = 6f * p0 - 12f * p1 + 6f * p2;
		w2 = -3f * p0 + 3f * p1;
	}

	public static float Bezier1(float t, float p0, float p1, float p2, float p3)
	{
		t = Mathf.Clamp01(t);
		float num = 1f - t;
		return num * num * num * p0 + 3f * num * num * t * p1 + 3f * num * t * t * p2 + t * t * t * p3;
	}

	public static float BezierTangent1(float t, float p0, float p1, float p2, float p3)
	{
		t = Mathf.Clamp01(t);
		return (-3f * p0 + 9f * p1 - 9f * p2 + 3f * p3) * t * t + (6f * p0 - 12f * p1 + 6f * p2) * t - 3f * p0 + 3f * p1;
	}

	public static void ComputeSmoothControlPoints(ref Vector4[] knot, ref Vector4[] ctrl1, ref Vector4[] ctrl2)
	{
		int num = knot.Length;
		if (num <= 2)
		{
			switch (num)
			{
			case 2:
				ctrl1[0] = Vector4.Lerp(knot[0], knot[1], 0.33333f);
				ctrl2[0] = Vector4.Lerp(knot[0], knot[1], 0.66666f);
				break;
			case 1:
				ctrl1[0] = (ctrl2[0] = knot[0]);
				break;
			}
			return;
		}
		float[] array = new float[num];
		float[] array2 = new float[num];
		float[] array3 = new float[num];
		float[] array4 = new float[num];
		for (int i = 0; i < 4; i++)
		{
			int num2 = num - 1;
			array[0] = 0f;
			array2[0] = 2f;
			array3[0] = 1f;
			array4[0] = knot[0][i] + 2f * knot[1][i];
			for (int j = 1; j < num2 - 1; j++)
			{
				array[j] = 1f;
				array2[j] = 4f;
				array3[j] = 1f;
				array4[j] = 4f * knot[j][i] + 2f * knot[j + 1][i];
			}
			array[num2 - 1] = 2f;
			array2[num2 - 1] = 7f;
			array3[num2 - 1] = 0f;
			array4[num2 - 1] = 8f * knot[num2 - 1][i] + knot[num2][i];
			for (int k = 1; k < num2; k++)
			{
				float num3 = array[k] / array2[k - 1];
				array2[k] -= num3 * array3[k - 1];
				array4[k] -= num3 * array4[k - 1];
			}
			ctrl1[num2 - 1][i] = array4[num2 - 1] / array2[num2 - 1];
			for (int num4 = num2 - 2; num4 >= 0; num4--)
			{
				ctrl1[num4][i] = (array4[num4] - array3[num4] * ctrl1[num4 + 1][i]) / array2[num4];
			}
			for (int l = 0; l < num2; l++)
			{
				ctrl2[l][i] = 2f * knot[l + 1][i] - ctrl1[l + 1][i];
			}
			ctrl2[num2 - 1][i] = 0.5f * (knot[num2][i] + ctrl1[num2 - 1][i]);
		}
	}

	public static void ComputeSmoothControlPointsLooped(ref Vector4[] knot, ref Vector4[] ctrl1, ref Vector4[] ctrl2)
	{
		int num = knot.Length;
		if (num < 2)
		{
			if (num == 1)
			{
				ctrl1[0] = (ctrl2[0] = knot[0]);
			}
			return;
		}
		int num2 = Mathf.Min(4, num - 1);
		Vector4[] knot2 = new Vector4[num + 2 * num2];
		Vector4[] ctrl3 = new Vector4[num + 2 * num2];
		Vector4[] ctrl4 = new Vector4[num + 2 * num2];
		for (int i = 0; i < num2; i++)
		{
			knot2[i] = knot[num - (num2 - i)];
			knot2[num + num2 + i] = knot[i];
		}
		for (int j = 0; j < num; j++)
		{
			knot2[j + num2] = knot[j];
		}
		ComputeSmoothControlPoints(ref knot2, ref ctrl3, ref ctrl4);
		for (int k = 0; k < num; k++)
		{
			ctrl1[k] = ctrl3[k + num2];
			ctrl2[k] = ctrl4[k + num2];
		}
	}
}
