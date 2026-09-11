using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Export/Math/Gradient.bindings.h")]
public class Gradient : IEquatable<Gradient>
{
	internal IntPtr m_Ptr;

	public extern GradientColorKey[] colorKeys
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Gradient_Bindings::GetColorKeys", IsThreadSafe = true, HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Gradient_Bindings::SetColorKeys", IsThreadSafe = true, HasExplicitThis = true)]
		[param: Unmarshalled]
		set;
	}

	public extern GradientAlphaKey[] alphaKeys
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Gradient_Bindings::GetAlphaKeys", IsThreadSafe = true, HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Gradient_Bindings::SetAlphaKeys", IsThreadSafe = true, HasExplicitThis = true)]
		[param: Unmarshalled]
		set;
	}

	[NativeProperty(IsThreadSafe = true)]
	public extern GradientMode mode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty(IsThreadSafe = true)]
	public extern ColorSpace colorSpace
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Gradient_Bindings::Init", IsThreadSafe = true)]
	private static extern IntPtr Init();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Gradient_Bindings::Cleanup", IsThreadSafe = true, HasExplicitThis = true)]
	private extern void Cleanup();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Gradient_Bindings::Internal_Equals", IsThreadSafe = true, HasExplicitThis = true)]
	private extern bool Internal_Equals(IntPtr other);

	[RequiredByNativeCode]
	public Gradient()
	{
		m_Ptr = Init();
	}

	~Gradient()
	{
		Cleanup();
	}

	[FreeFunction(Name = "Gradient_Bindings::Evaluate", IsThreadSafe = true, HasExplicitThis = true)]
	public Color Evaluate(float time)
	{
		Evaluate_Injected(time, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Gradient_Bindings::SetKeys", IsThreadSafe = true, HasExplicitThis = true)]
	public extern void SetKeys([Unmarshalled] GradientColorKey[] colorKeys, [Unmarshalled] GradientAlphaKey[] alphaKeys);

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
		if (o.GetType() != GetType())
		{
			return false;
		}
		return Equals((Gradient)o);
	}

	public bool Equals(Gradient other)
	{
		if (other == null)
		{
			return false;
		}
		if (this == other)
		{
			return true;
		}
		if (m_Ptr.Equals(other.m_Ptr))
		{
			return true;
		}
		return Internal_Equals(other.m_Ptr);
	}

	public override int GetHashCode()
	{
		return m_Ptr.GetHashCode();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Evaluate_Injected(float time, out Color ret);
}
