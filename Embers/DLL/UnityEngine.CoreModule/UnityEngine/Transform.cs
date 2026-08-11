using System;
using System.Collections;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[NativeHeader("Runtime/Transform/Transform.h")]
[NativeHeader("Configuration/UnityConfigure.h")]
[NativeHeader("Runtime/Transform/ScriptBindings/TransformScriptBindings.h")]
public class Transform : Component, IEnumerable
{
	private class Enumerator : IEnumerator
	{
		private Transform outer;

		private int currentIndex = -1;

		public object Current => outer.GetChild(currentIndex);

		internal Enumerator(Transform outer)
		{
			this.outer = outer;
		}

		public bool MoveNext()
		{
			int childCount = outer.childCount;
			return ++currentIndex < childCount;
		}

		public void Reset()
		{
			currentIndex = -1;
		}
	}

	public Vector3 position
	{
		get
		{
			get_position_Injected(out var ret);
			return ret;
		}
		set
		{
			set_position_Injected(ref value);
		}
	}

	public Vector3 localPosition
	{
		get
		{
			get_localPosition_Injected(out var ret);
			return ret;
		}
		set
		{
			set_localPosition_Injected(ref value);
		}
	}

	public Vector3 eulerAngles
	{
		get
		{
			return rotation.eulerAngles;
		}
		set
		{
			rotation = Quaternion.Euler(value);
		}
	}

	public Vector3 localEulerAngles
	{
		get
		{
			return localRotation.eulerAngles;
		}
		set
		{
			localRotation = Quaternion.Euler(value);
		}
	}

	public Vector3 right
	{
		get
		{
			return rotation * Vector3.right;
		}
		set
		{
			rotation = Quaternion.FromToRotation(Vector3.right, value);
		}
	}

	public Vector3 up
	{
		get
		{
			return rotation * Vector3.up;
		}
		set
		{
			rotation = Quaternion.FromToRotation(Vector3.up, value);
		}
	}

	public Vector3 forward
	{
		get
		{
			return rotation * Vector3.forward;
		}
		set
		{
			rotation = Quaternion.LookRotation(value);
		}
	}

	public Quaternion rotation
	{
		get
		{
			get_rotation_Injected(out var ret);
			return ret;
		}
		set
		{
			set_rotation_Injected(ref value);
		}
	}

	public Quaternion localRotation
	{
		get
		{
			get_localRotation_Injected(out var ret);
			return ret;
		}
		set
		{
			set_localRotation_Injected(ref value);
		}
	}

	[NativeConditional("UNITY_EDITOR")]
	internal RotationOrder rotationOrder
	{
		get
		{
			return (RotationOrder)GetRotationOrderInternal();
		}
		set
		{
			SetRotationOrderInternal(value);
		}
	}

	public Vector3 localScale
	{
		get
		{
			get_localScale_Injected(out var ret);
			return ret;
		}
		set
		{
			set_localScale_Injected(ref value);
		}
	}

	public Transform parent
	{
		get
		{
			return parentInternal;
		}
		set
		{
			if (this is RectTransform)
			{
				Debug.LogWarning("Parent of RectTransform is being set with parent property. Consider using the SetParent method instead, with the worldPositionStays argument set to false. This will retain local orientation and scale rather than world orientation and scale, which can prevent common UI scaling issues.", this);
			}
			parentInternal = value;
		}
	}

	internal Transform parentInternal
	{
		get
		{
			return GetParent();
		}
		set
		{
			SetParent(value);
		}
	}

	public Matrix4x4 worldToLocalMatrix
	{
		get
		{
			get_worldToLocalMatrix_Injected(out var ret);
			return ret;
		}
	}

	public Matrix4x4 localToWorldMatrix
	{
		get
		{
			get_localToWorldMatrix_Injected(out var ret);
			return ret;
		}
	}

	public Transform root => GetRoot();

