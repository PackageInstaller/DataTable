using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ArmourScreenItemData : OptionBase
{
	private string _showText;

	private bool _isSelected;

	private InteractionRequest _closeRequest;

	private List<ArmourScreenTagItemData> _armourScreenTagItemData;

	public string ShowText => _showText;

	public List<ArmourScreenTagItemData> ArmourScreenTagItemData => _armourScreenTagItemData;

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public InteractionRequest CloseRequest => _closeRequest;

	public ArmourScreenItemData(OptionBase parent, int type, List<ArmourScreenTagItemData> armourScreenTagItemData)
	{
		base.parent = parent;
		_showText = LoadName(type);
		_armourScreenTagItemData = armourScreenTagItemData;
		_isSelected = false;
		_closeRequest = new InteractionRequest();
	}

	private string LoadName(int type)
	{
		string result = "";
		switch (type)
		{
		case 1:
			result = "属性";
			break;
		case 2:
			result = "固定词条";
			break;
		case 3:
			result = "其他词条";
			break;
		}
		return result;
	}

	public void ButtonOnclick()
	{
		IsSelected = !IsSelected;
		parent.ItemOnClick(this);
	}

	public void CloseButton()
	{
		if (IsSelected)
		{
			CloseRequest.Raise();
		}
	}
}
