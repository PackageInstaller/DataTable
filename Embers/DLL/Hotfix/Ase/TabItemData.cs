using GameFramework.Runtime;

namespace Ase;

public class TabItemData : OptionBase
{
	private string _textNormal;

	private string _englishNormal;

	private string _iconNormal = "";

	private string _textSelected;

	private string _englishSelected;

	private string _iconSelected = "";

	private bool _isSelected;

	private bool _red;

	private int _tabIndex;

	private InteractionRequest<bool> _onSelectChangedRst = new InteractionRequest<bool>();

	public InteractionRequest<bool> OnSelectChangedRst => _onSelectChangedRst;

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			if (Set(ref _isSelected, value, "IsSelected"))
			{
				_onSelectChangedRst.Raise(value);
			}
		}
	}

	public string TextNormal
	{
		get
		{
			return _textNormal;
		}
		set
		{
			Set(ref _textNormal, value, "TextNormal");
		}
	}

	public string EnglishNormal
	{
		get
		{
			return _englishNormal;
		}
		set
		{
			Set(ref _englishNormal, value, "EnglishNormal");
		}
	}

	public string IconNormal
	{
		get
		{
			return _iconNormal;
		}
		set
		{
			Set(ref _iconNormal, value, "IconNormal");
		}
	}

	public string TextSelected
	{
		get
		{
			return _textSelected;
		}
		set
		{
			Set(ref _textSelected, value, "TextSelected");
		}
	}

	public string EnglishSelected
	{
		get
		{
			return _englishSelected;
		}
		set
		{
			Set(ref _englishSelected, value, "EnglishSelected");
		}
	}

	public string IconSelected
	{
		get
		{
			return _iconSelected;
		}
		set
		{
			Set(ref _iconSelected, value, "IconSelected");
		}
	}

	public bool Red
	{
		get
		{
			return _red;
		}
		set
		{
			Set(ref _red, value, "Red");
		}
	}

	public int TabIndex
	{
		get
		{
			return _tabIndex;
		}
		private set
		{
			Set(ref _tabIndex, value, "TabIndex");
		}
	}

	public TabItemData()
	{
	}

	public TabItemData(OptionBase parent, int tabIndex)
	{
		base.parent = parent;
		_tabIndex = tabIndex;
		_isSelected = false;
	}

	public void SetTabIndex(int index)
	{
		TabIndex = index;
	}

	public void TabOnClick()
	{
		parent.ItemOnClick(this);
	}

	public virtual void SetSelected(bool selected)
	{
		IsSelected = selected;
	}
}
