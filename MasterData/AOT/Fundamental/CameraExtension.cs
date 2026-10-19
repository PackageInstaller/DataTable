using System;
using UnityEngine;

public static class CameraExtension
{
	public static Vector4 GetProjectionExtents(this Camera camera)
	{
		return camera.GetProjectionExtents(0f, 0f);
	}

	public static Vector4 GetProjectionExtents(this Camera camera, float texelOffsetX, float texelOffsetY)
	{
		if (camera == null)
		{
			return Vector4.zero;
		}
		float num = (camera.orthographic ? camera.orthographicSize : Mathf.Tan(MathF.PI / 360f * camera.fieldOfView));
		float num2 = num * camera.aspect;
		float num3 = num2 / (0.5f * (float)camera.pixelWidth);
		float num4 = num / (0.5f * (float)camera.pixelHeight);
		float z = num3 * texelOffsetX;
		float w = num4 * texelOffsetY;
		return new Vector4(num2, num, z, w);
	}

	public static Vector4 GetProjectionExtents(this Camera camera, Camera.StereoscopicEye eye)
	{
		return camera.GetProjectionExtents(eye, 0f, 0f);
	}

	public static Vector4 GetProjectionExtents(this Camera camera, Camera.StereoscopicEye eye, float texelOffsetX, float texelOffsetY)
	{
		Matrix4x4 matrix4x = Matrix4x4.Inverse(camera.GetStereoProjectionMatrix(eye));
		Vector3 vector = matrix4x.MultiplyPoint3x4(new Vector3(-1f, -1f, 0.95f));
		Vector3 vector2 = matrix4x.MultiplyPoint3x4(new Vector3(1f, 1f, 0.95f));
		vector /= 0f - vector.z;
		vector2 /= 0f - vector2.z;
		float num = 0.5f * (vector2.x - vector.x);
		float num2 = 0.5f * (vector2.y - vector.y);
		float num3 = num / (0.5f * (float)camera.pixelWidth);
		float num4 = num2 / (0.5f * (float)camera.pixelHeight);
		float z = 0.5f * (vector2.x + vector.x) + num3 * texelOffsetX;
		float w = 0.5f * (vector2.y + vector.y) + num4 * texelOffsetY;
		return new Vector4(num, num2, z, w);
	}

	public static Matrix4x4 GetProjectionMatrix(this Camera camera)
	{
		return camera.GetProjectionMatrix(0f, 0f);
	}

	public static Matrix4x4 GetProjectionMatrix(this Camera camera, float texelOffsetX, float texelOffsetY)
	{
		if (camera == null)
		{
			return Matrix4x4.identity;
		}
		Vector4 projectionExtents = camera.GetProjectionExtents(texelOffsetX, texelOffsetY);
		float farClipPlane = camera.farClipPlane;
		float nearClipPlane = camera.nearClipPlane;
		float num = projectionExtents.z - projectionExtents.x;
		float num2 = projectionExtents.z + projectionExtents.x;
		float num3 = projectionExtents.w - projectionExtents.y;
		float num4 = projectionExtents.w + projectionExtents.y;
		if (camera.orthographic)
		{
			return Matrix4x4Extension.GetOrthographicProjection(num, num2, num3, num4, nearClipPlane, farClipPlane);
		}
		return Matrix4x4Extension.GetPerspectiveProjection(num * nearClipPlane, num2 * nearClipPlane, num3 * nearClipPlane, num4 * nearClipPlane, nearClipPlane, farClipPlane);
	}
}
