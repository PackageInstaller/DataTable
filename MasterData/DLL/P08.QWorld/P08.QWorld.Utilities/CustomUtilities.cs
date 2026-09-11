using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.QWorld.Utilities;

public static class CustomUtilities
{
	public static Vector3 DeltaPositionFromRotate(this Transform transform, Vector3 platform, Quaternion deltaRotation)
	{
		Vector3 vector = transform.position - platform;
		Vector3 vector2 = deltaRotation * vector;
		return platform + vector2 - transform.position;
	}

	public static Vector3 Add(Vector3 vectorA, Vector3 vectorB)
	{
		vectorA.x += vectorB.x;
		vectorA.y += vectorB.y;
		return vectorA;
	}

	public static Vector3 Substract(Vector3 vectorA, Vector3 vectorB)
	{
		vectorA.x -= vectorB.x;
		vectorA.y -= vectorB.y;
		return vectorA;
	}

	public static Vector3 Multiply(Vector3 vectorValue, float floatValue)
	{
		vectorValue.x *= floatValue;
		vectorValue.y *= floatValue;
		vectorValue.z *= floatValue;
		return vectorValue;
	}

	public static Vector3 Multiply(Vector3 vectorValue, float floatValueA, float floatValueB)
	{
		vectorValue.x *= floatValueA * floatValueB;
		vectorValue.y *= floatValueA * floatValueB;
		vectorValue.z *= floatValueA * floatValueB;
		return vectorValue;
	}

	public static void AddMagnitude(ref Vector3 vector, float magnitude)
	{
		if (!(vector == Vector3.zero))
		{
			float num = Vector3.Magnitude(vector);
			Vector3 vector2 = vector / num;
			vector += vector2 * magnitude;
		}
	}

	public static void ChangeMagnitude(ref Vector3 vector, float magnitude)
	{
		if (!(vector == Vector3.zero))
		{
			Vector3 vector2 = Vector3.Normalize(vector);
			vector = vector2 * magnitude;
		}
	}

	public static void ChangeDirection(ref Vector3 vector, Vector3 direction)
	{
		if (!(vector == Vector3.zero))
		{
			float num = Vector3.Magnitude(vector);
			vector = direction * num;
		}
	}

	public static void ChangeDirectionOntoPlane(ref Vector3 vector, Vector3 planeNormal)
	{
		if (!(vector == Vector3.zero))
		{
			Vector3 vector2 = Vector3.Normalize(Vector3.ProjectOnPlane(vector, planeNormal));
			float num = Vector3.Magnitude(vector);
			vector = vector2 * num;
		}
	}

	public static void GetMagnitudeAndDirection(this Vector3 vector, out Vector3 direction, out float magnitude)
	{
		magnitude = Vector3.Magnitude(vector);
		direction = Vector3.Normalize(vector);
	}

	public static Vector3 ProjectOnTangent(Vector3 inputVector, Vector3 planeNormal, Vector3 up)
	{
		Vector3 vector = Vector3.Normalize(inputVector);
		if (vector == -up)
		{
			inputVector += planeNormal * 0.01f;
		}
		else if (vector == up)
		{
			return Vector3.zero;
		}
		Vector3 perpendicularDirection = GetPerpendicularDirection(inputVector, up);
		return Multiply(GetPerpendicularDirection(planeNormal, perpendicularDirection), Vector3.Magnitude(inputVector));
	}

	public static Vector3 DeflectVector(Vector3 inputVector, Vector3 planeA, Vector3 planeB, bool maintainMagnitude = false)
	{
		Vector3 perpendicularDirection = GetPerpendicularDirection(planeA, planeB);
		if (maintainMagnitude)
		{
			return perpendicularDirection * inputVector.magnitude;
		}
		return Vector3.Project(inputVector, perpendicularDirection);
	}

	public static Vector3 GetPerpendicularDirection(Vector3 vectorA, Vector3 vectorB)
	{
		return Vector3.Normalize(Vector3.Cross(vectorA, vectorB));
	}

	public static float GetTriangleValue(float center, float height, float width, float independentVariable, float minIndependentVariableLimit = float.NegativeInfinity, float maxIndependentVariableLimit = float.PositiveInfinity)
	{
		float num = center - width / 2f;
		float num2 = center + width / 2f;
		if (independentVariable < num || independentVariable > num2)
		{
			return 0f;
		}
		if (independentVariable < center)
		{
			return height * (independentVariable - num) / (center - num);
		}
		return (0f - height) * (independentVariable - center) / (num2 - center) + height;
	}

