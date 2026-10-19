using System;

namespace UnityEngine.UI;

[Serializable]
public struct Navigation : IEquatable<Navigation>
{
	[Flags]
	public enum Mode
	{
		None = 0,
		Horizontal = 1,
		Vertical = 2,
		Automatic = Horizontal | Vertical,
		Explicit = 4
	}

	[SerializeField]
	private Mode m_Mode;

	[SerializeField]
	[Tooltip("Enables navigation to wrap around from last to first or first to last element. Does not work for automatic grid navigation")]
	private bool m_WrapAround;

	[SerializeField]
	private Selectable m_SelectOnUp;

	[SerializeField]
	private Selectable m_SelectOnDown;

	[SerializeField]
	private Selectable m_SelectOnLeft;

	[SerializeField]
	private Selectable m_SelectOnRight;

	public Mode mode
	{
		get
		{
			return m_Mode;
		}
		set
		{
			m_Mode = value;
		}
	}

	public bool wrapAround
	{
		get
		{
			return m_WrapAround;
		}
		set
		{
			m_WrapAround = value;
		}
	}

	public Selectable selectOnUp
	{
		get
		{
			return m_SelectOnUp;
		}
		set
		{
			m_SelectOnUp = value;
		}
	}

	public Selectable selectOnDown
	{
		get
		{
			return m_SelectOnDown;
		}
		set
		{
			m_SelectOnDown = value;
		}
	}

	public Selectable selectOnLeft
	{
		get
		{
			return m_SelectOnLeft;
		}
		set
		{
			m_SelectOnLeft = value;
		}
	}

	public Selectable selectOnRight
	{
		get
		{
			return m_SelectOnRight;
		}
		set
		{
			m_SelectOnRight = value;
		}
	}

	public static Navigation defaultNavigation => new Navigation
	{
		m_Mode = Mode.Automatic,
		m_WrapAround = false
	};

	public bool Equals(Navigation other)
	{
		if (mode == other.mode && selectOnUp == other.selectOnUp && selectOnDown == other.selectOnDown && selectOnLeft == other.selectOnLeft)
		{
			return selectOnRight == other.selectOnRight;
		}
		return false;
	}
}
