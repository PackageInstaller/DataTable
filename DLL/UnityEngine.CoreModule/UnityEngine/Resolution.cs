using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
public struct Resolution
{
	private int m_Width;

	private int m_Height;

	private int m_RefreshRate;

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

	public int refreshRate
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

	public override string ToString()
	{
		return UnityString.Format("{0} x {1} @ {2}Hz", new object[3] { m_Width, m_Height, m_RefreshRate });
	}
}