	public static void SetPositive<T>(ref T value) where T : IComparable<T>
	{
		SetMin(ref value, default(T));
	}

	public static void SetNegative<T>(ref T value) where T : IComparable<T>
	{
		SetMax(ref value, default(T));
	}

	public static void SetMin<T>(ref T value, T minValue) where T : IComparable<T>
	{
		if (value.CompareTo(minValue) < 0)
		{
			value = minValue;
		}
	}

	public static void SetMax<T>(ref T value, T maxValue) where T : IComparable<T>
	{
		if (value.CompareTo(maxValue) > 0)
		{
			value = maxValue;
		}
	}

	public static void SetRange<T>(ref T value, T minValue, T maxValue) where T : IComparable<T>
	{
		SetMin(ref value, minValue);
		SetMax(ref value, maxValue);
	}

	public static bool isBetween(float target, float a, float b, bool inclusive = false)
	{
		if (b > a)
		{
			if (inclusive ? (target >= a) : (target > a))
			{
				if (!inclusive)
				{
					return target < b;
				}
				return target <= b;
			}
			return false;
		}
		if (inclusive ? (target >= b) : (target > b))
		{
			if (!inclusive)
			{
				return target < a;
			}
			return target <= a;
		}
		return false;
	}

	public static bool isBetween(int target, int a, int b, bool inclusive = false)
	{
		if (b > a)
		{
			if (inclusive ? (target >= a) : (target > a))
			{
				if (!inclusive)
				{
					return target < b;
				}
				return target <= b;
			}
			return false;
		}
		if (inclusive ? (target >= b) : (target > b))
		{
			if (!inclusive)
			{
				return target < a;
			}
			return target <= a;
		}
		return false;
	}

	public static bool isCloseTo(Vector3 input, Vector3 target, float tolerance)
	{
		return Vector3.Distance(input, target) <= tolerance;
	}

	public static bool isCloseTo(float input, float target, float tolerance)
	{
		return Mathf.Abs(target - input) <= tolerance;
	}

	public static Vector3 TransformVectorUnscaled(this Transform transform, Vector3 vector)
	{
		return transform.rotation * vector;
	}

	public static Vector3 InverseTransformVectorUnscaled(this Transform transform, Vector3 vector)
	{
		return Quaternion.Inverse(transform.rotation) * vector;
	}

	public static Vector3 RotatePointAround(Vector3 point, Vector3 center, float angle, Vector3 axis)
	{
		Quaternion quaternion = Quaternion.AngleAxis(angle, axis);
		Vector3 vector = center - point;
		Vector3 vector2 = quaternion * vector;
		return center - vector2;
	}

	public static T GetOrAddComponent<T>(this GameObject targetGameObject, bool includeChildren = false) where T : Component
	{
		T val = (includeChildren ? targetGameObject.GetComponentInChildren<T>() : targetGameObject.GetComponent<T>());
		if (val != null)
		{
			return val;
		}
		return targetGameObject.AddComponent<T>();
	}

	public static T2 GetComponentInBranch<T1, T2>(this Component callerComponent, bool includeInactive = true) where T1 : Component where T2 : Component
	{
		T1[] componentsInChildren = callerComponent.transform.root.GetComponentsInChildren<T1>(includeInactive);
		if (componentsInChildren.Length == 0)
		{
			Debug.LogWarning("Root component: No objects found with " + typeof(T1).Name + " component");
			return null;
		}
		foreach (T1 val in componentsInChildren)
		{
			if (callerComponent.transform.IsChildOf(val.transform) || val.transform.IsChildOf(callerComponent.transform))
			{
				T2 componentInChildren = val.GetComponentInChildren<T2>(includeInactive);
				if (!(componentInChildren == null))
				{
					return componentInChildren;
				}
			}
		}
		return null;
	}

	public static T1 GetComponentInBranch<T1>(this Component callerComponent, bool includeInactive = true) where T1 : Component
	{
		return callerComponent.GetComponentInBranch<T1, T1>(includeInactive);
	}

	public static bool IsNullOrEmpty(this string target)
	{
		if (target != null)
		{
			return target.Length == 0;
		}
		return true;
	}

