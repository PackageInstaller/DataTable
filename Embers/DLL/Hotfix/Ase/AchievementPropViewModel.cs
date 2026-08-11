using System.Collections.Generic;

namespace Ase;

public class AchievementPropViewModel : OptionBase
{
	private List<AchievementProgressItemData> achievementProgressItemDataList;

	private bool canGetReward;

	private bool redPoint;

	public List<AchievementProgressItemData> AchievementProgressItemDataList
	{
		get
		{
			return achievementProgressItemDataList;
		}
		set
		{
			Set(ref achievementProgressItemDataList, value, "AchievementProgressItemDataList");
		}
	}

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public AchievementPropViewModel(OptionBase parent)
	{
		base.parent = parent;
		canGetReward = true;
		achievementProgressItemDataList = new List<AchievementProgressItemData>();
		LoadAchievementProgressItem();
	}

	private void LoadAchievementProgressItem()
	{
		DRAchievementRewards[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementRewards>().GetAllDataRows();
		Dictionary<int, int> achievementGroupStateDic = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupStateDic();
		DRAchievementRewards[] array = allDataRows;
		foreach (DRAchievementRewards dRAchievementRewards in array)
		{
			int medalId = dRAchievementRewards.Id * -1;
			achievementGroupStateDic.TryGetValue(dRAchievementRewards.Id, out var value);
			AchievementMedal achievementMedalById = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementMedalById(medalId);
			AchievementProgressItemData item = new AchievementProgressItemData(this, dRAchievementRewards.AchievementType, dRAchievementRewards.Desc, value, dRAchievementRewards.Num, dRAchievementRewards.Rewards, achievementMedalById.MedalRank);
			achievementProgressItemDataList.Add(item);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg { Obj: AchievementProgressItemData obj2 } optionArg && canGetReward && optionArg.OptionName.Equals("ReceiveReward"))
		{
			ReceiveReward(obj2);
		}
	}

	private async void ReceiveReward(AchievementProgressItemData achievementProgressItemData)
	{
		canGetReward = false;
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendAchievementGroupReward(achievementProgressItemData.type);
		if (propGetViewModel != null)
		{
			achievementProgressItemData.CanReceived = false;
			achievementProgressItemData.SetReceived();
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel), delegate
			{
				canGetReward = true;
			});
			parent?.ItemOnClick(this);
		}
	}

	private async void CheckRedPoint()
	{
		RedPoint = false;
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupInfo()))
		{
			return;
		}
		Dictionary<int, int> achievementGroupStateDic = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupStateDic();
		DRAchievementRewards[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementRewards>().GetAllDataRows();
		foreach (DRAchievementRewards dRAchievementRewards in allDataRows)
		{
			int medalId = dRAchievementRewards.Id * -1;
			achievementGroupStateDic.TryGetValue(dRAchievementRewards.Id, out var value);
			if (Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementMedalById(medalId).MedalRank < 1 && value >= dRAchievementRewards.Num)
			{
				RedPoint = true;
				break;
			}
		}
	}
}
