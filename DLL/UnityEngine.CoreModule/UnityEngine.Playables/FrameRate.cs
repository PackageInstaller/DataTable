using System;
using System.Globalization;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[UsedByNativeCode("FrameRate")]
[NativeHeader("Runtime/Director/Core/FrameRate.h")]
internal struct FrameRate : IEquatable<FrameRate>
{
	[Ignore]
	public static readonly FrameRate k_24Fps = new FrameRate(24u);

	[Ignore]
	public static readonly FrameRate k_23_976Fps = new FrameRate(24u, drop: true);

	[Ignore]
	public static readonly FrameRate k_25Fps = new FrameRate(25u);

	[Ignore]
	public static readonly FrameRate k_30Fps = new FrameRate(30u);

	[Ignore]
	public static readonly FrameRate k_29_97Fps = new FrameRate(30u, drop: true);

	[Ignore]
	public static readonly FrameRate k_50Fps = new FrameRate(50u);

	[Ignore]
	public static readonly FrameRate k_60Fps = new FrameRate(60u);

	[Ignore]
	public static readonly FrameRate k_59_94Fps = new FrameRate(60u, drop: true);

	[SerializeField]
	private int m_Rate;

	public bool dropFrame => m_Rate < 0;

	public double rate => dropFrame ? ((double)(-m_Rate) * 0.999000999000999) : ((double)m_Rate);

	public FrameRate(uint frameRate = 0u, bool drop = false)
	{
		m_Rate = ((!drop) ? 1 : (-1)) * (int)frameRate;
	}

	public bool IsValid()
	{
		return m_Rate != 0;
	}

	public bool Equals(FrameRate other)
	{
		return m_Rate == other.m_Rate;
	}

	public override bool Equals(object obj)
	{
		return obj is FrameRate && Equals((FrameRate)obj);
	}

	public static bool operator ==(FrameRate a, FrameRate b)
	{
		return a.Equals(b);
	}

	public override int GetHashCode()
	{
		return m_Rate;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (string.IsNullOrEmpty(format))
		{
			format = (dropFrame ? "F2" : "F0");
		}
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("{0} Fps", new object[1] { rate.ToString(format, formatProvider) });
	}

	internal static FrameRate DoubleToFrameRate(double framerate)
	{
		uint num = (uint)Math.Ceiling(framerate);
		if (num == 0)
		{
			return new FrameRate(1u);
		}
		FrameRate result = new FrameRate(num, drop: true);
		if (Math.Abs(framerate - result.rate) < Math.Abs(framerate - (double)num))
		{
			return result;
		}
		return new FrameRate(num);
	}
}
