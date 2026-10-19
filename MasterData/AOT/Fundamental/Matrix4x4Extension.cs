using UnityEngine;

public static class Matrix4x4Extension
{
	public static Matrix4x4 GetPerspectiveProjection(float left, float right, float bottom, float top, float near, float far)
	{
		float value = 2f * near / (right - left);
		float value2 = 2f * near / (top - bottom);
		float value3 = (right + left) / (right - left);
		float value4 = (top + bottom) / (top - bottom);
		float value5 = (0f - (far + near)) / (far - near);
		float value6 = (0f - 2f * far * near) / (far - near);
		float value7 = -1f;
		return new Matrix4x4
		{
			[0, 0] = value,
			[0, 1] = 0f,
			[0, 2] = value3,
			[0, 3] = 0f,
			[1, 0] = 0f,
			[1, 1] = value2,
			[1, 2] = value4,
			[1, 3] = 0f,
			[2, 0] = 0f,
			[2, 1] = 0f,
			[2, 2] = value5,
			[2, 3] = value6,
			[3, 0] = 0f,
			[3, 1] = 0f,
			[3, 2] = value7,
			[3, 3] = 0f
		};
	}

	public static Matrix4x4 GetOrthographicProjection(float left, float right, float bottom, float top, float near, float far)
	{
		float value = 2f / (right - left);
		float value2 = 2f / (top - bottom);
		float value3 = -2f / (far - near);
		float value4 = (0f - (right + left)) / (right - left);
		float value5 = (0f - (top + bottom)) / (top - bottom);
		float value6 = (0f - (far + near)) / (far - near);
		float value7 = 1f;
		return new Matrix4x4
		{
			[0, 0] = value,
			[0, 1] = 0f,
			[0, 2] = 0f,
			[0, 3] = value4,
			[1, 0] = 0f,
			[1, 1] = value2,
			[1, 2] = 0f,
			[1, 3] = value5,
			[2, 0] = 0f,
			[2, 1] = 0f,
			[2, 2] = value3,
			[2, 3] = value6,
			[3, 0] = 0f,
			[3, 1] = 0f,
			[3, 2] = 0f,
			[3, 3] = value7
		};
	}
}
