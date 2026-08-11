#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

public static class UnityExtension
{
	private static readonly List<Transform> s_CachedTransforms = new List<Transform>();

	public static T GetOrAddComponent<T>(this GameObject gameObject) where T : Component
	{
		if (!gameObject.TryGetComponent<T>(out var component))
		{
			return gameObject.AddComponent<T>();
		}
		return component;
	}

	public static Component GetOrAddComponent(this GameObject gameObject, Type type)
	{
		if (!type.IsSubclassOf(typeof(Component)))
		{
			Log.Error("Type '{0}' is not a subclass of UnityEngine.Component.", type.FullName);
			return null;
		}
		if (!gameObject.TryGetComponent(type, out var component))
		{
			component = gameObject.AddComponent(type);
		}
		return component;
	}

	public static Component GetOrAddComponent(this Transform transform, Type type)
	{
		if (!type.IsSubclassOf(typeof(Component)))
		{
			Log.Error("Type '{0}' is not a subclass of UnityEngine.Component.", type.FullName);
			return null;
		}
		if (!transform.TryGetComponent(type, out var component))
		{
			component = transform.gameObject.AddComponent(type);
		}
		return component;
	}

	public static bool InScene(this GameObject gameObject)
	{
		return gameObject.scene.name != null;
	}

	public static void SetLayerRecursively(this GameObject gameObject, int layer)
	{
		gameObject.GetComponentsInChildren(includeInactive: true, s_CachedTransforms);
		for (int i = 0; i < s_CachedTransforms.Count; i++)
		{
			s_CachedTransforms[i].gameObject.layer = layer;
		}
		s_CachedTransforms.Clear();
	}

	public static Vector2 ToVector2(this Vector3 vector3)
	{
		return new Vector2(vector3.x, vector3.z);
	}

	public static Vector3 ToVector3(this Vector2 vector2)
	{
		return new Vector3(vector2.x, 0f, vector2.y);
	}

	public static Vector3 ToVector3(this Vector2 vector2, float y)
	{
		return new Vector3(vector2.x, y, vector2.y);
	}

	public static void SetPositionX(this Transform transform, float newValue)
	{
		Vector3 position = transform.position;
		position.x = newValue;
		transform.position = position;
	}

	public static void SetPositionY(this Transform transform, float newValue)
	{
		Vector3 position = transform.position;
		position.y = newValue;
		transform.position = position;
	}

	public static void SetPositionZ(this Transform transform, float newValue)
	{
		Vector3 position = transform.position;
		position.z = newValue;
		transform.position = position;
	}

	public static void AddPositionX(this Transform transform, float deltaValue)
	{
		Vector3 position = transform.position;
		position.x += deltaValue;
		transform.position = position;
	}

	public static void AddPositionY(this Transform transform, float deltaValue)
	{
		Vector3 position = transform.position;
		position.y += deltaValue;
		transform.position = position;
	}

	public static void AddPositionZ(this Transform transform, float deltaValue)
	{
		Vector3 position = transform.position;
		position.z += deltaValue;
		transform.position = position;
	}

	public static void SetLocalPositionX(this Transform transform, float newValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.x = newValue;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionY(this Transform transform, float newValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.y = newValue;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionZ(this Transform transform, float newValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.z = newValue;
		transform.localPosition = localPosition;
	}

	public static void AddLocalPositionX(this Transform transform, float deltaValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.x += deltaValue;
		transform.localPosition = localPosition;
	}

	public static void AddLocalPositionY(this Transform transform, float deltaValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.y += deltaValue;
		transform.localPosition = localPosition;
	}

	public static void AddLocalPositionZ(this Transform transform, float deltaValue)
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.z += deltaValue;
		transform.localPosition = localPosition;
	}

	public static void SetLocalScaleX(this Transform transform, float newValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.x = newValue;
		transform.localScale = localScale;
	}

	public static void SetLocalScaleY(this Transform transform, float newValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.y = newValue;
		transform.localScale = localScale;
	}

	public static void SetLocalScaleZ(this Transform transform, float newValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.z = newValue;
		transform.localScale = localScale;
	}

	public static void AddLocalScaleX(this Transform transform, float deltaValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.x += deltaValue;
		transform.localScale = localScale;
	}

	public static void AddLocalScaleY(this Transform transform, float deltaValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.y += deltaValue;
		transform.localScale = localScale;
	}

	public static void AddLocalScaleZ(this Transform transform, float deltaValue)
	{
		Vector3 localScale = transform.localScale;
		localScale.z += deltaValue;
		transform.localScale = localScale;
	}

	public static void LookAt2D(this Transform transform, Vector2 lookAtPoint2D)
	{
		Vector3 vector = lookAtPoint2D.ToVector3() - transform.position;
		vector.y = 0f;
		if (vector.magnitude > 0f)
		{
			transform.rotation = Quaternion.LookRotation(vector.normalized, Vector3.up);
		}
	}
}
