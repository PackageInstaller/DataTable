using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class EntryUpgradeItemData : OptionBase
{
	private string _name;

	private Color _color;

	private string _showValue1;

	private string _showValue2;

	private bool _isNew;

	private InteractionRequest openEntryPanelRequest = new InteractionRequest();

	public EntryData EntryData;

	private bool isSelect;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public string Name => _name;

	public string ShowValue1 => _showValue1;

	public string ShowValue2 => _showValue2;

	public Color Color => _color;

	public bool IsNew => _isNew;

	public InteractionRequest OpenEntryPanelRequest => openEntryPanelRequest;

	public EntryUpgradeItemData(OptionBase parent, EntryData entryData, float value)
	{
		base.parent = parent;
		_name = entryData.DrEntry.Name;
		_showValue1 = "Lv." + entryData.DrEntry.Level;
		_showValue2 = "Lv." + value;
		_color = EntryItemData.GetColor(entryData.DrEntry.EntryColor);
		_isNew = false;
		EntryData = entryData;
	}

	public EntryUpgradeItemData(EntryData entryData, float value1, float value2)
	{
		_name = entryData.DrEntry.Name;
		_showValue1 = "Lv." + value1;
		_showValue2 = "Lv." + value2;
		_color = EntryItemData.GetColor(entryData.DrEntry.EntryColor);
		_isNew = false;
		EntryData = entryData;
	}

	public EntryUpgradeItemData(EntryData entryData, bool isNew)
	{
		_isNew = isNew;
		_name = entryData.DrEntry.Name;
		_showValue1 = "Lv." + entryData.DrEntry.Level;
		_showValue2 = "";
		_color = EntryItemData.GetColor(entryData.DrEntry.EntryColor);
		EntryData = entryData;
	}

	public void OpenPanelRequest()
	{
		openEntryPanelRequest.Raise();
	}

	public void OnShowEntryPanel(EntryUpgradeItem item)
	{
		if (parent != null)
		{
			parent.ItemOnClick(new OptionArg(item, "OnShowEntryPanel"));
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