	public static bool IsNullOrWhiteSpace(this string target)
	{
		if (target == null)
		{
			return true;
		}
		for (int i = 0; i < target.Length; i++)
		{
			if (target[i] != ' ')
			{
				return false;
			}
		}
		return true;
	}

	public static string Between(this string targetString, string firstString, string lastString)
	{
		int num = targetString.IndexOf(firstString) + firstString.Length;
		int num2 = targetString.IndexOf(lastString);
		if (num2 - num < 0)
		{
			return "";
		}
		return targetString.Substring(num, num2 - num);
	}

	public static bool BelongsToLayerMask(int layer, int layerMask)
	{
		return (layerMask & (1 << layer)) > 0;
	}

	public static T1 GetOrAddComponent<T1>(this GameObject gameObject) where T1 : Component
	{
		if (!gameObject.TryGetComponent<T1>(out var component))
		{
			return gameObject.AddComponent<T1>();
		}
		return component;
	}

	public static T1 GetOrAddComponent<T1, T2>(this GameObject gameObject) where T1 : Component where T2 : Component
	{
		if (!gameObject.TryGetComponent<T1>(out var component) && gameObject.TryGetComponent<T2>(out var _))
		{
			return gameObject.AddComponent<T1>();
		}
		return component;
	}

	public static T1 GetOrAddComponent<T1>(this Component baseComponent) where T1 : Component
	{
		if (!baseComponent.TryGetComponent<T1>(out var component))
		{
			return baseComponent.gameObject.AddComponent<T1>();
		}
		return component;
	}

	public static T1 GetOrAddComponent<T1, T2>(this Component baseComponent) where T1 : Component where T2 : Component
	{
		if (!baseComponent.TryGetComponent<T1>(out var component) && baseComponent.TryGetComponent<T2>(out var _))
		{
			return baseComponent.gameObject.AddComponent<T1>();
		}
		return component;
	}

	public static T1 GetOrAddComponent<T1, T2>(this Component baseComponent, T2 requiredComponentType) where T1 : Component where T2 : Type
	{
		if (!baseComponent.TryGetComponent<T1>(out var component) && baseComponent.TryGetComponent<T2>(out var _))
		{
			return (T1)baseComponent.gameObject.AddComponent(requiredComponentType);
		}
		return component;
	}

	public static T2 GetOrRegisterValue<T1, T2>(this Dictionary<T1, T2> dictionary, T1 key, bool addIfNull = false) where T1 : Component where T2 : Component
	{
		if (key == null)
		{
			return null;
		}
		if (!dictionary.TryGetValue(key, out var value))
		{
			value = (addIfNull ? key.gameObject.GetOrAddComponent<T2>() : key.GetComponent<T2>());
			if (value != null)
			{
				dictionary.Add(key, value);
			}
		}
		return value;
	}

	public static T2 GetOrRegisterValue<T1, T2, T3>(this Dictionary<T1, T2> dictionary, T1 key, bool addIfNull = false) where T1 : Component where T2 : Component where T3 : Component
	{
		if (key == null)
		{
			return null;
		}
		if (!dictionary.TryGetValue(key, out var value))
		{
			value = (addIfNull ? key.gameObject.GetOrAddComponent<T2, T3>() : key.GetComponent<T2>());
			if (value != null)
			{
				dictionary.Add(key, value);
			}
		}
		return value;
	}

	public static float SignedAngle(Vector3 from, Vector3 to, Vector3 axis)
	{
		float num = Vector3.Angle(from, to);
		Vector3 vector = Vector3.Cross(from, to);
		vector.Normalize();
		return ((vector == axis) ? 1f : (-1f)) * num;
	}

	public static void DebugRay(Vector3 point, Vector3 direction = default(Vector3), float duration = 2f, Color color = default(Color))
	{
		Vector3 dir = ((direction == default(Vector3)) ? Vector3.up : direction);
		Color color2 = ((color == default(Color)) ? Color.blue : color);
		Debug.DrawRay(point, dir, color2, duration);
	}

