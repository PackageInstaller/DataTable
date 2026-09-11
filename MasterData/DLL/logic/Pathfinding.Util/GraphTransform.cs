using UnityEngine;

namespace Pathfinding.Util;

public class GraphTransform : IMovementPlane, ITransform
{
	public readonly bool identity;

	public readonly bool onlyTranslational;

	private readonly bool isXY;

	private readonly bool isXZ;

	private readonly Matrix4x4 matrix;

	private readonly Matrix4x4 inverseMatrix;

	private readonly Vector3 up;

	private readonly Vector3 translation;

	private readonly Int3 i3translation;

	private readonly Quaternion rotation;

	private readonly Quaternion inverseRotation;

	public static readonly GraphTransform identityTransform;

	public GraphTransform(Matrix4x4 matrix)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		this.matrix = matrix;
		inverseMatrix = ((Matrix4x4)(ref matrix)).inverse;
		identity = ((Matrix4x4)(ref matrix)).isIdentity;
		onlyTranslational = MatrixIsTranslational(matrix);
		Vector3 val = ((Matrix4x4)(ref matrix)).MultiplyVector(Vector3.up);
		up = ((Vector3)(ref val)).normalized;
		translation = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.zero);
		i3translation = (Int3)translation;
		rotation = Quaternion.LookRotation(TransformVector(Vector3.forward), TransformVector(Vector3.up));
		inverseRotation = Quaternion.Inverse(rotation);
		isXY = rotation == Quaternion.Euler(-90f, 0f, 0f);
		isXZ = rotation == Quaternion.Euler(0f, 0f, 0f);
	}

	public Vector3 WorldUpAtGraphPosition(Vector3 p)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return up;
	}

	private static bool MatrixIsTranslational(Matrix4x4 m)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		if (((Matrix4x4)(ref m)).GetColumn(0) == new Vector4(1f, 0f, 0f, 0f) && ((Matrix4x4)(ref m)).GetColumn(1) == new Vector4(0f, 1f, 0f, 0f) && ((Matrix4x4)(ref m)).GetColumn(2) == new Vector4(0f, 0f, 1f, 0f))
		{
			return m.m33 == 1f;
		}
		return false;
	}

	public Vector3 Transform(Vector3 p)
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p + translation;
		}
		Matrix4x4 val = matrix;
		return ((Matrix4x4)(ref val)).MultiplyPoint3x4(p);
	}

	public Int3 Transform(Int3 p)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p + (Int3)translation;
		}
		Matrix4x4 val = matrix;
		return (Int3)((Matrix4x4)(ref val)).MultiplyPoint3x4((Vector3)p);
	}

	public Vector3 TransformVector(Vector3 p)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p;
		}
		Matrix4x4 val = matrix;
		return ((Matrix4x4)(ref val)).MultiplyVector(p);
	}

	public Int3 TransformVector(Int3 p)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p;
		}
		Matrix4x4 val = matrix;
		return (Int3)((Matrix4x4)(ref val)).MultiplyVector((Vector3)p);
	}

	public void Transform(Int3[] arr)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			for (int num = arr.Length - 1; num >= 0; num--)
			{
				arr[num] += i3translation;
			}
			return;
		}
		for (int num2 = arr.Length - 1; num2 >= 0; num2--)
		{
			int num3 = num2;
			Matrix4x4 val = matrix;
			arr[num3] = (Int3)((Matrix4x4)(ref val)).MultiplyPoint3x4((Vector3)arr[num2]);
		}
	}

	public void Transform(Vector3[] arr)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			for (int num = arr.Length - 1; num >= 0; num--)
			{
				ref Vector3 reference = ref arr[num];
				reference += translation;
			}
			return;
		}
		for (int num2 = arr.Length - 1; num2 >= 0; num2--)
		{
			int num3 = num2;
			Matrix4x4 val = matrix;
			arr[num3] = ((Matrix4x4)(ref val)).MultiplyPoint3x4(arr[num2]);
		}
	}

	public Vector3 InverseTransform(Vector3 p)
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p - translation;
		}
		Matrix4x4 val = inverseMatrix;
		return ((Matrix4x4)(ref val)).MultiplyPoint3x4(p);
	}

	public Int3 InverseTransform(Int3 p)
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p - i3translation;
		}
		Matrix4x4 val = inverseMatrix;
		return (Int3)((Matrix4x4)(ref val)).MultiplyPoint3x4((Vector3)p);
	}

	public void InverseTransform(Int3[] arr)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		for (int num = arr.Length - 1; num >= 0; num--)
		{
			int num2 = num;
			Matrix4x4 val = inverseMatrix;
			arr[num2] = (Int3)((Matrix4x4)(ref val)).MultiplyPoint3x4((Vector3)arr[num]);
		}
	}

	public static GraphTransform operator *(GraphTransform lhs, Matrix4x4 rhs)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return new GraphTransform(lhs.matrix * rhs);
	}

	public static GraphTransform operator *(Matrix4x4 lhs, GraphTransform rhs)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return new GraphTransform(lhs * rhs.matrix);
	}

	public Bounds Transform(Bounds b)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00df: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_0117: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0121: Unknown result type (might be due to invalid IL or missing references)
		//IL_0126: Unknown result type (might be due to invalid IL or missing references)
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		//IL_013c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0149: Unknown result type (might be due to invalid IL or missing references)
		//IL_014e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0180: Unknown result type (might be due to invalid IL or missing references)
		//IL_0185: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0194: Unknown result type (might be due to invalid IL or missing references)
		//IL_0199: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01db: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0208: Unknown result type (might be due to invalid IL or missing references)
		//IL_0209: Unknown result type (might be due to invalid IL or missing references)
		//IL_020a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0214: Unknown result type (might be due to invalid IL or missing references)
		//IL_0219: Unknown result type (might be due to invalid IL or missing references)
		//IL_021a: Unknown result type (might be due to invalid IL or missing references)
		//IL_021b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0220: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return new Bounds(((Bounds)(ref b)).center + translation, ((Bounds)(ref b)).size);
		}
		Vector3[] array = ArrayPool<Vector3>.Claim(8);
		Vector3 extents = ((Bounds)(ref b)).extents;
		array[0] = Transform(((Bounds)(ref b)).center + new Vector3(extents.x, extents.y, extents.z));
		array[1] = Transform(((Bounds)(ref b)).center + new Vector3(extents.x, extents.y, 0f - extents.z));
		array[2] = Transform(((Bounds)(ref b)).center + new Vector3(extents.x, 0f - extents.y, extents.z));
		array[3] = Transform(((Bounds)(ref b)).center + new Vector3(extents.x, 0f - extents.y, 0f - extents.z));
		array[4] = Transform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, extents.y, extents.z));
		array[5] = Transform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, extents.y, 0f - extents.z));
		array[6] = Transform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, 0f - extents.y, extents.z));
		array[7] = Transform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, 0f - extents.y, 0f - extents.z));
		Vector3 val = array[0];
		Vector3 val2 = array[0];
		for (int i = 1; i < 8; i++)
		{
			val = Vector3.Min(val, array[i]);
			val2 = Vector3.Max(val2, array[i]);
		}
		ArrayPool<Vector3>.Release(ref array);
		return new Bounds((val + val2) * 0.5f, val2 - val);
	}

	public Bounds InverseTransform(Bounds b)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00df: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_0117: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0121: Unknown result type (might be due to invalid IL or missing references)
		//IL_0126: Unknown result type (might be due to invalid IL or missing references)
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		//IL_013c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0149: Unknown result type (might be due to invalid IL or missing references)
		//IL_014e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0167: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0180: Unknown result type (might be due to invalid IL or missing references)
		//IL_0185: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0194: Unknown result type (might be due to invalid IL or missing references)
		//IL_0199: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01db: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0208: Unknown result type (might be due to invalid IL or missing references)
		//IL_0209: Unknown result type (might be due to invalid IL or missing references)
		//IL_020a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0214: Unknown result type (might be due to invalid IL or missing references)
		//IL_0219: Unknown result type (might be due to invalid IL or missing references)
		//IL_021a: Unknown result type (might be due to invalid IL or missing references)
		//IL_021b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0220: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return new Bounds(((Bounds)(ref b)).center - translation, ((Bounds)(ref b)).size);
		}
		Vector3[] array = ArrayPool<Vector3>.Claim(8);
		Vector3 extents = ((Bounds)(ref b)).extents;
		array[0] = InverseTransform(((Bounds)(ref b)).center + new Vector3(extents.x, extents.y, extents.z));
		array[1] = InverseTransform(((Bounds)(ref b)).center + new Vector3(extents.x, extents.y, 0f - extents.z));
		array[2] = InverseTransform(((Bounds)(ref b)).center + new Vector3(extents.x, 0f - extents.y, extents.z));
		array[3] = InverseTransform(((Bounds)(ref b)).center + new Vector3(extents.x, 0f - extents.y, 0f - extents.z));
		array[4] = InverseTransform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, extents.y, extents.z));
		array[5] = InverseTransform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, extents.y, 0f - extents.z));
		array[6] = InverseTransform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, 0f - extents.y, extents.z));
		array[7] = InverseTransform(((Bounds)(ref b)).center + new Vector3(0f - extents.x, 0f - extents.y, 0f - extents.z));
		Vector3 val = array[0];
		Vector3 val2 = array[0];
		for (int i = 1; i < 8; i++)
		{
			val = Vector3.Min(val, array[i]);
			val2 = Vector3.Max(val2, array[i]);
		}
		ArrayPool<Vector3>.Release(ref array);
		return new Bounds((val + val2) * 0.5f, val2 - val);
	}

	Vector2 IMovementPlane.ToPlane(Vector3 p)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		if (isXY)
		{
			return new Vector2(p.x, p.y);
		}
		if (!isXZ)
		{
			p = inverseRotation * p;
		}
		return new Vector2(p.x, p.z);
	}

	Int2 IMovementPlane.ToPlane(Int3 p)
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		if (isXY)
		{
			return new Int2(p.x, p.y);
		}
		if (!isXZ)
		{
			p = (Int3)(inverseRotation * (Vector3)p);
		}
		return new Int2(p.x, p.z);
	}

	Vector2 IMovementPlane.ToPlane(Vector3 p, out float elevation)
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		if (!isXZ)
		{
			p = inverseRotation * p;
		}
		elevation = p.y;
		return new Vector2(p.x, p.z);
	}

	Vector3 IMovementPlane.ToWorld(Vector2 p, float elevation)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		return rotation * new Vector3(p.x, elevation, p.y);
	}

	public Int2 ToPlane(Int3 p, out Int elevation)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		if (!isXZ)
		{
			p = (Int3)(inverseRotation * (Vector3)p);
		}
		elevation = p.y;
		return new Int2(p.x, p.z);
	}

	static GraphTransform()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		identityTransform = new GraphTransform(Matrix4x4.identity);
	}
}
