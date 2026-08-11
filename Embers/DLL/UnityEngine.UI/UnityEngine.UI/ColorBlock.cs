using System;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[Serializable]
public struct ColorBlock : IEquatable<ColorBlock>
{
	[FormerlySerializedAs("normalColor")]
	[SerializeField]
	private Color m_NormalColor;

	[FormerlySerializedAs("highlightedColor")]
	[SerializeField]
	private Color m_HighlightedColor;

	[SerializeField]
	[FormerlySerializedAs("pressedColor")]
	private Color m_PressedColor;

	[SerializeField]
	[FormerlySerializedAs("m_HighlightedColor")]
	private Color m_SelectedColor;

	[SerializeField]
	[FormerlySerializedAs("disabledColor")]
	private Color m_DisabledColor;

	[Range(1f, 5f)]
	[SerializeField]
	private float m_ColorMultiplier;

	[SerializeField]
	[FormerlySerializedAs("fadeDuration")]
	private float m_FadeDuration;

	public static ColorBlock defaultColorBlock;

	public Color normalColor
	{
		get
		{
			return m_NormalColor;
		}
		set
		{
			m_NormalColor = value;
		}
	}

	public Color highlightedColor
	{
		get
		{
			return m_HighlightedColor;
		}
		set
		{
			m_HighlightedColor = value;
		}
	}

	public Color pressedColor
	{
		get
		{
			return m_PressedColor;
		}
		set
		{
			m_PressedColor = value;
		}
	}

	public Color selectedColor
	{
		get
		{
			return m_SelectedColor;
		}
		set
		{
			m_SelectedColor = value;
		}
	}

	public Color disabledColor
	{
		get
		{
			return m_DisabledColor;
		}
		set
		{
			m_DisabledColor = value;
		}
	}

	public float colorMultiplier
	{
		get
		{
			return m_ColorMultiplier;
		}
		set
		{
			m_ColorMultiplier = value;
		}
	}

	public float fadeDuration
	{
		get
		{
			return m_FadeDuration;
		}
		set
		{
			m_FadeDuration = value;
		}
	}

	static ColorBlock()
	{
		defaultColorBlock = new ColorBlock
		{
			m_NormalColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue),
			m_HighlightedColor = new Color32(245, 245, 245, byte.MaxValue),
			m_PressedColor = new Color32(200, 200, 200, byte.MaxValue),
			m_SelectedColor = new Color32(245, 245, 245, byte.MaxValue),
			m_DisabledColor = new Color32(200, 200, 200, 128),
			colorMultiplier = 1f,
			fadeDuration = 0.1f
		};
	}

	public override bool Equals(object obj)
	{
		if (!(obj is ColorBlock))
		{
			return false;
		}
		return Equals((ColorBlock)obj);
	}

	public bool Equals(ColorBlock other)
	{
		if (normalColor == other.normalColor && highlightedColor == other.highlightedColor && pressedColor == other.pressedColor && selectedColor == other.selectedColor && disabledColor == other.disabledColor && colorMultiplier == other.colorMultiplier)
		{
			return fadeDuration == other.fadeDuration;
		}
		return false;
	}

	public static bool operator ==(ColorBlock point1, ColorBlock point2)
	{
		return point1.Equals(point2);
	}

	public static bool operator !=(ColorBlock point1, ColorBlock point2)
	{
		return !point1.Equals(point2);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
