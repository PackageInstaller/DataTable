using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Explicit)]
[UsedByNativeCode]
public struct Color32(byte r, byte g, byte b, byte a) : IFormattable
{
	[FieldOffset(0)]
	[Ignore(DoesNotContributeToSize = true)]
	private int rgba = 0;

	[FieldOffset(0)]
	public byte r = r;

	[FieldOffset(1)]
	public byte g = g;

	[FieldOffset(2)]
	public byte b = b;

	[FieldOffset(3)]
	public byte a = a;

	public byte this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return index switch
			{
				0 => r, 
				1 => g, 
				2 => b, 
				3 => a, 
				_ => throw new IndexOutOfRangeException("Invalid Color32 index(" + index + ")!"), 
			};
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			switch (index)
			{
			case 0:
				r = value;
				break;
			case 1:
				g = value;
				break;
			case 2:
				b = value;
				break;
			case 3:
				a = value;
				break;
			default:
				throw new IndexOutOfRangeException("Invalid Color32 index(" + index + ")!");
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Color32(Color c)
	{
		return new Color32((byte)Mathf.Round(Mathf.Clamp01(c.r) * 255f), (byte)Mathf.Round(Mathf.Clamp01(c.g) * 255f), (byte)Mathf.Round(Mathf.Clamp01(c.b) * 255f), (byte)Mathf.Round(Mathf.Clamp01(c.a) * 255f));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Color(Color32 c)
	{
		return new Color((float)(int)c.r / 255f, (float)(int)c.g / 255f, (float)(int)c.b / 255f, (float)(int)c.a / 255f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color32 Lerp(Color32 a, Color32 b, float t)
	{
		t = Mathf.Clamp01(t);
		return new Color32((byte)((float)(int)a.r + (float)(b.r - a.r) * t), (byte)((float)(int)a.g + (float)(b.g - a.g) * t), (byte)((float)(int)a.b + (float)(b.b - a.b) * t), (byte)((float)(int)a.a + (float)(b.a - a.a) * t));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color32 LerpUnclamped(Color32 a, Color32 b, float t)
	{
		return new Color32((byte)((float)(int)a.r + (float)(b.r - a.r) * t), (byte)((float)(int)a.g + (float)(b.g - a.g) * t), (byte)((float)(int)a.b + (float)(b.b - a.b) * t), (byte)((float)(int)a.a + (float)(b.a - a.a) * t));
	}

	[MethodImpl((MethodImplOptions)256)]
	[VisibleToOtherModules]
	internal bool InternalEquals(Color32 other)
	{
		return rgba == other.rgba;
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
		return UnityString.Format("RGBA({0}, {1}, {2}, {3})", new object[4]
		{
			r.ToString(format, formatProvider),
			g.ToString(format, formatProvider),
			b.ToString(format, formatProvider),
			a.ToString(format, formatProvider)
		});
	}
}
