using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BuyPassportLevelViewModel : OptionBase
{
	private int addLevel;

	private int originLevel;

	private int addMaxLevel;

	private string tip;

	private string cost;

	private MoneyData moneyData;

	private SimpleCommand addLevelCmd;

	private SimpleCommand reduceLevelCmd;

	private SimpleCommand confirmCmd;

	private List<PassportRewardItemData> rewardList;

	private InteractionRequest refreshRewardListRequest;

	private int grade;

	public int AddLevel
	{
		get
		{
			return addLevel;
		}
		private set
		{
			Set(ref addLevel, value, "AddLevel");
		}
	}

	public int OriginLevel
	{
		get
		{
			return originLevel;
		}
		private set
		{
			Set(ref originLevel, value, "OriginLevel");
		}
	}

	public int AddMaxLevel
	{
		get
		{
			return addMaxLevel;
		}
		private set
		{
			Set(ref addMaxLevel, value, "AddMaxLevel");
		}
	}

	public string Tip
	{
		get
		{
			return tip;
		}
		private set
		{
			Set(ref tip, value, "Tip");
		}
	}

	public string Cost
	{
		get
		{
			return cost;
		}
		private set
		{
			Set(ref cost, value, "Cost");
		}
	}

	public List<PassportRewardItemData> RewardList
	{
		get
		{
			return rewardList;
		}
		private set
		{
			Set(ref rewardList, value, "RewardList");
		}
	}

	public SimpleCommand AddLevelCmd => addLevelCmd;

	public SimpleCommand ReduceLevelCmd => reduceLevelCmd;

	public SimpleCommand ConfirmCmd => confirmCmd;

	public InteractionRequest RefreshRewardListRequest => refreshRewardListRequest;

	public MoneyData MoneyData => moneyData;

	public BuyPassportLevelViewModel(OptionBase parent, int originLevel, int maxLevel, int grade)
	{
		base.parent = parent;
		this.originLevel = originLevel;
		addMaxLevel = maxLevel;
		this.grade = grade;
		rewardList = new List<PassportRewardItemData>();
		refreshRewardListRequest = new InteractionRequest();
		addLevelCmd = new SimpleCommand(AddLevelOnClick);
		reduceLevelCmd = new SimpleCommand(ReduceLevelOnClick);
		confirmCmd = new SimpleCommand(BtnConfirm);
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		AddLevelOnClick();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: PassportRewardItemData obj2 } optionArg && "OpenProp".Equals(optionArg.OptionName))
		{
			OpenProp(obj2);
		}
	}

	private void OpenProp(PassportRewardItemData data)
	{
		PropDataBase data2 = PropDataBase.CreateByType(data.Type, data.ID);
		OpenViewArg context = new KnapsackItemViewModel(this, data2).OpenPopupWindow(parent);
		openWindowRequest.Raise(context);
	}

	private void AddLevelOnClick()
	{
		SetAddLevel(AddLevel + 1);
	}

	private void ReduceLevelOnClick()
	{
		SetAddLevel(AddLevel - 1);
	}

	private void SetAddLevel(int level)
	{
		AddLevel = ((level + originLevel > addMaxLevel) ? AddLevel : level);
		addLevelCmd.Enabled = AddLevel + OriginLevel < addMaxLevel;
		reduceLevelCmd.Enabled = AddLevel > 1;
		Tip = $"购买后提升至 <color=#ff961d>{AddLevel + originLevel}</color>级,可以获得以下奖励";
		int num = AddLevel * 150;
		Cost = ((num > MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond)) ? $"<color=#ff8a7a>{num}</color>" : $"<color=#dad2cd>{num}</color>");
		ConfirmCmd.Enabled = num <= MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
		LoadReward();
	}

	private async void BtnConfirm()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().BuyPassportLevel(addLevel))
		{
			Toast.ShowInfo("购买执照等级成功");
			Close();
		}
		else
		{
			Toast.ShowInfo("购买执照等级失败");
		}
	}

	private void LoadReward()
	{
		RewardList.Clear();
		DRPassportReward[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRPassportReward>();
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		List<int> list = new List<int>();
		DRPassportReward[] array = allDataRow;
		foreach (DRPassportReward dRPassportReward in array)
		{
			if (dRPassportReward.Grade > grade || dRPassportReward.Level <= originLevel || dRPassportReward.Level > originLevel + addLevel)
			{
				continue;
			}
			for (int j = 0; j < dRPassportReward.RewardID.Count; j++)
			{
				if (dRPassportReward.RewardType[j] == 5)
				{
					list.Add(dRPassportReward.RewardID[j]);
				}
				else if (dictionary.ContainsKey(dRPassportReward.RewardID[j]))
				{
					dictionary[dRPassportReward.RewardID[j]] += dRPassportReward.RewardNum[j];
				}
				else
				{
					dictionary.Add(dRPassportReward.RewardID[j], dRPassportReward.RewardNum[j]);
				}
			}
		}
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			PassportRewardItemData passportRewardItemData = new PassportRewardItemData(this, isImportant: false, 1);
			passportRewardItemData.SetItem(item.Key, 1, item.Value);
			passportRewardItemData.IsLock = true;
			RewardList.Add(passportRewardItemData);
		}
		foreach (int item2 in list)
		{
			PassportRewardItemData passportRewardItemData2 = new PassportRewardItemData(this, isImportant: false, 1);
			passportRewardItemData2.SetItem(item2, 5, 1);
			passportRewardItemData2.IsLock = true;
			RewardList.Add(passportRewardItemData2);
		}
		refreshRewardListRequest.Raise();
	}
}
