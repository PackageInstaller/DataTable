using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[UsedByNativeCode]
[NativeHeader("Modules/IMGUI/GUIStyle.h")]
public class RectOffset : IFormattable
{
	[NonSerialized]
	[VisibleToOtherModules(new string[] { "UnityEngine.IMGUIModule" })]
	internal IntPtr m_Ptr;

	private readonly object m_SourceStyle;

	[NativeProperty(/*Could not decode attribute arguments.*/)]
	public extern int left
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty(/*Could not decode attribute arguments.*/)]
	public extern int right
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty(/*Could not decode attribute arguments.*/)]
	public extern int top
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty(/*Could not decode attribute arguments.*/)]
	public extern int bottom
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int horizontal
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int vertical
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	private static extern IntPtr InternalCreate();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	private static extern void InternalDestroy(IntPtr ptr);

	public Rect Add(Rect rect)
	{
		Add_Injected(ref rect, out var ret);
		return ret;
	}

	public Rect Remove(Rect rect)
	{
		Remove_Injected(ref rect, out var ret);
		return ret;
	}

	public RectOffset()
	{
		m_Ptr = InternalCreate();
	}

	[VisibleToOtherModules(new string[] { "UnityEngine.IMGUIModule" })]
	internal RectOffset(object sourceStyle, IntPtr source)
	{
		m_SourceStyle = sourceStyle;
		m_Ptr = source;
	}

	~RectOffset()
	{
		if (m_SourceStyle == null)
		{
			Destroy();
		}
	}

	public RectOffset(int left, int right, int top, int bottom)
	{
		m_Ptr = InternalCreate();
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("RectOffset (l:{0} r:{1} t:{2} b:{3})", new object[4]
		{
			left.ToString(format, formatProvider),
			right.ToString(format, formatProvider),
			top.ToString(format, formatProvider),
			bottom.ToString(format, formatProvider)
		});
	}

	private void Destroy()
	{
		if (m_Ptr != IntPtr.Zero)
		{
			InternalDestroy(m_Ptr);
			m_Ptr = IntPtr.Zero;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Add_Injected(ref Rect rect, out Rect ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Remove_Injected(ref Rect rect, out Rect ret);
}
