namespace UnityEngine.Rendering;

public static class CoreMatrixUtils
{
	public static Matrix4x4 MultiplyPerspectiveMatrix(Matrix4x4 perspective, Matrix4x4 rhs)
	{
		Matrix4x4 result = default;
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
		Matrix4x4 result = default;
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

	public static Matrix4x4 MultiplyProjectionMatrix(Matrix4x4 projMatrix, Matrix4x4 rhs, bool orthoCentered)
	{
		if (!orthoCentered)
		{
			return MultiplyPerspectiveMatrix(projMatrix, rhs);
		}
		return MultiplyOrthoMatrixCentered(projMatrix, rhs);
	}
}
