using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Math/AnimationCurve.bindings.h")]
public class AnimationCurve : IEquatable<AnimationCurve>
{
	internal IntPtr m_Ptr;

	public Keyframe[] keys
	{
		get
		{
			return GetKeys();
		}
		set
		{
			SetKeys(value);
		}
	}

	public Keyframe this[int index] => GetKey(index);

	public extern int length
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetKeyCount", IsThreadSafe = true)]
		get;
	}

	public extern WrapMode preWrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetPreInfinity", IsThreadSafe = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetPreInfinity", IsThreadSafe = true)]
		set;
	}

	public extern WrapMode postWrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetPostInfinity", IsThreadSafe = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetPostInfinity", IsThreadSafe = true)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::Internal_Destroy", IsThreadSafe = true)]
	private static extern void Internal_Destroy(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::Internal_Create", IsThreadSafe = true)]
	private static extern IntPtr Internal_Create(Keyframe[] keys);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::Internal_Equals", HasExplicitThis = true, IsThreadSafe = true)]
	private extern bool Internal_Equals(IntPtr other);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::Internal_CopyFrom", HasExplicitThis = true, IsThreadSafe = true)]
	private extern void Internal_CopyFrom(IntPtr other);

	~AnimationCurve()
	{
		Internal_Destroy(m_Ptr);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public extern float Evaluate(float time);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::AddKeySmoothTangents", HasExplicitThis = true, IsThreadSafe = true)]
	public extern int AddKey(float time, float value);

	public int AddKey(Keyframe key)
	{
		return AddKey_Internal(key);
	}

	[NativeMethod("AddKey", IsThreadSafe = true)]
	private int AddKey_Internal(Keyframe key)
	{
		return AddKey_Internal_Injected(ref key);
	}

	[FreeFunction("AnimationCurveBindings::MoveKey", HasExplicitThis = true, IsThreadSafe = true)]
	[NativeThrows]
	public int MoveKey(int index, Keyframe key)
	{
		return MoveKey_Injected(index, ref key);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::ClearKeys", HasExplicitThis = true, IsThreadSafe = true)]
	public extern void ClearKeys();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	[FreeFunction("AnimationCurveBindings::RemoveKey", HasExplicitThis = true, IsThreadSafe = true)]
	public extern void RemoveKey(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::SetKeys", HasExplicitThis = true, IsThreadSafe = true)]
	private extern void SetKeys(Keyframe[] keys);

	[NativeThrows]
	[FreeFunction("AnimationCurveBindings::GetKey", HasExplicitThis = true, IsThreadSafe = true)]
	private Keyframe GetKey(int index)
	{
		GetKey_Injected(index, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::GetKeys", HasExplicitThis = true, IsThreadSafe = true)]
	private extern Keyframe[] GetKeys();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("AnimationCurveBindings::GetHashCode", HasExplicitThis = true, IsThreadSafe = true)]
	public override extern int GetHashCode();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	[FreeFunction("AnimationCurveBindings::SmoothTangents", HasExplicitThis = true, IsThreadSafe = true)]
	public extern void SmoothTangents(int index, float weight);

	public static AnimationCurve Constant(float timeStart, float timeEnd, float value)
	{
		return Linear(timeStart, value, timeEnd, value);
	}

	public static AnimationCurve Linear(float timeStart, float valueStart, float timeEnd, float valueEnd)
	{
		if (timeStart == timeEnd)
		{
			Keyframe keyframe = new Keyframe(timeStart, valueStart);
			return new AnimationCurve(keyframe);
		}
		float num = (valueEnd - valueStart) / (timeEnd - timeStart);
		Keyframe[] array = new Keyframe[2]
		{
			new Keyframe(timeStart, valueStart, 0f, num),
			new Keyframe(timeEnd, valueEnd, num, 0f)
		};
		return new AnimationCurve(array);
	}

	public static AnimationCurve EaseInOut(float timeStart, float valueStart, float timeEnd, float valueEnd)
	{
		if (timeStart == timeEnd)
		{
			Keyframe keyframe = new Keyframe(timeStart, valueStart);
			return new AnimationCurve(keyframe);
		}
		Keyframe[] array = new Keyframe[2]
		{
			new Keyframe(timeStart, valueStart, 0f, 0f),
			new Keyframe(timeEnd, valueEnd, 0f, 0f)
		};
		return new AnimationCurve(array);
	}

	public AnimationCurve(params Keyframe[] keys)
	{
		m_Ptr = Internal_Create(keys);
	}

	[RequiredByNativeCode]
	public AnimationCurve()
	{
		m_Ptr = Internal_Create(null);
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return false;
		}
		if (this == o)
		{
			return true;
		}
		return o.GetType() == GetType() && Equals((AnimationCurve)o);
	}

	public bool Equals(AnimationCurve other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		return m_Ptr.Equals(other.m_Ptr) || Internal_Equals(other.m_Ptr);
	}

	public void CopyFrom(AnimationCurve other)
	{
		Internal_CopyFrom(other.m_Ptr);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern int AddKey_Internal_Injected(ref Keyframe key);

	[MethodImpl((MethodImplOptions)4096)]
	private extern int MoveKey_Injected(int index, ref Keyframe key);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetKey_Injected(int index, out Keyframe ret);
}
