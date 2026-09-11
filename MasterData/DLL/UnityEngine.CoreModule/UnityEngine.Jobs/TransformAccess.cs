using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Jobs;

[NativeHeader("Runtime/Transform/ScriptBindings/TransformAccess.bindings.h")]
public struct TransformAccess
{
	private IntPtr hierarchy;

	private int index;

	public Vector3 position
	{
		get
		{
			GetPosition(ref this, out var p);
			return p;
		}
		set
		{
			SetPosition(ref this, ref value);
		}
	}

	public Quaternion rotation
	{
		get
		{
			GetRotation(ref this, out var r);
			return r;
		}
		set
		{
			SetRotation(ref this, ref value);
		}
	}

	public Vector3 localPosition
	{
		get
		{
			GetLocalPosition(ref this, out var p);
			return p;
		}
		set
		{
			SetLocalPosition(ref this, ref value);
		}
	}

	public Quaternion localRotation
	{
		get
		{
			GetLocalRotation(ref this, out var r);
			return r;
		}
		set
		{
			SetLocalRotation(ref this, ref value);
		}
	}

	public Vector3 localScale
	{
		get
		{
			GetLocalScale(ref this, out var r);
			return r;
		}
		set
		{
			SetLocalScale(ref this, ref value);
		}
	}

	public Matrix4x4 localToWorldMatrix
	{
		get
		{
			GetLocalToWorldMatrix(ref this, out var m);
			return m;
		}
	}

	public Matrix4x4 worldToLocalMatrix
	{
		get
		{
			GetWorldToLocalMatrix(ref this, out var m);
			return m;
		}
	}

	public bool isValid => hierarchy != IntPtr.Zero;

	public void SetPositionAndRotation(Vector3 position, Quaternion rotation)
	{
		SetPositionAndRotation_Internal(ref this, ref position, ref rotation);
	}

	public void SetLocalPositionAndRotation(Vector3 localPosition, Quaternion localRotation)
	{
		SetLocalPositionAndRotation_Internal(ref this, ref localPosition, ref localRotation);
	}

	public void GetPositionAndRotation(out Vector3 position, out Quaternion rotation)
	{
		GetPositionAndRotation_Internal(ref this, out position, out rotation);
	}

	public void GetLocalPositionAndRotation(out Vector3 localPosition, out Quaternion localRotation)
	{
		GetLocalPositionAndRotation_Internal(ref this, out localPosition, out localRotation);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetPositionAndRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetPositionAndRotation_Internal(ref TransformAccess access, ref Vector3 position, ref Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetLocalPositionAndRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetLocalPositionAndRotation_Internal(ref TransformAccess access, ref Vector3 localPosition, ref Quaternion localRotation);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetPositionAndRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetPositionAndRotation_Internal(ref TransformAccess access, out Vector3 position, out Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalPositionAndRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalPositionAndRotation_Internal(ref TransformAccess access, out Vector3 localPosition, out Quaternion localRotation);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetPosition", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetPosition(ref TransformAccess access, out Vector3 p);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetPosition", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetPosition(ref TransformAccess access, ref Vector3 p);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetRotation(ref TransformAccess access, out Quaternion r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetRotation(ref TransformAccess access, ref Quaternion r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalPosition", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalPosition(ref TransformAccess access, out Vector3 p);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetLocalPosition", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetLocalPosition(ref TransformAccess access, ref Vector3 p);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalRotation(ref TransformAccess access, out Quaternion r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetLocalRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetLocalRotation(ref TransformAccess access, ref Quaternion r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalScale", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalScale(ref TransformAccess access, out Vector3 r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::SetLocalScale", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void SetLocalScale(ref TransformAccess access, ref Vector3 r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalToWorldMatrix", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalToWorldMatrix(ref TransformAccess access, out Matrix4x4 m);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetWorldToLocalMatrix", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetWorldToLocalMatrix(ref TransformAccess access, out Matrix4x4 m);

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal void CheckHierarchyValid()
	{
		if (!isValid)
		{
			throw new NullReferenceException("The TransformAccess is not valid and points to an invalid hierarchy");
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal void MarkReadWrite()
	{
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal void MarkReadOnly()
	{
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	private void CheckWriteAccess()
	{
	}
}
