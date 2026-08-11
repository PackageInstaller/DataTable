using System;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[Serializable]
public struct SpriteState : IEquatable<SpriteState>
{
	[SerializeField]
	private Sprite m_HighlightedSprite;

	[SerializeField]
	private Sprite m_PressedSprite;

	[FormerlySerializedAs("m_HighlightedSprite")]
	[SerializeField]
	private Sprite m_SelectedSprite;

	[SerializeField]
	private Sprite m_DisabledSprite;

	public Sprite highlightedSprite
	{
		get
		{
			return m_HighlightedSprite;
		}
		set
		{
			m_HighlightedSprite = value;
		}
	}

	public Sprite pressedSprite
	{
		get
		{
			return m_PressedSprite;
		}
		set
		{
			m_PressedSprite = value;
		}
	}

	public Sprite selectedSprite
	{
		get
		{
			return m_SelectedSprite;
		}
		set
		{
			m_SelectedSprite = value;
		}
	}

	public Sprite disabledSprite
	{
		get
		{
			return m_DisabledSprite;
		}
		set
		{
			m_DisabledSprite = value;
		}
	}

	public bool Equals(SpriteState other)
	{
		if (highlightedSprite == other.highlightedSprite && pressedSprite == other.pressedSprite && selectedSprite == other.selectedSprite)
		{
			return disabledSprite == other.disabledSprite;
		}
		return false;
	}
}
