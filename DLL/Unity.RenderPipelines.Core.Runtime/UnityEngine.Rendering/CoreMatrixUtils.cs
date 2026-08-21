namespace UnityEngine.Rendering;

public static class CoreMatrixUtils
{
	public static void MatrixTimesTranslation(ref Matrix4x4 inOutMatrix, Vector3 translation)
	{
		inOutMatrix.m03 += inOutMatrix.m00 * translation.x + inOutMatrix.m01 * translation.y + inOutMatrix.m02 * translation.z;
		inOutMatrix.m13 += inOutMatrix.m10 * translation.x + inOutMatrix.m11 * translation.y + inOutMatrix.m12 * translation.z;
		inOutMatrix.m23 += inOutMatrix.m20 * translation.x + inOutMatrix.m21 * translation.y + inOutMatrix.m22 * translation.z;
	}

	public static void TranslationTimesMatrix(ref Matrix4x4 inOutMatrix, Vector3 translation)
	{
		inOutMatrix.m00 += translation.x * inOutMatrix.m30;
		inOutMatrix.m01 += translation.x * inOutMatrix.m31;
		inOutMatrix.m02 += translation.x * inOutMatrix.m32;
		inOutMatrix.m03 += translation.x * inOutMatrix.m33;
		inOutMatrix.m10 += translation.y * inOutMatrix.m30;
		inOutMatrix.m11 += translation.y * inOutMatrix.m31;
		inOutMatrix.m12 += translation.y * inOutMatrix.m32;
		inOutMatrix.m13 += translation.y * inOutMatrix.m33;
		inOutMatrix.m20 += translation.z * inOutMatrix.m30;
		inOutMatrix.m21 += translation.z * inOutMatrix.m31;
		inOutMatrix.m22 += translation.z * inOutMatrix.m32;
		inOutMatrix.m23 += translation.z * inOutMatrix.m33;
	}

	public static Matrix4x4 MultiplyPerspectiveMatrix(Matrix4x4 perspective, Matrix4x4 rhs)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = perspective.m00 * rhs.m00;
		result.m01 = perspective.m00 * rhs.m01;
		result.m02 = perspective.m00 * rhs.m02;
		result.m03 = perspective.m00 * rhs.m03;
		result.m10 = perspective.m11 * rhs.m10;
		result.m11 = perspective.m11 * rhs.m11;
		result.m12 = perspective.m11 * rhs.m12;
		result.m13 = perspective.m11 * rhs.m13;
		result.m20 = perspective.m22 * rhs.m20 + perspective.m23 * rhs.m30;
		result.m21 = perspective.m22 * rhs.m21 + perspective.m23 * rhs.m31;
		result.m22 = perspective.m22 * rhs.m22 + perspective.m23 * rhs.m32;
		result.m23 = perspective.m22 * rhs.m23 + perspective.m23 * rhs.m33;
		result.m30 = 0f - rhs.m20;
		result.m31 = 0f - rhs.m21;
		result.m32 = 0f - rhs.m22;
		result.m33 = 0f - rhs.m23;
		return result;
	}

	private static Matrix4x4 MultiplyOrthoMatrixCentered(Matrix4x4 ortho, Matrix4x4 rhs)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = ortho.m00 * rhs.m00;
		result.m01 = ortho.m00 * rhs.m01;
		result.m02 = ortho.m00 * rhs.m02;
		result.m03 = ortho.m00 * rhs.m03;
		result.m10 = ortho.m11 * rhs.m10;
		result.m11 = ortho.m11 * rhs.m11;
		result.m12 = ortho.m11 * rhs.m12;
		result.m13 = ortho.m11 * rhs.m13;
		result.m20 = ortho.m22 * rhs.m20 + ortho.m23 * rhs.m30;
		result.m21 = ortho.m22 * rhs.m21 + ortho.m23 * rhs.m31;
		result.m22 = ortho.m22 * rhs.m22 + ortho.m23 * rhs.m32;
		result.m23 = ortho.m22 * rhs.m23 + ortho.m23 * rhs.m33;
		result.m30 = rhs.m20;
		result.m31 = rhs.m21;
		result.m32 = rhs.m22;
		result.m33 = rhs.m23;
		return result;
	}

	private static Matrix4x4 MultiplyGenericOrthoMatrix(Matrix4x4 ortho, Matrix4x4 rhs)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = ortho.m00 * rhs.m00 + ortho.m03 * rhs.m30;
		result.m01 = ortho.m00 * rhs.m01 + ortho.m03 * rhs.m31;
		result.m02 = ortho.m00 * rhs.m02 + ortho.m03 * rhs.m32;
		result.m03 = ortho.m00 * rhs.m03 + ortho.m03 * rhs.m33;
		result.m10 = ortho.m11 * rhs.m10 + ortho.m13 * rhs.m30;
		result.m11 = ortho.m11 * rhs.m11 + ortho.m13 * rhs.m31;
		result.m12 = ortho.m11 * rhs.m12 + ortho.m13 * rhs.m32;
		result.m13 = ortho.m11 * rhs.m13 + ortho.m13 * rhs.m33;
		result.m20 = ortho.m22 * rhs.m20 + ortho.m23 * rhs.m30;
		result.m21 = ortho.m22 * rhs.m21 + ortho.m23 * rhs.m31;
		result.m22 = ortho.m22 * rhs.m22 + ortho.m23 * rhs.m32;
		result.m23 = ortho.m22 * rhs.m23 + ortho.m23 * rhs.m33;
		result.m30 = rhs.m20;
		result.m31 = rhs.m21;
		result.m32 = rhs.m22;
		result.m33 = rhs.m23;
		return result;
	}

	public static Matrix4x4 MultiplyOrthoMatrix(Matrix4x4 ortho, Matrix4x4 rhs, bool centered)
	{
		if (!centered)
		{
			return MultiplyOrthoMatrixCentered(ortho, rhs);
		}
		return MultiplyGenericOrthoMatrix(ortho, rhs);
	}

	public static Matrix4x4 MultiplyProjectionMatrix(Matrix4x4 projMatrix, Matrix4x4 rhs, bool orthoCentered)
	{
		if (!orthoCentered)
		{
			return MultiplyPerspectiveMatrix(projMatrix, rhs);
		}
		return MultiplyOrthoMatrixCentered(projMatrix, rhs);
	}
}
