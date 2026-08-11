using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public class PrimitiveExtension
{
	public static Matrix4 symmetricMatrix = new Matrix4(1f, 0f, 0f, 0f, 0f, 1f, 0f, 0f, 0f, 0f, -1f, 0f);

	public static int[,] Lines = new int[12, 2]
	{
		{ 0, 1 },
		{ 0, 3 },
		{ 0, 4 },
		{ 1, 2 },
		{ 1, 5 },
		{ 2, 3 },
		{ 2, 6 },
		{ 3, 7 },
		{ 4, 5 },
		{ 4, 7 },
		{ 5, 6 },
		{ 6, 7 }
	};

	private static int[,] Mults = new int[8, 3]
	{
		{ 1, 1, 1 },
		{ -1, 1, 1 },
		{ -1, 1, -1 },
		{ 1, 1, -1 },
		{ 1, -1, 1 },
		{ -1, -1, 1 },
		{ -1, -1, -1 },
		{ 1, -1, -1 }
	};

	public static float BoxVMul(int i, int order, float halfsize)
	{
		return (float)Mults[i, order] * halfsize;
	}

	public static Vector3 VMul(Vector3 v1, Vector3 v2)
	{
		return new Vector3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z);
	}

	public static float Determinant(Vector3 v1, Vector3 v2)
	{
		return (float)((double)v1.y * (double)v2.z - (double)v1.z * (double)v2.y) + (float)((double)v1.z * (double)v2.x - (double)v1.x * (double)v2.z) + (float)((double)v1.x * (double)v2.y - (double)v1.y * (double)v2.x);
	}
}
