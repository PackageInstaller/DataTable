using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HLPlantViewModel : OptionBase
{
	private int gridCount;

	private List<HLSeedItemData> hlSeedItemDataList;

	private List<HLPlantItemData> hlPlantItemDataList;

	private bool showSeedView;

	private HLPlantItemData selectedGrid;

	private HLSeedItemData selectedSeed;

	private SimpleCommand confirmSeedCmd;

	private SimpleCommand getAllPlantCmd;

	private string confirmText;

	private string seedUseTimeText;

	private InteractionRequest playAnimationRequest;

	public List<HLSeedItemData> HlSeedItemDataList
	{
		get
		{
			return hlSeedItemDataList;
		}
		set
		{
			Set(ref hlSeedItemDataList, value, "HlSeedItemDataList");
		}
	}

	public List<HLPlantItemData> HlPlantItemDataList
	{
		get
		{
			return hlPlantItemDataList;
		}
		set
		{
			Set(ref hlPlantItemDataList, value, "HlPlantItemDataList");
		}
	}

	public bool ShowSeedView
	{
		get
		{
			return showSeedView;
		}
		set
		{
			Set(ref showSeedView, value, "ShowSeedView");
		}
	}

	public string ConfirmText
	{
		get
		{
			return confirmText;
		}
		set
		{
			Set(ref confirmText, value, "ConfirmText");
		}
	}

	public string SeedUseTimeText
	{
		get
		{
			return seedUseTimeText;
		}
		set
		{
			Set(ref seedUseTimeText, value, "SeedUseTimeText");
		}
	}

	public SimpleCommand ConfirmSeedCmd => confirmSeedCmd;

	public SimpleCommand GetAllPlantCmd => getAllPlantCmd;

	public InteractionRequest PlayAnimationRequest => playAnimationRequest;

	public HLPlantViewModel(OptionBase parent, int buildingLevel, List<FarmData> farmDataList)
	{
		base.parent = parent;
		hlSeedItemDataList = new List<HLSeedItemData>();
		hlPlantItemDataList = new List<HLPlantItemData>();
		confirmSeedCmd = new SimpleCommand(StartPlant);
		getAllPlantCmd = new SimpleCommand(GetAllPlant);
		confirmSeedCmd.Enabled = false;
		playAnimationRequest = new InteractionRequest();
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
							hLPlantItemData.IsIncrease = farmData.IsInCrease;
						}
					}
					hlPlantItemDataList.Add(hLPlantItemData);
				}
			}
		}
		LoadSeeds();
		CheckCanHarvestPlant();
	}

	public void BtnBackOnClick()
	{
		if (ShowSeedView)
		{
			ShowSeedView = false;
			selectedGrid.IsSelect = false;
			selectedGrid = null;
			playAnimationRequest.Raise();
		}
		else
		{
			Close();
		}
	}

	public void OpenGamePlayWindow()
	{
		string title = "规则说明";
		string content = GameEntry.DataTable.GetDataRow<DRBuildingInfo>(1)?.PlayDesc;
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, title, content);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
	}

	private void CheckCanHarvestPlant()
	{
		bool enabled = false;
		for (int i = 0; i < hlPlantItemDataList.Count; i++)
		{
			if (hlPlantItemDataList[i].State == 4)
			{
				enabled = true;
				break;
			}
		}
		GetAllPlantCmd.Enabled = enabled;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is HLPlantItemData hLPlantItemData)
			{
				if (selectedGrid != null)
				{
					selectedGrid.IsSelect = false;
					selectedGrid.IsShowExBtn = false;
				}
				selectedGrid = hLPlantItemData;
				if (ShowSeedView)
				{
					selectedGrid.IsSelect = true;
				}
				bool flag = !ShowSeedView;
				if (optionArg.OptionName.Equals("OnClick"))
				{
					switch (hLPlantItemData.State)
					{
					case 2:
						ShowSeedView = true;
						ConfirmText = "培育";
						ConfirmSeedCmd.Enabled = false;
						selectedGrid.IsSelect = true;
						if (selectedSeed != null)
						{
							selectedSeed.IsSelected = false;
						}
						if (flag)
						{
							playAnimationRequest.Raise();
						}
						SeedUseTimeText = "";
						break;
					case 3:
						if (ShowSeedView)
						{
							ConfirmText = "正在培育中......";
							ConfirmSeedCmd.Enabled = false;
						}
						else
						{
							hLPlantItemData.IsShowExBtn = true;
						}
						break;
					case 4:
						if (ShowSeedView)
						{
							ConfirmText = "正在培育中......";
							ConfirmSeedCmd.Enabled = false;
						}
						else
						{
							HarvestPlant(hLPlantItemData);
						}
						break;
					}
				}
				else if (optionArg.OptionName.Equals("Abort"))
				{
					OpenTipWindow(hLPlantItemData);
				}
				else if (optionArg.OptionName.Equals("SpeedUp"))
				{
					OpenSpeedUpWindow(hLPlantItemData);
				}
			}
			else if (optionArg.Obj is HLSeedItemData hLSeedItemData)
			{
				if (selectedSeed != null)
				{
					selectedSeed.IsSelected = false;
				}
				if (optionArg.OptionName.Equals("Seed"))
				{
					selectedSeed = hLSeedItemData;
					SimpleCommand simpleCommand = confirmSeedCmd;
					HLPlantItemData hLPlantItemData2 = selectedGrid;
					int enabled;
					if (hLPlantItemData2 == null || hLPlantItemData2.State != 3)
					{
						HLPlantItemData hLPlantItemData3 = selectedGrid;
						enabled = ((hLPlantItemData3 == null || hLPlantItemData3.State != 4) ? 1 : 0);
					}
					else
					{
						enabled = 0;
					}
					simpleCommand.Enabled = (byte)enabled != 0;
					selectedSeed.IsSelected = true;
					SeedUseTimeText = "需要培育时长:" + Utility.DateTime.GetLeftDateTimeWithLatest(selectedSeed.UseTime);
				}
			}
			else if (optionArg.Obj is TipWithPropViewModel)
			{
				AbortPlant(selectedGrid);
			}
			else if (optionArg.Obj is HLPlantSpeedUpViewModel hLPlantSpeedUpViewModel)
			{
				SpeedUpPlant(selectedGrid, hLPlantSpeedUpViewModel.CurItemViewModel.PropDataBase.Id, hLPlantSpeedUpViewModel.UseCount);
				hLPlantSpeedUpViewModel.Close();
			}
		}
		else if (obj is HLPlantItemData)
		{
			CheckCanHarvestPlant();
		}
	}

	private void LoadSeeds()
	{
		Dictionary<int, bool> unLockSeedList = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetUnLockSeedList();
		DRFarmSeed[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRFarmSeed>();
		foreach (DRFarmSeed dRFarmSeed in allDataRow)
		{
			bool flag = unLockSeedList.ContainsKey(dRFarmSeed.Id);
			unLockSeedList.TryGetValue(dRFarmSeed.Id, out var value);
			HLSeedItemData hLSeedItemData = new HLSeedItemData(this, dRFarmSeed.Id, dRFarmSeed.Icon, dRFarmSeed.Rarity, !flag, dRFarmSeed.HarvestTime);
			hLSeedItemData.ShowRedPoint = value;
			HlSeedItemDataList.Add(hLSeedItemData);
		}
		HlSeedItemDataList.Sort(new FarmSeedItemSort());
	}

	private async void GetAllPlant()
	{
		getAllPlantCmd.Enabled = false;
		bool flag = false;
		for (int i = 0; i < hlPlantItemDataList.Count; i++)
		{
			if (hlPlantItemDataList[i].State == 4)
			{
				flag = true;
			}
		}
		if (!flag)
		{
			getAllPlantCmd.Enabled = true;
			return;
		}
		HarvestData harvestData = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().HarvestPlant(0);
		if (harvestData.PropGetViewModel != null)
		{
			for (int j = 0; j < hlPlantItemDataList.Count; j++)
			{
				for (int k = 0; k < harvestData.FarmDataList.Count; k++)
				{
					if (hlPlantItemDataList[j].GridId == harvestData.FarmDataList[k].GridId)
					{
						hlPlantItemDataList[j].SetLeftTime(harvestData.FarmDataList[k].HarvestTime, 3);
						hlPlantItemDataList[j].SetCount(harvestData.FarmDataList[k].FruitCount);
					}
				}
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), harvestData.PropGetViewModel), delegate
			{
				CheckCanHarvestPlant();
			});
		}
		else
		{
			Toast.ShowInfo("收获种植物失败,请稍后尝试!");
			getAllPlantCmd.Enabled = true;
		}
	}

	private async void StartPlant()
	{
		long[] array = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().StartPlant(selectedGrid.GridId, selectedSeed.SeedId);
		if (array == null)
		{
			Toast.ShowInfo("种植失败,请稍后尝试!");
			return;
		}
		selectedGrid.SetLeftTime(array[0], 3);
		selectedGrid.SetCount(array[1]);
		selectedGrid.SetSeedInfo(selectedSeed.SeedIcon, selectedSeed.SeedId, selectedSeed.SeedRarity);
		selectedGrid.IsIncrease = false;
		selectedGrid.IsSelect = false;
		ShowSeedView = false;
		playAnimationRequest.Raise();
	}

	private void OpenTipWindow(HLPlantItemData hlPlantItemData)
	{
		TipWithPropViewModel userData = new TipWithPropViewModel(this, hlPlantItemData.SeedIcon, hlPlantItemData.SeedRarity, "提示", "是否停止培育？");
		openWindowRequest.Raise(new OpenViewArg(typeof(TipWithPropWindow), userData), delegate
		{
		});
	}

	private async void AbortPlant(HLPlantItemData data)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().AbortPlant(data.GridId))
		{
			data.AbortState();
		}
		else
		{
			Toast.ShowInfo("取消种植失败,请稍后尝试!");
		}
	}

	private async void HarvestPlant(HLPlantItemData data)
	{
		HarvestData harvestData = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().HarvestPlant(data.GridId);
		if (harvestData.PropGetViewModel != null)
		{
			for (int i = 0; i < hlPlantItemDataList.Count; i++)
			{
				for (int j = 0; j < harvestData.FarmDataList.Count; j++)
				{
					if (hlPlantItemDataList[i].GridId == harvestData.FarmDataList[j].GridId)
					{
						hlPlantItemDataList[i].SetLeftTime(harvestData.FarmDataList[j].HarvestTime, 3);
						hlPlantItemDataList[i].SetCount(harvestData.FarmDataList[j].FruitCount);
					}
				}
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), harvestData.PropGetViewModel), delegate
			{
			});
		}
		else
		{
			Toast.ShowInfo("收获种植物失败,请稍后尝试!");
		}
		CheckCanHarvestPlant();
	}

	private void OpenSpeedUpWindow(HLPlantItemData hlPlantItemData)
	{
		HLPlantSpeedUpViewModel userData = new HLPlantSpeedUpViewModel(this, hlPlantItemData.LeftTime);
		openWindowRequest.Raise(new OpenViewArg(typeof(HLPlantSpeedUpWindow), userData), delegate
		{
		});
	}

	private async void SpeedUpPlant(HLPlantItemData data, int itemId, int itemCount)
	{
		long num = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().SpeedUpPlant(data.GridId, itemId, itemCount);
		if (num > 0)
		{
			data.SetLeftTime(num, 3);
		}
		else
		{
			Toast.ShowInfo("加速道具使用失败,请稍后再试!");
		}
	}
}
