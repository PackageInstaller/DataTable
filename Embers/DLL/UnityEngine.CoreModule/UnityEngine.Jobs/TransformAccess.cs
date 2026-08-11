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
	}

	public Quaternion rotation
	{
		get
		{
			GetRotation(ref this, out var r);
			return r;
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

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetPosition", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetPosition(ref TransformAccess access, out Vector3 p);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetRotation", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetRotation(ref TransformAccess access, out Quaternion r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalScale", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalScale(ref TransformAccess access, out Vector3 r);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessBindings::GetLocalToWorldMatrix", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	private static extern void GetLocalToWorldMatrix(ref TransformAccess access, out Matrix4x4 m);
}
