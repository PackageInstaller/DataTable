using System;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.GlobalIllumination;

public struct LinearColor
{
	private float m_red;

	private float m_green;

	private float m_blue;

	private float m_intensity;

	public float red
	{
		get
		{
			return m_red;
		}
		set
		{
			if (value < 0f || value > 1f)
			{
				throw new ArgumentOutOfRangeException("Red color (" + value + ") must be in range [0;1].");
			}
			m_red = value;
		}
	}

	public float green
	{
		get
		{
			return m_green;
		}
		set
		{
			if (value < 0f || value > 1f)
			{
				throw new ArgumentOutOfRangeException("Green color (" + value + ") must be in range [0;1].");
			}
			m_green = value;
		}
	}

	public float blue
	{
		get
		{
			return m_blue;
		}
		set
		{
			if (value < 0f || value > 1f)
			{
				throw new ArgumentOutOfRangeException("Blue color (" + value + ") must be in range [0;1].");
			}
			m_blue = value;
		}
	}

	public static LinearColor Convert(Color color, float intensity)
	{
		Color color2 = (GraphicsSettings.lightsUseLinearIntensity ? color.linear.RGBMultiplied(intensity) : color.RGBMultiplied(intensity).linear);
		float maxColorComponent = color2.maxColorComponent;
		if (color2.r < 0f || color2.g < 0f || color2.b < 0f)
		{
			throw new ArgumentOutOfRangeException("The input color to be converted must not contain negative values (red: " + color2.r + ", green: " + color2.g + ", blue: " + color2.b + ").");
		}
		if (maxColorComponent <= 1E-20f)
		{
			return Black();
		}
		float num = 1f / color2.maxColorComponent;
		LinearColor result = default(LinearColor);
		result.m_red = color2.r * num;
		result.m_green = color2.g * num;
		result.m_blue = color2.b * num;
		result.m_intensity = maxColorComponent;
		return result;
	}

	public static LinearColor Black()
	{
		LinearColor result = default(LinearColor);
		result.m_red = (result.m_green = (result.m_blue = (result.m_intensity = 0f)));
		return result;
	}
}
