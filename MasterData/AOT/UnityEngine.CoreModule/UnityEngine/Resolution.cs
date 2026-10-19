using System;
using System.ComponentModel;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
public struct Resolution
{
	private int m_Width;

	private int m_Height;

	private RefreshRate m_RefreshRate;

	public int width
	{
		get
		{
			return m_Width;
		}
		set
		{
			m_Width = value;
		}
	}

	public int height
	{
		get
		{
			return m_Height;
		}
		set
		{
			m_Height = value;
		}
	}

	public RefreshRate refreshRateRatio
	{
		get
		{
			return m_RefreshRate;
		}
		set
		{
			m_RefreshRate = value;
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Resolution.refreshRate is obsolete. Use refreshRateRatio instead.", false)]
	public int refreshRate
	{
		get
		{
			return (int)Math.Round(m_RefreshRate.value);
		}
		set
		{
			m_RefreshRate.numerator = (uint)value;
			m_RefreshRate.denominator = 1u;
		}
	}

	public override string ToString()
	{
		return UnityString.Format("{0} x {1} @ {2}Hz", m_Width, m_Height, m_RefreshRate);
	}
}
