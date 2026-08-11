using System.Collections.Generic;

namespace Ase;

public class ArmourCustomGroupData : OptionBase
{
	private ArmourCustomMode _mode;

	private ArmourCustomType _type;

	private int _curSelCount;

	private int _maxSelCount = 1;

	private List<ArmourCustomOptionItemData> _optionList = new List<ArmourCustomOptionItemData>();

	private string _title;

	public string Title
	{
		get
		{
			return _title;
		}
		set
		{
			Set(ref _title, value, "Title");
		}
	}

	public ArmourCustomMode Mode
	{
		get
		{
			return _mode;
		}
		set
		{
			Set(ref _mode, value, "Mode");
		}
	}

	public ArmourCustomType Type
	{
		get
		{
			return _type;
		}
		set
		{
			Set(ref _type, value, "Type");
		}
	}

	public int CurSelCount
	{
		get
		{
			return _curSelCount;
		}
		set
		{
			Set(ref _curSelCount, value, "CurSelCount");
		}
	}

	public int MaxSelCount
	{
		get
		{
			return _maxSelCount;
		}
		set
		{
			Set(ref _maxSelCount, value, "MaxSelCount");
		}
	}

	public List<ArmourCustomOptionItemData> OptionList => _optionList;

	public ArmourCustomGroupData()
	{
	}

	public ArmourCustomGroupData(OptionBase parent, ArmourCustomMode mode, ArmourCustomType type, int maxSelCount, List<int> optionIdList)
	{
		base.parent = parent;
		Mode = mode;
		Type = type;
		MaxSelCount = maxSelCount;
		Refresh(optionIdList);
	}

	private void Refresh(List<int> optionIdList)
	{
		RefreshTitle();
		_optionList.Clear();
		if (optionIdList == null)
		{
			return;
		}
		foreach (int optionId in optionIdList)
		{
			_optionList.Add(new ArmourCustomOptionItemData(this, Mode, Type, optionId));
		}
	}

	private void RefreshTitle()
	{
		Title = ArmourCustomDefinition.GetGroupTitle(Mode, Type, CurSelCount, MaxSelCount);
	}

	private void OnOptionClick(ArmourCustomOptionItemData itemData)
	{
		if (itemData.Selected)
		{
			itemData.Selected = false;
			CurSelCount = ((CurSelCount > 0) ? (CurSelCount - 1) : 0);
			RefreshTitle();
			parent?.ItemOnClick(this);
		}
		else if (CurSelCount < MaxSelCount)
		{
			itemData.Selected = true;
			CurSelCount++;
			RefreshTitle();
			parent?.ItemOnClick(this);
		}
		else
		{
			Toast.ShowInfo("超出可选上限");
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ArmourCustomOptionItemData itemData)
		{
			OnOptionClick(itemData);
		}
	}
}
