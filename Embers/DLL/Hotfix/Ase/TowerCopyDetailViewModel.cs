#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class TowerCopyDetailViewModel : OptionBase
{
	private CopyData data;

	private List<ReceiveItemViewModel> dropProps = new List<ReceiveItemViewModel>(10);

	private string desc;

	private readonly InteractionRequest refreshRewardRequest = new InteractionRequest();

	public CopyData Data
	{
		get
		{
			return data;
		}
		set
		{
			Set(ref data, value, "Data");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public List<ReceiveItemViewModel> DropProps => dropProps;

	public IInteractionRequest RefreshRewardRequest => refreshRewardRequest;

	public TowerCopyDetailViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void ChangeViewModel(CopyData data, bool finishLevel, bool unlock)
	{
		Data = data;
		Desc = ReplaceDesc(data.Desc);
		GetCopyDrops(finishLevel, unlock);
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

	public void GetCopyDrops(bool isGot, bool unlock)
	{
		if (data == null)
		{
			return;
		}
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
				else if (isGot)
				{
					if (unlock)
					{
						dropProps.Insert(num2, receiveItemViewModel2);
						receiveItemViewModel2.SetGot(isGot: true);
					}
					else
					{
						dropProps.Insert(num2, receiveItemViewModel2);
						receiveItemViewModel2.SetGot(isGot: false);
					}
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
			Log.Error($"CopyDrop 配置表，找不到 RewardGroupId【{data.Drops}】的数据！");
		}
		refreshRewardRequest.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ReceiveItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
	}
}
