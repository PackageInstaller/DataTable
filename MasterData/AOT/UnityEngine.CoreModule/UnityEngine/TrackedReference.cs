using System;
using System.Runtime.InteropServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[UsedByNativeCode]
public class TrackedReference
{
	internal IntPtr m_Ptr;

	protected TrackedReference()
	{
	}

	public static bool operator ==(TrackedReference x, TrackedReference y)
	{
		if ((object)y == null && (object)x == null)
		{
			return true;
		}
		if ((object)y == null)
		{
			return x.m_Ptr == IntPtr.Zero;
		}
		if ((object)x == null)
		{
			return y.m_Ptr == IntPtr.Zero;
		}
		return x.m_Ptr == y.m_Ptr;
	}

	public static bool operator !=(TrackedReference x, TrackedReference y)
	{
		return !(x == y);
	}

	public override bool Equals(object o)
	{
		return o as TrackedReference == this;
	}

	public override int GetHashCode()
	{
		return (int)m_Ptr;
	}

	public static implicit operator bool(TrackedReference exists)
	{
		return exists != null;
	}
}
