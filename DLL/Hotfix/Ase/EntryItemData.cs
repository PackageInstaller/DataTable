using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class EntryItemData : OptionBase
{
	private EntryData _entryData;

	private string _text;

	private bool _isEntry;

	private string entryName;

	private string _level;

	private bool isSelect;

	private bool isLock;

	private int allLevel;

	private string iconPath;

	public bool IsMainEntry;

	private bool isEmpty;

	public int Type;

	private InteractionRequest openEntryPanelRequest = new InteractionRequest();

	private InteractionRequest<int> playEffectRequest = new InteractionRequest<int>();

	private InteractionRequest closeEffectRequest = new InteractionRequest();

	private int effectIndex;

	public EntryData EntryData => _entryData;

	public string Text
	{
		get
		{
			return _text;
		}
		private set
		{
			Set(ref _text, value, "Text");
		}
	}

	public bool IsEntry
	{
		get
		{
			return _isEntry;
		}
		private set
		{
			Set(ref _isEntry, value, "IsEntry");
		}
	}

	public string EntryName
	{
		get
		{
			return entryName;
		}
		private set
		{
			Set(ref entryName, value, "EntryName");
		}
	}

	public string Level
	{
		get
		{
			return _level;
		}
		set
		{
			Set(ref _level, value, "Level");
		}
	}

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

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public int AllLevel
	{
		get
		{
			return allLevel;
		}
		set
		{
			Set(ref allLevel, value, "AllLevel");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		private set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public int EffectIndex => effectIndex;

	public bool IsEmpty => isEmpty;

	public InteractionRequest OpenEntryPanelRequest => openEntryPanelRequest;

	public InteractionRequest<int> PlayEffectRequest => playEffectRequest;

	public InteractionRequest CloseEffectRequest => closeEffectRequest;

	public EntryItemData()
	{
		isEmpty = true;
	}

	public EntryItemData(OptionBase parent, string text)
	{
		base.parent = parent;
		IsLock = true;
		Text = text;
		IsEntry = false;
		IconPath = "empty";
	}

	public EntryItemData(OptionBase parent, EntryData entryData)
	{
		base.parent = parent;
		_entryData = entryData;
		Text = string.Empty;
		IsEntry = true;
		EntryName = entryData.DrEntry.Name;
		Level = $"Lv.{entryData.CurLevel}";
		AllLevel = entryData.CurLevel;
		IconPath = entryData.IconPath;
	}

	public EntryItemData(EntryData entryData)
	{
		_entryData = entryData;
		Text = string.Empty;
		IsEntry = true;
		if (entryData != null)
		{
			EntryName = entryData.DrEntry?.Name;
			Level = $"Lv.{entryData.CurLevel}";
			AllLevel = entryData.CurLevel;
			IconPath = entryData.IconPath;
		}
	}

	public void SetEntryTextType(int index)
	{
		if (index == 1)
		{
			EntryName = "<color=#FFFFFF><size=36>" + EntryName + "</size></color>";
			Level = "";
		}
	}

	public void SetEffectIndex(int value)
	{
		effectIndex = value;
	}

	public void PlayEffect()
	{
		playEffectRequest.Raise(effectIndex);
		effectIndex = 0;
	}

	public void CloseEffect()
	{
		closeEffectRequest.Raise();
	}

	public void SetLevel(int value)
	{
		Level = $"Lv.{value}";
	}

	public static Color GetColor(int index)
	{
		string htmlString = "";
		switch (index)
		{
		case 1:
			htmlString = "#e7b6b1";
			break;
		case 2:
			htmlString = "#bbcab2";
			break;
		case 3:
			htmlString = "#b8cde7";
			break;
		case 4:
			htmlString = "#f493ff";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public void OnShowEntryPanel(EntryItem item)
	{
		if (IsEntry)
		{
			parent?.ItemOnClick(new OptionArg(item, "OnShowEntryPanel"));
		}
	}

	public void OpenPanelRequest()
	{
		openEntryPanelRequest.Raise();
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
