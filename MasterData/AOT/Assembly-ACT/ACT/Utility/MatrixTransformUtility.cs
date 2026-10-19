using UnityEngine;

namespace ACT.Utility;

public static class MatrixTransformUtility
{
	public static Vector2 WorldToScreenPoint(Vector3 worldPosition, Camera camera)
	{
		if (camera == null)
		{
			return Vector2.zero;
		}
		return camera.WorldToScreenPoint(worldPosition);
	}

	public static Vector2 WorldToCanvasPoint(Vector3 worldPosition, Camera worldCamera, RectTransform canvasRect, Camera uiCamera = null)
	{
		if (worldCamera == null || canvasRect == null)
		{
			return Vector2.zero;
		}
		Vector3 vector = worldCamera.WorldToScreenPoint(worldPosition);
		if (vector.z < 0f)
		{
			return Vector2.zero;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRect, vector, uiCamera, out var localPoint);
		return localPoint;
	}

	public static Vector2 WorldToCanvasPointWithVisibility(Vector3 worldPosition, Camera worldCamera, RectTransform canvasRect, Camera uiCamera, out bool isVisible)
	{
		isVisible = false;
		if (worldCamera == null || canvasRect == null)
		{
			return Vector2.zero;
		}
		Vector3 vector = worldCamera.WorldToViewportPoint(worldPosition);
		isVisible = vector.z > 0f && vector.x >= 0f && vector.x <= 1f && vector.y >= 0f && vector.y <= 1f;
		Vector3 vector2 = worldCamera.WorldToScreenPoint(worldPosition);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRect, vector2, uiCamera, out var localPoint);
		return localPoint;
	}

	public static Matrix4x4 CreateTRSMatrix(Vector3 position, Quaternion rotation, Vector3 scale)
	{
		return Matrix4x4.TRS(position, rotation, scale);
	}

	public static Matrix4x4 CreateWorldTRSMatrix(Transform transform)
	{
		if (transform == null)
		{
			return Matrix4x4.identity;
		}
		return Matrix4x4.TRS(transform.position, transform.rotation, transform.lossyScale);
	}

	public static Matrix4x4 CreateLocalTRSMatrix(Transform transform)
	{
		if (transform == null)
		{
			return Matrix4x4.identity;
		}
		return Matrix4x4.TRS(transform.localPosition, transform.localRotation, transform.localScale);
	}

	public static Vector3 TransformPoint(Matrix4x4 matrix, Vector3 point)
	{
		return matrix.MultiplyPoint3x4(point);
	}

	public static Vector3 TransformDirection(Matrix4x4 matrix, Vector3 direction)
	{
		return matrix.MultiplyVector(direction);
	}

	public static Vector3 InverseTransformPoint(Matrix4x4 matrix, Vector3 point)
	{
		return matrix.inverse.MultiplyPoint3x4(point);
	}

	public static Vector3 ExtractPosition(Matrix4x4 matrix)
	{
		return matrix.GetColumn(3);
	}

	public static Quaternion ExtractRotation(Matrix4x4 matrix)
	{
		return matrix.rotation;
	}

	public static Vector3 ExtractScale(Matrix4x4 matrix)
	{
		return matrix.lossyScale;
	}

	public static void DecomposeTRSMatrix(Matrix4x4 matrix, out Vector3 position, out Quaternion rotation, out Vector3 scale)
	{
		position = ExtractPosition(matrix);
		rotation = ExtractRotation(matrix);
		scale = ExtractScale(matrix);
	}

	public static Matrix4x4 CreateOrthographicMatrix(float left, float right, float bottom, float top, float near, float far)
	{
		return Matrix4x4.Ortho(left, right, bottom, top, near, far);
	}

	public static Matrix4x4 CreatePerspectiveMatrix(float fov, float aspect, float near, float far)
	{
		return Matrix4x4.Perspective(fov, aspect, near, far);
	}

	public static Matrix4x4 CreateLookAtMatrix(Vector3 eye, Vector3 target, Vector3 up)
	{
		return Matrix4x4.LookAt(eye, target, up);
	}

	public static Vector3 WorldToLocal(Vector3 worldPoint, Transform localTransform)
	{
		if (localTransform == null)
		{
			return worldPoint;
		}
		return localTransform.InverseTransformPoint(worldPoint);
	}

	public static Vector3 LocalToWorld(Vector3 localPoint, Transform localTransform)
	{
		if (localTransform == null)
		{
			return localPoint;
		}
		return localTransform.TransformPoint(localPoint);
	}

	public static Vector3 WorldToViewport(Vector3 worldPoint, Camera camera)
	{
		if (camera == null)
		{
			return Vector3.zero;
		}
		return camera.WorldToViewportPoint(worldPoint);
	}

	public static Vector3 ViewportToWorld(Vector3 viewportPoint, Camera camera)
	{
		if (camera == null)
		{
			return Vector3.zero;
		}
		return camera.ViewportToWorldPoint(viewportPoint);
	}

	public static Vector3 ScreenToWorld(Vector2 screenPoint, Camera camera, float depth)
	{
		if (camera == null)
		{
			return Vector3.zero;
		}
		Vector3 position = new Vector3(screenPoint.x, screenPoint.y, depth);
		return camera.ScreenToWorldPoint(position);
	}

	public static Vector2 WorldToCanvasPointClamped(Vector3 worldPosition, Camera worldCamera, RectTransform canvasRect, Camera uiCamera, float padding = 50f)
	{
		Vector2 result = WorldToCanvasPoint(worldPosition, worldCamera, canvasRect, uiCamera);
		if (canvasRect == null)
		{
			return result;
		}
		Vector2 vector = canvasRect.rect.size * 0.5f;
		result.x = Mathf.Clamp(result.x, 0f - vector.x + padding, vector.x - padding);
		result.y = Mathf.Clamp(result.y, 0f - vector.y + padding, vector.y - padding);
		return result;
	}

	public static float CalculateDistanceScale(Vector3 worldPosition, Camera camera, float maxDistance = 20f, float minScale = 0.5f, float maxScale = 1f)
	{
		if (camera == null)
		{
			return maxScale;
		}
		float t = Mathf.Clamp01(Vector3.Distance(camera.transform.position, worldPosition) / maxDistance);
		return Mathf.Lerp(maxScale, minScale, t);
	}

	public static bool IsVisibleFromCamera(Vector3 worldPosition, Camera camera)
	{
		if (camera == null)
		{
			return false;
		}
		Vector3 vector = camera.WorldToViewportPoint(worldPosition);
		if (vector.z > 0f && vector.x >= 0f && vector.x <= 1f && vector.y >= 0f)
		{
			return vector.y <= 1f;
		}
		return false;
	}
}