	public extern int childCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetChildrenCount")]
		get;
	}

	public Vector3 lossyScale
	{
		[NativeMethod("GetWorldScaleLossy")]
		get
		{
			get_lossyScale_Injected(out var ret);
			return ret;
		}
	}

	[NativeProperty("HasChangedDeprecated")]
	public extern bool hasChanged
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public int hierarchyCapacity
	{
		get
		{
			return internal_getHierarchyCapacity();
		}
		set
		{
			internal_setHierarchyCapacity(value);
		}
	}

	public int hierarchyCount => internal_getHierarchyCount();

	[NativeConditional("UNITY_EDITOR")]
	internal bool constrainProportionsScale
	{
		get
		{
			return IsConstrainProportionsScale();
		}
		set
		{
			SetConstrainProportionsScale(value);
		}
	}

	protected Transform()
	{
	}

	internal Vector3 GetLocalEulerAngles(RotationOrder order)
	{
		GetLocalEulerAngles_Injected(order, out var ret);
		return ret;
	}

	internal void SetLocalEulerAngles(Vector3 euler, RotationOrder order)
	{
		SetLocalEulerAngles_Injected(ref euler, order);
	}

	[NativeConditional("UNITY_EDITOR")]
	internal void SetLocalEulerHint(Vector3 euler)
	{
		SetLocalEulerHint_Injected(ref euler);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetRotationOrder")]
	[NativeConditional("UNITY_EDITOR")]
	internal extern int GetRotationOrderInternal();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("UNITY_EDITOR")]
	[NativeMethod("SetRotationOrder")]
	internal extern void SetRotationOrderInternal(RotationOrder rotationOrder);

	[MethodImpl((MethodImplOptions)4096)]
	private extern Transform GetParent();

	public void SetParent(Transform p)
	{
		SetParent(p, worldPositionStays: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetParent", HasExplicitThis = true)]
	public extern void SetParent(Transform parent, bool worldPositionStays);

	public void SetPositionAndRotation(Vector3 position, Quaternion rotation)
	{
		SetPositionAndRotation_Injected(ref position, ref rotation);
	}

	public void SetLocalPositionAndRotation(Vector3 localPosition, Quaternion localRotation)
	{
		SetLocalPositionAndRotation_Injected(ref localPosition, ref localRotation);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void GetPositionAndRotation(out Vector3 position, out Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void GetLocalPositionAndRotation(out Vector3 localPosition, out Quaternion localRotation);

	public void Translate(Vector3 translation, [DefaultValue("Space.Self")] Space relativeTo)
	{
		if (relativeTo == Space.World)
		{
			position += translation;
		}
		else
		{
			position += TransformDirection(translation);
		}
	}

	public void Translate(Vector3 translation)
	{
		Translate(translation, Space.Self);
	}

	public void Translate(float x, float y, float z, [DefaultValue("Space.Self")] Space relativeTo)
	{
		Translate(new Vector3(x, y, z), relativeTo);
	}

	public void Translate(float x, float y, float z)
	{
		Translate(new Vector3(x, y, z), Space.Self);
	}

	public void Translate(Vector3 translation, Transform relativeTo)
	{
		if ((bool)relativeTo)
		{
			position += relativeTo.TransformDirection(translation);
		}
		else
		{
			position += translation;
		}
	}

	public void Translate(float x, float y, float z, Transform relativeTo)
	{
		Translate(new Vector3(x, y, z), relativeTo);
	}

	public void Rotate(Vector3 eulers, [DefaultValue("Space.Self")] Space relativeTo)
	{
		Quaternion quaternion = Quaternion.Euler(eulers.x, eulers.y, eulers.z);
		if (relativeTo == Space.Self)
		{
			localRotation *= quaternion;
		}
		else
		{
			rotation *= Quaternion.Inverse(rotation) * quaternion * rotation;
		}
	}

	public void Rotate(Vector3 eulers)
	{
		Rotate(eulers, Space.Self);
	}

	public void Rotate(float xAngle, float yAngle, float zAngle, [DefaultValue("Space.Self")] Space relativeTo)
	{
		Rotate(new Vector3(xAngle, yAngle, zAngle), relativeTo);
	}

	public void Rotate(float xAngle, float yAngle, float zAngle)
	{
		Rotate(new Vector3(xAngle, yAngle, zAngle), Space.Self);
	}

	[NativeMethod("RotateAround")]
	internal void RotateAroundInternal(Vector3 axis, float angle)
	{
		RotateAroundInternal_Injected(ref axis, angle);
	}

	public void Rotate(Vector3 axis, float angle, [DefaultValue("Space.Self")] Space relativeTo)
	{
		if (relativeTo == Space.Self)
		{
			RotateAroundInternal(base.transform.TransformDirection(axis), angle * (MathF.PI / 180f));
		}
		else
		{
			RotateAroundInternal(axis, angle * (MathF.PI / 180f));
		}
	}

	public void Rotate(Vector3 axis, float angle)
	{
		Rotate(axis, angle, Space.Self);
	}

	public void RotateAround(Vector3 point, Vector3 axis, float angle)
	{
		Vector3 vector = position;
		Quaternion quaternion = Quaternion.AngleAxis(angle, axis);
		Vector3 vector2 = vector - point;
		vector2 = quaternion * vector2;
		vector = point + vector2;
		position = vector;
		RotateAroundInternal(axis, angle * (MathF.PI / 180f));
	}

	public void LookAt(Transform target, [DefaultValue("Vector3.up")] Vector3 worldUp)
	{
		if ((bool)target)
		{
			LookAt(target.position, worldUp);
		}
	}

	public void LookAt(Transform target)
	{
		if ((bool)target)
		{
			LookAt(target.position, Vector3.up);
		}
	}

	public void LookAt(Vector3 worldPosition, [DefaultValue("Vector3.up")] Vector3 worldUp)
	{
		Internal_LookAt(worldPosition, worldUp);
	}

	public void LookAt(Vector3 worldPosition)
	{
		Internal_LookAt(worldPosition, Vector3.up);
	}

	[FreeFunction("Internal_LookAt", HasExplicitThis = true)]
	private void Internal_LookAt(Vector3 worldPosition, Vector3 worldUp)
	{
		Internal_LookAt_Injected(ref worldPosition, ref worldUp);
	}

	public Vector3 TransformDirection(Vector3 direction)
	{
		TransformDirection_Injected(ref direction, out var ret);
		return ret;
	}

	public Vector3 TransformDirection(float x, float y, float z)
	{
		return TransformDirection(new Vector3(x, y, z));
	}

	public Vector3 InverseTransformDirection(Vector3 direction)
	{
		InverseTransformDirection_Injected(ref direction, out var ret);
		return ret;
	}

	public Vector3 InverseTransformDirection(float x, float y, float z)
	{
		return InverseTransformDirection(new Vector3(x, y, z));
	}

	public Vector3 TransformVector(Vector3 vector)
	{
		TransformVector_Injected(ref vector, out var ret);
		return ret;
	}

	public Vector3 TransformVector(float x, float y, float z)
	{
		return TransformVector(new Vector3(x, y, z));
	}

	public Vector3 InverseTransformVector(Vector3 vector)
	{
		InverseTransformVector_Injected(ref vector, out var ret);
		return ret;
	}

	public Vector3 InverseTransformVector(float x, float y, float z)
	{
		return InverseTransformVector(new Vector3(x, y, z));
	}

	public Vector3 TransformPoint(Vector3 position)
	{
		TransformPoint_Injected(ref position, out var ret);
		return ret;
	}

	public Vector3 TransformPoint(float x, float y, float z)
	{
		return TransformPoint(new Vector3(x, y, z));
	}

	public Vector3 InverseTransformPoint(Vector3 position)
	{
		InverseTransformPoint_Injected(ref position, out var ret);
		return ret;
	}

	public Vector3 InverseTransformPoint(float x, float y, float z)
	{
		return InverseTransformPoint(new Vector3(x, y, z));
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern Transform GetRoot();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DetachChildren", HasExplicitThis = true)]
	public extern void DetachChildren();

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetAsFirstSibling();

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetAsLastSibling();

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetSiblingIndex(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("MoveAfterSiblingInternal")]
	internal extern void MoveAfterSibling(Transform transform, bool notifyEditorAndMarkDirty);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetSiblingIndex();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern Transform FindRelativeTransformWithPath([NotNull("NullExceptionObject")] Transform transform, string path, [DefaultValue("false")] bool isActiveOnly);

	public Transform Find(string n)
	{
		if (n == null)
		{
			throw new ArgumentNullException("Name cannot be null");
		}
		return FindRelativeTransformWithPath(this, n, isActiveOnly: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("UNITY_EDITOR")]
	internal extern void SendTransformChangedScale();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Internal_IsChildOrSameTransform", HasExplicitThis = true)]
	public extern bool IsChildOf([NotNull("ArgumentNullException")] Transform parent);

	[Obsolete("FindChild has been deprecated. Use Find instead (UnityUpgradable) -> Find([mscorlib] System.String)", false)]
	public Transform FindChild(string n)
	{
		return Find(n);
	}

	public IEnumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	[Obsolete("warning use Transform.Rotate instead.")]
	public void RotateAround(Vector3 axis, float angle)
	{
		RotateAround_Injected(ref axis, angle);
	}

	[Obsolete("warning use Transform.Rotate instead.")]
	public void RotateAroundLocal(Vector3 axis, float angle)
	{
		RotateAroundLocal_Injected(ref axis, angle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetChild", HasExplicitThis = true)]
	[NativeThrows]
	public extern Transform GetChild(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[Obsolete("warning use Transform.childCount instead (UnityUpgradable) -> Transform.childCount", false)]
	[NativeMethod("GetChildrenCount")]
	public extern int GetChildCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetHierarchyCapacity", HasExplicitThis = true)]
	private extern int internal_getHierarchyCapacity();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetHierarchyCapacity", HasExplicitThis = true)]
	private extern void internal_setHierarchyCapacity(int value);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetHierarchyCount", HasExplicitThis = true)]
	private extern int internal_getHierarchyCount();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("UNITY_EDITOR")]
	[FreeFunction("IsNonUniformScaleTransform", HasExplicitThis = true)]
	internal extern bool IsNonUniformScaleTransform();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("UNITY_EDITOR")]
	private extern void SetConstrainProportionsScale(bool isLinked);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("UNITY_EDITOR")]
	private extern bool IsConstrainProportionsScale();

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_position_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_position_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localPosition_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localPosition_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetLocalEulerAngles_Injected(RotationOrder order, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLocalEulerAngles_Injected(ref Vector3 euler, RotationOrder order);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLocalEulerHint_Injected(ref Vector3 euler);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_rotation_Injected(out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_rotation_Injected(ref Quaternion value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localRotation_Injected(out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localRotation_Injected(ref Quaternion value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localScale_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localScale_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_worldToLocalMatrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localToWorldMatrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetPositionAndRotation_Injected(ref Vector3 position, ref Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLocalPositionAndRotation_Injected(ref Vector3 localPosition, ref Quaternion localRotation);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void RotateAroundInternal_Injected(ref Vector3 axis, float angle);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_LookAt_Injected(ref Vector3 worldPosition, ref Vector3 worldUp);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void TransformDirection_Injected(ref Vector3 direction, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void InverseTransformDirection_Injected(ref Vector3 direction, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void TransformVector_Injected(ref Vector3 vector, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void InverseTransformVector_Injected(ref Vector3 vector, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void TransformPoint_Injected(ref Vector3 position, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void InverseTransformPoint_Injected(ref Vector3 position, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_lossyScale_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void RotateAround_Injected(ref Vector3 axis, float angle);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void RotateAroundLocal_Injected(ref Vector3 axis, float angle);
}
