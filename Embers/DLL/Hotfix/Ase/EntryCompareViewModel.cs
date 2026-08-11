using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class EntryCompareViewModel : OptionBase
{
	private bool _visible = true;

	private List<EntryChangeData> _entryChangeList = new List<EntryChangeData>();

	private InteractionRequest _refreshRst = new InteractionRequest();

	private EntryCompareItemData _selectItemData;

	private bool _isRock;

	public bool IsRock => _isRock;

	public EntryCompareItemData SelectItemData => _selectItemData;

	public bool Visible
	{
		get
		{
			return _visible;
		}
		set
		{
			Set(ref _visible, value, "Visible");
		}
	}

	public List<EntryChangeData> EntryChangeList => _entryChangeList;

	public InteractionRequest RefreshRst => _refreshRst;

	public EntryCompareViewModel()
	{
	}

	public EntryCompareViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is EntryCompareItemData itemSelected)
		{
			SetItemSelected(itemSelected);
		}
	}

	public EntryCompareViewModel(OptionBase parent, List<EntryData> oriEntryList, List<EntryData> curEntryList)
	{
		base.parent = parent;
		GetEntryChangeDataList(oriEntryList, curEntryList);
	}

	public EntryCompareViewModel(OptionBase parent, List<EntryData> oriEntryList, List<EntryData> removeEntryList, List<EntryData> addEntryList)
	{
		base.parent = parent;
		GetEntryChangeDataList(oriEntryList, removeEntryList, addEntryList);
	}

	public void Refresh(bool isRock, List<EntryData> oriEntryList, List<EntryData> removeEntryList, List<EntryData> addEntryList)
	{
		_isRock = isRock;
		GetEntryChangeDataList(oriEntryList, removeEntryList, addEntryList);
		_refreshRst.Raise();
	}

	private void GetEntryChangeDataList(List<EntryData> oriEntryList, List<EntryData> curEntryList)
	{
		_entryChangeList.Clear();
		if (curEntryList == null)
		{
			return;
		}
		if (oriEntryList == null)
		{
			curEntryList.ForEach(delegate(EntryData p)
			{
				_entryChangeList.Add(new EntryChangeData(p, 0, p.CurLevel));
			});
			return;
		}
		foreach (EntryData curEntry in curEntryList)
		{
			int oriLevel = oriEntryList.Find((EntryData p) => p.DrEntry?.EntryId == curEntry.DrEntry?.EntryId)?.CurLevel ?? 0;
			_entryChangeList.Add(new EntryChangeData(curEntry, oriLevel, curEntry.CurLevel));
		}
		Sort();
		LogEntryData();
	}

	private void GetEntryChangeDataList(List<EntryData> oriEntryList, List<EntryData> removeEntryList, List<EntryData> addEntryList)
	{
		_entryChangeList.Clear();
		if (oriEntryList == null)
		{
			addEntryList?.ForEach(delegate(EntryData p)
			{
				_entryChangeList.Add(new EntryChangeData(p, 0, p.CurLevel));
			});
			return;
		}
		if (removeEntryList != null)
		{
			foreach (EntryData removeEntry in removeEntryList)
			{
				if (_isRock && removeEntry.IsFixed)
				{
					_entryChangeList.Add(new EntryChangeData(removeEntry, removeEntry.CurLevel, 0));
					continue;
				}
				EntryData entryData = oriEntryList.Find((EntryData p) => p.DrEntry?.EntryId == removeEntry.DrEntry?.EntryId);
				int num = entryData?.CurLevel ?? 0;
				_entryChangeList.Add(new EntryChangeData(entryData ?? removeEntry, num, num - removeEntry.CurLevel));
			}
		}
		if (addEntryList != null)
		{
			foreach (EntryData addEntry in addEntryList)
			{
				if (_isRock && addEntry.IsFixed)
				{
					_entryChangeList.Add(new EntryChangeData(addEntry, 0, addEntry.CurLevel));
					continue;
				}
				int num2 = _entryChangeList.FindIndex((EntryChangeData p) => p.EntryData?.DrEntry.EntryId == addEntry.DrEntry?.EntryId);
				if (num2 >= 0)
				{
					_entryChangeList[num2].CurLevel += addEntry.CurLevel;
					if (_entryChangeList[num2].CurLevel == _entryChangeList[num2].OriLevel)
					{
						_entryChangeList.RemoveAt(num2);
					}
				}
				else
				{
					EntryData entryData2 = oriEntryList.Find((EntryData p) => p.DrEntry?.EntryId == addEntry.DrEntry?.EntryId);
					int num3 = entryData2?.CurLevel ?? 0;
					_entryChangeList.Add(new EntryChangeData(entryData2 ?? addEntry, num3, num3 + addEntry.CurLevel));
				}
			}
		}
		Sort();
		LogEntryData();
	}

	private void Sort()
	{
		_entryChangeList?.Sort(delegate(EntryChangeData a, EntryChangeData b)
		{
			int num = ((a.ChangeEnum != EntryChangeEnum.New) ? 1 : (-1));
			int value = ((b.ChangeEnum != EntryChangeEnum.New) ? 1 : (-1));
			int num2 = ((a.ChangeEnum != EntryChangeEnum.Add) ? 1 : (-1));
			int value2 = ((b.ChangeEnum != EntryChangeEnum.Add) ? 1 : (-1));
			int num3 = ((a.ChangeEnum != EntryChangeEnum.Reduce) ? 1 : (-1));
			int value3 = ((b.ChangeEnum != EntryChangeEnum.Reduce) ? 1 : (-1));
			int num4 = ((a.ChangeEnum != EntryChangeEnum.Disappear) ? 1 : (-1));
			int value4 = ((b.ChangeEnum != EntryChangeEnum.Disappear) ? 1 : (-1));
			return num.CompareTo(value) * 10000 + num2.CompareTo(value2) * 1000 + num3.CompareTo(value3) * 100 + num4.CompareTo(value4) * 10 - a.EntryData.DrEntry.EntryId.CompareTo(b.EntryData.DrEntry.EntryId);
		});
	}

	private void SetItemSelected(EntryCompareItemData itemData)
	{
		if (_selectItemData != null)
		{
			_selectItemData.IsSelected = false;
		}
		_selectItemData = itemData;
		_selectItemData.IsSelected = true;
		parent?.ItemOnClick(this);
	}

	public void ClearSelected()
	{
		if (_selectItemData != null)
		{
			_selectItemData.IsSelected = false;
		}
		_selectItemData = null;
	}

	private void LogEntryData()
	{
	}
}
