using System.Collections.Generic;

namespace Ase;

public class HLFriendFarmViewModel : OptionBase
{
	private int gridCount;

	private List<HLPlantItemData> hlPlantItemDataList;

	private long friendUid;

	private int[] todayCount;

	private string leftIncreaseText;

	private string leftHarvestText;

	private int increaseMax;

	private int harvestMax;

	public string LeftIncreaseText
	{
		get
		{
			return leftIncreaseText;
		}
		private set
		{
			Set(ref leftIncreaseText, value, "LeftIncreaseText");
		}
	}

	public string LeftHarvestText
	{
		get
		{
			return leftHarvestText;
		}
		private set
		{
			Set(ref leftHarvestText, value, "LeftHarvestText");
		}
	}

	public List<HLPlantItemData> HlPlantItemDataList => hlPlantItemDataList;

	public HLFriendFarmViewModel(OptionBase parent, long friendUId, int buildingLevel, List<FarmData> farmDataList)
	{
		base.parent = parent;
		friendUid = friendUId;
		hlPlantItemDataList = new List<HLPlantItemData>();
		DRFarmLevel dataRow = GameEntry.DataTable.GetDataRow<DRFarmLevel>(buildingLevel);
		if (dataRow != null)
		{
			gridCount = dataRow.CellCount;
			if (farmDataList != null && farmDataList.Count <= gridCount)
			{
				for (int i = 0; i < gridCount; i++)
				{
					HLPlantItemData hLPlantItemData = new HLPlantItemData(this, i + 1);
					foreach (FarmData farmData in farmDataList)
					{
						if (i + 1 == farmData.GridId)
						{
							hLPlantItemData.SetSeedInfo(farmData.Icon, farmData.SeedId, farmData.Rarity);
							hLPlantItemData.SetLeftTime(farmData.HarvestTime, farmData.State);
							hLPlantItemData.SetCount(farmData.FruitCount);
							hLPlantItemData.IsIncrease = farmData.FriendIncrease;
							hLPlantItemData.SetMask(farmData.FriendHarvest || farmData.FriendIncrease);
						}
					}
					hlPlantItemDataList.Add(hLPlantItemData);
				}
			}
		}
		increaseMax = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.HomeLandTodayIncrease, 10);
		harvestMax = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.HomeLandTodayHarvest, 10);
		SetLeftText();
	}

	private void SetLeftText()
	{
		todayCount = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetTodayCount();
		LeftIncreaseText = ((increaseMax <= todayCount[0]) ? $"<color=#FF0000>{increaseMax - todayCount[0]}</color>/{increaseMax}" : $"{increaseMax - todayCount[0]}/{increaseMax}");
		LeftHarvestText = ((harvestMax <= todayCount[1]) ? $"<color=#FF0000>{harvestMax - todayCount[1]}</color>/{harvestMax}" : $"{harvestMax - todayCount[1]}/{harvestMax}");
	}

	public override void ItemOnClick(object obj)
	{
		if (!(obj is OptionArg { Obj: HLPlantItemData obj2 }))
		{
			return;
		}
		if (obj2.State == 3)
		{
			if (!obj2.IsIncrease)
			{
				IncreasePlant(obj2);
			}
			else
			{
				Toast.ShowInfo("今日已不可再为该格子增产");
			}
		}
		else if (obj2.State == 4)
		{
			HarvestFriendPlant(obj2);
		}
	}

	private async void IncreasePlant(HLPlantItemData hlPlantItemData)
	{
		if (todayCount[0] >= increaseMax)
		{
			Toast.ShowInfo("今日已不可再为该格子增产");
		}
		else if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().IncreaseFriendPlant(friendUid, hlPlantItemData.GridId))
		{
			Toast.ShowInfo("增加产量");
			hlPlantItemData.IsIncrease = true;
			hlPlantItemData.SetMask(value: true);
			SetLeftText();
		}
		else
		{
			Toast.ShowInfo("今日已不可再为该格子增产");
		}
	}

	private async void HarvestFriendPlant(HLPlantItemData hlPlantItemData)
	{
		if (todayCount[1] >= harvestMax)
		{
			Toast.ShowInfo("今日已不可再获得该格子的产物");
			return;
		}
		HarvestData harvestData = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().HarvestFriendPlant(friendUid, hlPlantItemData.GridId);
		if (harvestData.PropGetViewModel != null)
		{
			SetLeftText();
			hlPlantItemData.SetMask(value: true);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), harvestData.PropGetViewModel), delegate
			{
			});
		}
		else
		{
			Toast.ShowInfo("今日已不可再获得该格子的产物!");
		}
	}
}