	public static void DrawArrowGizmo(Vector3 start, Vector3 end, Color color, float radius = 0.25f)
	{
		Gizmos.color = color;
		Gizmos.DrawLine(start, end);
		Gizmos.DrawRay(end, Quaternion.AngleAxis(45f, Vector3.forward) * Vector3.Normalize(start - end) * radius);
		Gizmos.DrawRay(end, Quaternion.AngleAxis(-45f, Vector3.forward) * Vector3.Normalize(start - end) * radius);
	}

	public static void DrawGizmoCross(Vector3 point, float radius, Color color)
	{
		Gizmos.color = color;
		Gizmos.DrawRay(point + Vector3.up * 0.5f * radius, Vector3.down * radius);
		Gizmos.DrawRay(point + Vector3.right * 0.5f * radius, Vector3.left * radius);
	}

	public static void DrawDebugCross(Vector3 point, float radius, Color color, float angleOffset = 0f)
	{
		Debug.DrawRay(point + Quaternion.Euler(0f, 0f, angleOffset) * Vector3.up * 0.5f * radius, Quaternion.Euler(0f, 0f, angleOffset) * Vector3.down * radius, color);
		Debug.DrawRay(point + Quaternion.Euler(0f, 0f, angleOffset) * Vector3.right * 0.5f * radius, Quaternion.Euler(0f, 0f, angleOffset) * Vector3.left * radius, color);
	}

	public static bool GetCurrentClipLength(this Animator animator, ref float length)
	{
		if (animator.runtimeAnimatorController == null)
		{
			return false;
		}
		AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
		if (currentAnimatorClipInfo.Length == 0)
		{
			return false;
		}
		float length2 = currentAnimatorClipInfo[0].clip.length;
		float speed = animator.GetCurrentAnimatorStateInfo(0).speed;
		length = Mathf.Abs(length2 / speed);
		return true;
	}

	public static bool MatchTarget(this Animator animator, Vector3 targetPosition, Quaternion targetRotation, AvatarTarget avatarTarget, float startNormalizedTime, float targetNormalizedTime)
	{
		if (animator.runtimeAnimatorController == null)
		{
			return false;
		}
		if (animator.isMatchingTarget)
		{
			return false;
		}
		if (animator.IsInTransition(0))
		{
			return false;
		}
		MatchTargetWeightMask weightMask = new MatchTargetWeightMask(Vector3.one, 1f);
		animator.MatchTarget(targetPosition, targetRotation, avatarTarget, weightMask, startNormalizedTime, targetNormalizedTime);
		return true;
	}

	public static bool MatchTarget(this Animator animator, Vector3 targetPosition, AvatarTarget avatarTarget, float startNormalizedTime, float targetNormalizedTime)
	{
		if (animator.runtimeAnimatorController == null)
		{
			return false;
		}
		if (animator.isMatchingTarget)
		{
			return false;
		}
		if (animator.IsInTransition(0))
		{
			return false;
		}
		animator.MatchTarget(weightMask: new MatchTargetWeightMask(Vector3.one, 0f), matchPosition: targetPosition, matchRotation: Quaternion.identity, targetBodyPart: avatarTarget, startNormalizedTime: startNormalizedTime, targetNormalizedTime: targetNormalizedTime);
		return true;
	}

	public static bool MatchTarget(this Animator animator, Transform target, AvatarTarget avatarTarget, float startNormalizedTime, float targetNormalizedTime)
	{
		if (animator.runtimeAnimatorController == null)
		{
			return false;
		}
		if (animator.isMatchingTarget)
		{
			return false;
		}
		if (animator.IsInTransition(0))
		{
			return false;
		}
		animator.MatchTarget(weightMask: new MatchTargetWeightMask(Vector3.one, 1f), matchPosition: target.position, matchRotation: target.rotation, targetBodyPart: avatarTarget, startNormalizedTime: startNormalizedTime, targetNormalizedTime: targetNormalizedTime);
		return true;
	}

	public static bool MatchTarget(this Animator animator, Transform target, AvatarTarget avatarTarget, float startNormalizedTime, float targetNormalizedTime, MatchTargetWeightMask weightMask)
	{
		if (animator.runtimeAnimatorController == null)
		{
			return false;
		}
		if (animator.isMatchingTarget)
		{
			return false;
		}
		if (animator.IsInTransition(0))
		{
			return false;
		}
		animator.MatchTarget(target.position, target.rotation, AvatarTarget.Root, weightMask, startNormalizedTime, targetNormalizedTime);
		return true;
	}
}
