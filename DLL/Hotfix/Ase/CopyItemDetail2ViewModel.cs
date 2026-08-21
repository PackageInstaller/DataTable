#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopyItemDetail2ViewModel : OptionBase
{
	private CopyData data;

	private List<int> adItemList;

	private List<ReceiveItemViewModel> dropProps;

	private List<CopyEquipDropItemViewModel> dropDtailProps;

	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private Dictionary<int, List<MonsterInfoData>> monsterInfoDatas;

	private InteractionRequest<EntryItem> showEntryDetailRequest = new InteractionRequest<EntryItem>();

	private CopyBuffItemViewModel2 copyBuffVm = new CopyBuffItemViewModel2();

	private string desc;

	private bool isSingle = true;

	private bool isOpenDrop;

	private bool openDropComplete;

	public List<int> AdItemList => adItemList;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public bool IsOpenDrop => isOpenDrop;

	public CopyData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public bool IsSingle
	{
		get
		{
			return isSingle;
		}
		private set
		{
			Set(ref isSingle, value, "IsSingle");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public CopyBuffItemViewModel2 BuffVM
	{
		get
		{
			return copyBuffVm;
		}
		private set
		{
			Set(ref copyBuffVm, value, "BuffVM");
		}
	}

	public List<CopyEquipDropItemViewModel> DropDtailProps => dropDtailProps;

	public List<ReceiveItemViewModel> DropProps => dropProps;

	public IInteractionRequest ShowEntryDetailRequest => showEntryDetailRequest;

	public CopyItemDetail2ViewModel()
	{
	}

	public CopyItemDetail2ViewModel(OptionBase parent)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		dropProps = new List<ReceiveItemViewModel>();
		dropDtailProps = new List<CopyEquipDropItemViewModel>();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ReceiveItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
		else if (obj is OptionArg optionArg && "OnShowEntryPanel".Equals(optionArg.OptionName))
		{
			ShowEntryDetail((EntryItem)optionArg.Obj);
		}
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		showEntryDetailRequest.Raise(entryItem);
	}

	public void RefreshData(CopyData data)
	{
		Data = data;
		adItemList = data.Buffs;
		if (adItemList == null)
		{
			adItemList = new List<int>();
		}
		Desc = ReplaceDesc(this.data.Desc);
		GetCopyDrops();
		GetCopyBuff();
	}

	private void GetCopyBuff()
	{
		copyBuffVm.SetSelect(isSelect: false);
		EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(data.CopyEnvironId);
		if (displayInfo.EnvironId != 0)
		{
			bool isActive = (data.IsNeedFirst && data.IsAccessed) || !data.IsNeedFirst;
			copyBuffVm.Desc = displayInfo.Desc;
			copyBuffVm.IsActive = isActive;
		}
		else
		{
			Log.Error($"EnvironmentModifier表找不到Id {data.CopyEnvironId} 的数据！");
		}
	}

	private string ReplaceDesc(string desc)
	{
		if (!string.IsNullOrEmpty(desc) && desc.Contains("\\n"))
		{
			using (Utf16ValueStringBuilder utf16ValueStringBuilder = ZString.CreateStringBuilder())
			{
				utf16ValueStringBuilder.Append(desc);
				utf16ValueStringBuilder.Replace("\\n", "\n");
				return utf16ValueStringBuilder.ToString();
			}
		}
		return desc;
	}

	public void GetCopyDrops()
	{
		dropProps.Clear();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == data.Drops);
		if (dataRow != null)
		{
			if (dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
			{
				Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】数据配置异常！");
				return;
			}
			for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
				if (propDataBase == null)
				{
					Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
					continue;
				}
				ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
				dropProps.Add(receiveItemViewModel);
				if (dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num)
				{
					receiveItemViewModel.SetCountRange(dataRow.PropNumShow[num]);
				}
				else
				{
					receiveItemViewModel.SetCountRange("");
				}
			}
			if (dataRow.FirstDropShow.Count != dataRow.FirstDropType.Count || dataRow.FirstDropShow.Count != dataRow.FirstDropNum.Count)
			{
				Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】首通奖励数据配置异常！");
				return;
			}
			for (int num2 = 0; num2 < dataRow.FirstDropShow.Count; num2++)
			{
				PropDataBase propDataBase2 = PropDataBase.CreateByType(dataRow.FirstDropType[num2], dataRow.FirstDropShow[num2], dataRow.FirstDropNum[num2]);
				if (propDataBase2 == null)
				{
					Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.FirstDropType {dataRow.FirstDropType[num2]}，CopyDrop.FirstDropShow {dataRow.FirstDropShow[num2]}配置有误！");
					continue;
				}
				ReceiveItemViewModel receiveItemViewModel2 = new ReceiveItemViewModel(propDataBase2, this);
				receiveItemViewModel2.SetLock(isLock: true);
				if (data.IsAccessed)
				{
					dropProps.Add(receiveItemViewModel2);
					receiveItemViewModel2.SetGot(isGot: true);
				}
				else
				{
					dropProps.Insert(num2, receiveItemViewModel2);
					receiveItemViewModel2.SetGot(isGot: false);
				}
			}
		}
		else
		{
			Log.Error($"CopyDrop2 配置表，找不到 Id【{dataRow.Id}】的数据！");
		}
		if (isOpenDrop)
		{
			GetCopyOpenDrops();
		}
		else
		{
			openDropComplete = false;
		}
		optRequest.Raise("RefreshDrops");
	}

	public void RefreshDropRank()
	{
		GetCopyDrops();
	}

	private void GetCopyOpenDrops()
	{
		openDropComplete = true;
		dropDtailProps.Clear();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == data.Drops);
		if (dataRow == null || dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
		{
			return;
		}
		for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
			if (propDataBase != null && propDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				ArmourData armourData = propDataBase as ArmourData;
				KnapsackItemViewModel armourItemData = new KnapsackItemViewModel(this, propDataBase);
				List<EntryItemData> list = new List<EntryItemData>();
				List<EntryData> allEntry = armourData.GetAllEntry();
				for (int num2 = 0; num2 < allEntry.Count; num2++)
				{
					EntryItemData item = new EntryItemData(this, allEntry[num2]);
					list.Add(item);
				}
				int num3 = armourData.AdditionalEntryNum - armourData.AdditionalEntryList.Count;
				string text = ((armourData.Level == armourData.MaxLevel) ? "需要先解锁" : "满级后可解锁");
				for (int num4 = 0; num4 < num3; num4++)
				{
					list.Add(new EntryItemData(this, text));
				}
				dropDtailProps.Add(new CopyEquipDropItemViewModel(this, armourItemData, list, armourData.AdditionalEntryNum));
			}
		}
	}

	public void OnBuffClick()
	{
		parent.ItemOnClick(new OptionArg(this, "ShowCopyBuffDesc"));
	}

	private void OnOpt(string optName)
	{
		if ("OnSingle".Equals(optName))
		{
			parent.ItemOnClick("OpenSingle");
		}
		else if ("OnMulti".Equals(optName))
		{
			parent.ItemOnClick("OpenMulti");
		}
		else if ("ChangeDrop".Equals(optName))
		{
			isOpenDrop = !isOpenDrop;
			if (isOpenDrop && !openDropComplete)
			{
				GetCopyOpenDrops();
				optRequest.Raise("RefreshDrops");
			}
			optRequest.Raise(optName);
		}
		else if ("ChangeMode".Equals(optName))
		{
			IsSingle = !isSingle;
		}
	}
}
