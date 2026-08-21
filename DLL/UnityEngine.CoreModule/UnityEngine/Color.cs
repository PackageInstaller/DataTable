using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeClass("ColorRGBAf")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeHeader("Runtime/Math/Color.h")]
public struct Color : IEquatable<Color>, IFormattable
{
	public float r;

	public float g;

	public float b;

	public float a;

	public static Color red
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(1f, 0f, 0f, 1f);
		}
	}

	public static Color green
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0f, 1f, 0f, 1f);
		}
	}

	public static Color blue
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0f, 0f, 1f, 1f);
		}
	}

	public static Color white
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(1f, 1f, 1f, 1f);
		}
	}

	public static Color black
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0f, 0f, 0f, 1f);
		}
	}

	public static Color yellow
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(1f, 47f / 51f, 0.015686275f, 1f);
		}
	}

	public static Color cyan
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0f, 1f, 1f, 1f);
		}
	}

	public static Color magenta
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(1f, 0f, 1f, 1f);
		}
	}

	public static Color gray
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0.5f, 0.5f, 0.5f, 1f);
		}
	}

	public static Color grey
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0.5f, 0.5f, 0.5f, 1f);
		}
	}

	public static Color clear
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(0f, 0f, 0f, 0f);
		}
	}

	public float grayscale
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return 0.299f * r + 0.587f * g + 0.114f * b;
		}
	}

	public Color linear
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(Mathf.GammaToLinearSpace(r), Mathf.GammaToLinearSpace(g), Mathf.GammaToLinearSpace(b), a);
		}
	}

	public Color gamma
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return new Color(Mathf.LinearToGammaSpace(r), Mathf.LinearToGammaSpace(g), Mathf.LinearToGammaSpace(b), a);
		}
	}

	public float maxColorComponent
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Mathf.Max(Mathf.Max(r, g), b);
		}
	}

	public float this[int index]
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
				_ => throw new IndexOutOfRangeException("Invalid Color index(" + index + ")!"), 
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
				throw new IndexOutOfRangeException("Invalid Color index(" + index + ")!");
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Color(float r, float g, float b, float a)
	{
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Color(float r, float g, float b)
	{
		this.r = r;
		this.g = g;
		this.b = b;
		a = 1f;
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
		if (string.IsNullOrEmpty(format))
		{
			format = "F3";
		}
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

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return ((Vector4)this/*cast due to constrained. prefix*/).GetHashCode();
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Color))
		{
			return false;
		}
		return Equals((Color)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Color other)
	{
		return r.Equals(other.r) && g.Equals(other.g) && b.Equals(other.b) && a.Equals(other.a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator +(Color a, Color b)
	{
		return new Color(a.r + b.r, a.g + b.g, a.b + b.b, a.a + b.a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator -(Color a, Color b)
	{
		return new Color(a.r - b.r, a.g - b.g, a.b - b.b, a.a - b.a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator *(Color a, Color b)
	{
		return new Color(a.r * b.r, a.g * b.g, a.b * b.b, a.a * b.a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator *(Color a, float b)
	{
		return new Color(a.r * b, a.g * b, a.b * b, a.a * b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator *(float b, Color a)
	{
		return new Color(a.r * b, a.g * b, a.b * b, a.a * b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color operator /(Color a, float b)
	{
		return new Color(a.r / b, a.g / b, a.b / b, a.a / b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Color lhs, Color rhs)
	{
		return (Vector4)lhs == (Vector4)rhs;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Color lhs, Color rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color Lerp(Color a, Color b, float t)
	{
		t = Mathf.Clamp01(t);
		return new Color(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t, a.b + (b.b - a.b) * t, a.a + (b.a - a.a) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color LerpUnclamped(Color a, Color b, float t)
	{
		return new Color(a.r + (b.r - a.r) * t, a.g + (b.g - a.g) * t, a.b + (b.b - a.b) * t, a.a + (b.a - a.a) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal Color RGBMultiplied(float multiplier)
	{
		return new Color(r * multiplier, g * multiplier, b * multiplier, a);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal Color AlphaMultiplied(float multiplier)
	{
		return new Color(r, g, b, a * multiplier);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal Color RGBMultiplied(Color multiplier)
	{
		return new Color(r * multiplier.r, g * multiplier.g, b * multiplier.b, a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector4(Color c)
	{
		return new Vector4(c.r, c.g, c.b, c.a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Color(Vector4 v)
	{
		return new Color(v.x, v.y, v.z, v.w);
	}

	public static void RGBToHSV(Color rgbColor, out float H, out float S, out float V)
	{
		if (rgbColor.b > rgbColor.g && rgbColor.b > rgbColor.r)
		{
			RGBToHSVHelper(4f, rgbColor.b, rgbColor.r, rgbColor.g, out H, out S, out V);
		}
		else if (rgbColor.g > rgbColor.r)
		{
			RGBToHSVHelper(2f, rgbColor.g, rgbColor.b, rgbColor.r, out H, out S, out V);
		}
		else
		{
			RGBToHSVHelper(0f, rgbColor.r, rgbColor.g, rgbColor.b, out H, out S, out V);
		}
	}

	private static void RGBToHSVHelper(float offset, float dominantcolor, float colorone, float colortwo, out float H, out float S, out float V)
	{
		V = dominantcolor;
		if (V != 0f)
		{
			float num = 0f;
			num = ((!(colorone > colortwo)) ? colorone : colortwo);
			float num2 = V - num;
			if (num2 != 0f)
			{
				S = num2 / V;
				H = offset + (colorone - colortwo) / num2;
			}
			else
			{
				S = 0f;
				H = offset + (colorone - colortwo);
			}
			H /= 6f;
			if (H < 0f)
			{
				H++;
			}
		}
		else
		{
			S = 0f;
			H = 0f;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Color HSVToRGB(float H, float S, float V)
	{
		return HSVToRGB(H, S, V, hdr: true);
	}

	public static Color HSVToRGB(float H, float S, float V, bool hdr)
	{
		Color result = white;
		if (S == 0f)
		{
			result.r = V;
			result.g = V;
			result.b = V;
		}
		else if (V == 0f)
		{
			result.r = 0f;
			result.g = 0f;
			result.b = 0f;
		}
		else
		{
			result.r = 0f;
			result.g = 0f;
			result.b = 0f;
			float num = H * 6f;
			int num2 = (int)Mathf.Floor(num);
			float num3 = num - (float)num2;
			float num4 = V * (1f - S);
			float num5 = V * (1f - S * num3);
			float num6 = V * (1f - S * (1f - num3));
			switch (num2)
			{
			case 0:
				result.r = V;
				result.g = num6;
				result.b = num4;
				break;
			case 1:
				result.r = num5;
				result.g = V;
				result.b = num4;
				break;
			case 2:
				result.r = num4;
				result.g = V;
				result.b = num6;
				break;
			case 3:
				result.r = num4;
				result.g = num5;
				result.b = V;
				break;
			case 4:
				result.r = num6;
				result.g = num4;
				result.b = V;
				break;
			case 5:
				result.r = V;
				result.g = num4;
				result.b = num5;
				break;
			case 6:
				result.r = V;
				result.g = num6;
				result.b = num4;
				break;
			case -1:
				result.r = V;
				result.g = num4;
				result.b = num5;
				break;
			}
			if (!hdr)
			{
				result.r = Mathf.Clamp(result.r, 0f, 1f);
				result.g = Mathf.Clamp(result.g, 0f, 1f);
				result.b = Mathf.Clamp(result.b, 0f, 1f);
			}
		}
		return result;
	}
}
