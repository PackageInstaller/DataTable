using Entitas;
using UnityEngine;

public class SimTransform : IComponent
{
	public Int3 position;

	public Int3 forward = new Int3(0, 0, 1);

	public Quaternion rotation;

	public Quaternion inverseRotation;

	public Quaternion localRotation;

	public Int3 localScale;

	private Matrix4x4 matrix;

	public Matrix4x4 inverseMatrix;

	public bool identity;

	private Vector3 up;

	private Vector3 translation;

	private bool isXY;

	private bool isXZ;

	public bool onlyTranslational;

	public Int speed;

	public Matrix4x4 Matrix
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return matrix;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_0030: Unknown result type (might be due to invalid IL or missing references)
			//IL_0035: Unknown result type (might be due to invalid IL or missing references)
			//IL_003a: Unknown result type (might be due to invalid IL or missing references)
			//IL_003d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0042: Unknown result type (might be due to invalid IL or missing references)
			//IL_004e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0053: Unknown result type (might be due to invalid IL or missing references)
			//IL_0058: Unknown result type (might be due to invalid IL or missing references)
			//IL_005f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0070: Unknown result type (might be due to invalid IL or missing references)
			//IL_0081: Unknown result type (might be due to invalid IL or missing references)
			//IL_0086: Unknown result type (might be due to invalid IL or missing references)
			//IL_008c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0091: Unknown result type (might be due to invalid IL or missing references)
			//IL_0096: Unknown result type (might be due to invalid IL or missing references)
			//IL_009b: Unknown result type (might be due to invalid IL or missing references)
			//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
			//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
			//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
			//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
			matrix = value;
			inverseMatrix = ((Matrix4x4)(ref matrix)).inverse;
			identity = ((Matrix4x4)(ref matrix)).isIdentity;
			Vector3 val = ((Matrix4x4)(ref matrix)).MultiplyVector(Vector3.up);
			up = ((Vector3)(ref val)).normalized;
			translation = ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(Vector3.zero);
			position = (Int3)translation;
			onlyTranslational = MatrixIsTranslational(matrix);
			rotation = Quaternion.LookRotation(TransformVector(Vector3.forward), TransformVector(Vector3.up));
			inverseRotation = Quaternion.Inverse(rotation);
			isXY = rotation == Quaternion.Euler(-90f, 0f, 0f);
			isXZ = rotation == Quaternion.Euler(0f, 0f, 0f);
		}
	}

	public Vector3 TransformVector(Vector3 p)
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p;
		}
		return ((Matrix4x4)(ref matrix)).MultiplyVector(p);
	}

	public Vector3 TransformPoint(Vector3 p)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (onlyTranslational)
		{
			return p + translation;
		}
		return ((Matrix4x4)(ref matrix)).MultiplyPoint3x4(p);
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
}
