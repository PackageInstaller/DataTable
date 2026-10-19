using System;
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
	}

	public Matrix4x4 localToWorldMatrix
	{
		get
		{
			GetLocalToWorldMatrix(ref this, out var m);
			return m;
		}
	}

	public bool isValid => hierarchy != IntPtr.Zero;

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
	[NativeMethod(Name = "TransformAccessBindings::GetLocalToWorldMatrix", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalToWorldMatrix(ref TransformAccess access, out Matrix4x4 m);
}
