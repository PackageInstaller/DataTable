using System;
using System.Collections.Generic;

namespace Ase;

public class PassportLevelItemData : OptionBase
{
	private int level;

	private List<PassportRewardItemData> passportRewardItemDataList;

	private bool isSending;

	private Action changeAction;

	private int receiveIndexId;

	private int passportLevel;

	public int Level
	{
		get
		{
			return level;
		}
		set
		{
			Set(ref level, value, "Level");
		}
	}

	public int PassportLevel
	{
		get
		{
			return passportLevel;
		}
		set
		{
			Set(ref passportLevel, value, "PassportLevel");
		}
	}

	public List<PassportRewardItemData> PassportRewardItemDataList => passportRewardItemDataList;

	public PassportLevelItemData(OptionBase parent, int level, int passportLevel)
	{
		base.parent = parent;
		this.level = level;
		LoadRewardItem();
		PassportLevel = passportLevel;
	}

	public int GetPassportRewardItemId(int index)
	{
		return passportRewardItemDataList[index].IndexId;
	}

	public void SetPassportRewardItemByIndex(int index, bool isReceived)
	{
		passportRewardItemDataList[index].IsReceived = isReceived;
		if (isReceived)
		{
			passportRewardItemDataList[index].RedPoint = false;
		}
	}

	public void SetPassportRewardItemReceivedByIndex(int index, bool isReceived)
	{
		passportRewardItemDataList[index].IsReceived = isReceived;
		if (isReceived)
		{
			passportRewardItemDataList[index].RedPoint = false;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: PassportRewardItemData obj2 } optionArg)
		{
			if ("ReceiveReward".Equals(optionArg.OptionName))
			{
				SendReceivedReward(obj2.IndexId);
			}
			else if ("OpenProp".Equals(optionArg.OptionName))
			{
				OpenProp(obj2);
			}
		}
	}

	private async void SendReceivedReward(int indexId)
	{
		receiveIndexId = 0;
		if (!isSending)
		{
			SetIsSending(value: true);
			if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetRewardRequest(indexId))
			{
				receiveIndexId = indexId;
				parent?.ItemOnClick(new OptionArg(this, ""));
				SetIsSending(value: false);
			}
			else
			{
				SetIsSending(value: false);
			}
		}
	}

	public void SetReceived()
	{
		foreach (PassportRewardItemData passportRewardItemData in passportRewardItemDataList)
		{
			if (passportRewardItemData.IndexId == receiveIndexId)
			{
				passportRewardItemData.IsReceived = true;
				passportRewardItemData.RedPoint = false;
			}
		}
	}

	public void SetReceived(bool grade1, bool grade2)
	{
		passportRewardItemDataList[0].IsReceived = grade1;
		if (grade1)
		{
			passportRewardItemDataList[0].RedPoint = false;
		}
		passportRewardItemDataList[1].IsReceived = grade2;
		passportRewardItemDataList[2].IsReceived = grade2;
		if (grade2)
		{
			passportRewardItemDataList[1].RedPoint = false;
			passportRewardItemDataList[2].RedPoint = false;
		}
	}

	private void OpenProp(PassportRewardItemData data)
	{
		PropDataBase data2 = PropDataBase.CreateByType(data.Type, data.ID);
		OpenViewArg obj = new KnapsackItemViewModel(this, data2).OpenPopupWindow(parent);
		parent?.ItemOnClick(obj);
	}

	public void SetIsSending(bool value)
	{
		isSending = value;
	}

	private void LoadRewardItem()
	{
		passportRewardItemDataList = new List<PassportRewardItemData>();
		DRPassportReward dataRow = GameEntry.DataTable.GetDataRow((DRPassportReward p) => p.Grade == 1 && p.Level == Level);
		if (dataRow != null)
		{
			AddReward(dataRow);
		}
		DRPassportReward[] dataRows = GameEntry.DataTable.GetDataRows((DRPassportReward p) => p.Grade == 2 && p.Level == Level);
		if (dataRows != null)
		{
			DRPassportReward[] array = dataRows;
			foreach (DRPassportReward drPassportReward in array)
			{
				AddReward(drPassportReward);
			}
		}
		if (passportRewardItemDataList.Count < 3)
		{
			passportRewardItemDataList.Add(new PassportRewardItemData(this, isImportant: false, 2));
		}
	}

	private void AddReward(DRPassportReward drPassportReward)
	{
		if (drPassportReward.RewardType.Count != drPassportReward.RewardID.Count || drPassportReward.RewardType.Count != drPassportReward.RewardNum.Count)
		{
			Toast.ShowError($"执照等级{Level}数据配置错误!");
			return;
		}
		for (int i = 0; i < drPassportReward.RewardType.Count; i++)
		{
			PassportRewardItemData passportRewardItemData = new PassportRewardItemData(this, drPassportReward.RarityBool, drPassportReward.Grade);
			passportRewardItemData.SetItem(drPassportReward.RewardID[i], drPassportReward.RewardType[i], drPassportReward.RewardNum[i], drPassportReward.Id);
			passportRewardItemDataList.Add(passportRewardItemData);
		}
	}

	public void SetGrade(int grade)
	{
		bool isLock = grade < 2;
		for (int i = 1; i < passportRewardItemDataList.Count; i++)
		{
			passportRewardItemDataList[i].IsLock = isLock;
		}
	}

	public void SetLevelLock(bool canReceived, int grade, int passportLevel)
	{
		for (int i = 0; i < passportRewardItemDataList.Count; i++)
		{
			if (i >= 1)
			{
				passportRewardItemDataList[i].RedPoint = ((grade >= 2) & canReceived) && !passportRewardItemDataList[i].IsReceived;
				passportRewardItemDataList[i].IsLock = grade < 2 || !canReceived;
			}
			else
			{
				passportRewardItemDataList[i].RedPoint = canReceived && !passportRewardItemDataList[i].IsReceived;
				passportRewardItemDataList[i].IsLock = !canReceived;
			}
		}
		PassportLevel = passportLevel;
	}
}
