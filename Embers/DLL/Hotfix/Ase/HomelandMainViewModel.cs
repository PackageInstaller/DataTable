#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomelandMainViewModel : OptionBase
{
	private int level;

	private int levelMax;

	private string friendName;

	private bool isSelf;

	private bool canUpgrade;

	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private List<HomelandFriendItemViewModel> friendList;

	private List<HomelandBuildingItemViewModel> friendBuildingVms;

	private bool isShowUpgrade;

	private HomelandUpgradeViewModel upgradeVM;

	private Dictionary<int, HomelandBuildingItemViewModel> buildingVms;

	private List<HomelandBuildingItemViewModel> buildingVms2;

	private bool hasRed;

	private int upgradeBuildingId;

	private int upgradeBuildingLevel;

	private HomeLandViewModel hlVm;

	private int openIndex;

	private HomelandBuildingItemViewModel curBuildingItem;

	private HomelandFriendItemViewModel curFriendItem;

	public HomelandBuildingItemViewModel CurBuildingItem => curBuildingItem;

	public int Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public int LevelMax => levelMax;

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		private set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public bool CanUpgrade
	{
		get
		{
			return canUpgrade;
		}
		private set
		{
			Set(ref canUpgrade, value, "CanUpgrade");
		}
	}

	public bool HasRed
	{
		get
		{
			return hasRed;
		}
		private set
		{
			Set(ref hasRed, value, "HasRed");
		}
	}

	public string FriendName
	{
		get
		{
			return friendName;
		}
		private set
		{
			Set(ref friendName, value, "FriendName");
		}
	}

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<HomelandFriendItemViewModel> FriendList => friendList;

	public bool IsShowUpgrade
	{
		get
		{
			return isShowUpgrade;
		}
		private set
		{
			Set(ref isShowUpgrade, value, "IsShowUpgrade");
		}
	}

	public HomelandUpgradeViewModel UpgradeVm => upgradeVM;

	public HomelandMainViewModel(int openIndex = 0)
	{
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		hlVm = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetVm();
		hlVm.SetParent(this);
		buildingVms = new Dictionary<int, HomelandBuildingItemViewModel>();
		foreach (HomelandBuildingData value in hlVm.BuildingDatas.Values)
		{
			buildingVms.Add(value.Id, new HomelandBuildingItemViewModel(this, value, hlVm.HomelandLevel, isSelf: true));
		}
		this.openIndex = openIndex;
		level = hlVm.HomelandLevel;
		levelMax = hlVm.HomelandLevelMax;
		isSelf = true;
		friendName = "";
		CheckUpgradeLevel();
		CheckBuildingsLevelAndCoin();
	}

	private void CheckUpgradeLevel()
	{
		if (level != levelMax)
		{
			DRHomeLandLevelInfo dataRow = GameEntry.DataTable.GetDataRow((DRHomeLandLevelInfo p) => p.Id == level + 1);
			if (upgradeVM == null)
			{
				upgradeVM = new HomelandUpgradeViewModel(this, level, dataRow);
			}
			else
			{
				upgradeVM.InitLevelInfo(level, dataRow);
			}
			CanUpgrade = upgradeVM.EnableUpgrade;
		}
		else
		{
			CanUpgrade = false;
		}
	}

	private void CheckUpgradeCoin()
	{
		upgradeVM?.InitCoinInfo();
		if (level != levelMax)
		{
			CanUpgrade = upgradeVM?.EnableUpgrade ?? false;
		}
		else
		{
			CanUpgrade = false;
		}
	}

	private async void OnOpt(string arg)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		if ("OnLeft".Equals(arg))
		{
			if (isSelf)
			{
				Close();
			}
			else
			{
				LeftFriend();
			}
		}
		else if ("OnOpenUpgradeLevel".Equals(arg))
		{
			if (isSelf)
			{
				optCommand.Enabled = false;
				if (level != levelMax)
				{
					optRequest.Raise("OnOpenUpgradeLevel");
					return;
				}
				Toast.ShowInfo("原初之灯已达到最大等级！");
				optCommand.Enabled = true;
			}
		}
		else if ("OnOpenBuilding".Equals(arg))
		{
			optRequest.Raise("OnOpenBuilding");
			optCommand.Enabled = true;
		}
		else
		{
			if (!"OnOpenFriend".Equals(arg))
			{
				return;
			}
			if (friendList == null)
			{
				friendList = new List<HomelandFriendItemViewModel>();
				List<PlayerData> friendsData = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().FriendsData;
				for (int i = 0; i < friendsData.Count; i++)
				{
					if (friendsData[i].HomelandLevel != 0)
					{
						HomelandFriendItemViewModel item = new HomelandFriendItemViewModel(this, friendsData[i]);
						friendList.Add(item);
					}
				}
				friendList.Sort(new HomelandFriendSort());
			}
			optRequest.Raise("OnOpenFriend");
			optCommand.Enabled = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if ("OnUpgradeLevel".Equals(optionArg.OptionName))
			{
				UpgradeLevel();
			}
			else if ("OnCloseUpgradeLevel".Equals(optionArg.OptionName))
			{
				optRequest.Raise("OnCloseUpgradeLevel");
				optCommand.Enabled = true;
				upgradeVM.EnableOpt();
			}
			else if ("OnOpenBuildingUpgrade".Equals(optionArg.OptionName))
			{
				OpenBuildingUpgrade((HomelandBuildingItemViewModel)optionArg.Obj);
			}
			else if ("OnCloseBuildingUpgrade".Equals(optionArg.OptionName))
			{
				OnCloseBuildingUpgrade();
			}
			else if ("OnBuildingUpgrade".Equals(optionArg.OptionName))
			{
				OnBuildingUpgrade((HomelandBuildingItemViewModel)optionArg.Obj);
			}
			else if ("OpenWindow".Equals(optionArg.OptionName))
			{
				OpenWindow((HomelandBuildingItemViewModel)optionArg.Obj);
			}
		}
		else if (obj is CastingMaterialItemData castingMaterialItemData)
		{
			OpenViewArg openViewArg = new KnapsackItemViewModel(this, castingMaterialItemData.PropData).OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is HomelandFriendItemViewModel friendItemVm)
		{
			OnVisitFriend(friendItemVm);
		}
		else if (obj is string text && text.Equals("RedPoint"))
		{
			parent?.ItemOnClick(this);
		}
	}

	public void OpenWindowOnShow()
	{
		if (buildingVms.ContainsKey(openIndex))
		{
			OpenWindow(buildingVms[openIndex]);
		}
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("HomelandMainWindow"))
		{
			optionBase.Close();
			return false;
		}
		return true;
	}

	private async void OpenWindow(HomelandBuildingItemViewModel item)
	{
		optCommand.Enabled = false;
		try
		{
			switch (item.Data.Id)
			{
			case 1:
				if (!isSelf)
				{
					if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetFriendFarmInfo(curFriendItem.Data.Uid))
					{
						FarmInfo farmInfo = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetFarmInfo();
						HLFriendFarmViewModel userData3 = new HLFriendFarmViewModel(this, curFriendItem.Data.Uid, farmInfo.Level, farmInfo.FarmDataList);
						openWindowRequest.Raise(new OpenViewArg(typeof(HLFriendFarmWindow), userData3), delegate
						{
							item.EnableOpt();
							optCommand.Enabled = true;
						});
					}
					else
					{
						optCommand.Enabled = true;
					}
				}
				else if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestFarmInfo())
				{
					FarmInfo farmInfo2 = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetFarmInfo();
					HLPlantViewModel userData4 = new HLPlantViewModel(this, farmInfo2.Level, farmInfo2.FarmDataList);
					openWindowRequest.Raise(new OpenViewArg(typeof(HLPlantWindow), userData4), delegate
					{
						item.EnableOpt();
						optCommand.Enabled = true;
					});
				}
				else
				{
					optCommand.Enabled = true;
				}
				break;
			case 2:
			{
				if (!isSelf)
				{
					Toast.ShowInfo("无法进入他人的" + item.Data.Name);
					item.EnableOpt();
					optCommand.Enabled = true;
					break;
				}
				Loading sailLoading = await Loading.Show();
				SailInfo sailInfo = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetSailLightEventList();
				sailLoading.Dispose();
				if (!sailInfo.IsInit)
				{
					optCommand.Enabled = true;
					break;
				}
				SailLightDispatchViewModel userData2 = new SailLightDispatchViewModel(this, sailInfo, buildingVms[2].Data.Level);
				openWindowRequest.Raise(new OpenViewArg(typeof(SailLightDispatchWindow), userData2), delegate
				{
					item.EnableOpt();
					CheckUpgradeCoin();
					optCommand.Enabled = true;
					CheckBuildingsLevelAndCoin();
				});
				break;
			}
			case 3:
			{
				long shopId = (isSelf ? Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid : curFriendItem.Data.Uid);
				HomeShopWindowViewModel shopVm = new HomeShopWindowViewModel(this, shopId);
				if (await shopVm.OnOpenBefore())
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(HomeShopWindow), shopVm), delegate
					{
						item.EnableOpt();
						CheckUpgradeCoin();
						optCommand.Enabled = true;
						CheckBuildingsLevelAndCoin();
					});
				}
				else
				{
					item.EnableOpt();
					optCommand.Enabled = true;
				}
				IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
				if (service?.GetHomeShopViewModel()?.GetHomeShopRefreshRed() == true)
				{
					service?.GetHomeShopViewModel()?.SetHomeShopRefreshRead();
				}
				break;
			}
			case 4:
			{
				if (!isSelf)
				{
					Toast.ShowInfo("无法进入他人的" + item.Data.Name);
					item.EnableOpt();
					optCommand.Enabled = true;
					break;
				}
				BattlePropMakeViewModel userData = new BattlePropMakeViewModel(this);
				openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropMakeWindow), userData), delegate
				{
					item.EnableOpt();
					optCommand.Enabled = true;
				});
				break;
			}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开界面异常！");
			item.EnableOpt();
			optCommand.Enabled = true;
		}
	}

	private void OpenBuildingUpgrade(HomelandBuildingItemViewModel buildingItem)
	{
		curBuildingItem = buildingItem;
		if (curBuildingItem.InitUpgradeMaterialsAddEffects())
		{
			optRequest.Raise("OnOpenBuildingUpgrade");
			return;
		}
		curBuildingItem.EnableOpt();
		curBuildingItem = null;
	}

	private async void UpgradeLevel()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().UpgradeHomeland(0))
		{
			optRequest.Raise("OnCloseUpgradeLevel");
			optRequest.Raise("ShowUpgradeLevelEffect");
			Level = hlVm.HomelandLevel;
			CheckUpgradeLevel();
			optCommand.Enabled = true;
		}
		else
		{
			Toast.ShowInfo("升级失败！");
		}
		CheckBuildingsLevelAndCoin();
		upgradeVM.EnableOpt();
	}

	private void CheckBuildingsLevelAndCoin()
	{
		bool flag = false;
		foreach (KeyValuePair<int, HomelandBuildingItemViewModel> buildingVm in buildingVms)
		{
			buildingVm.Value.UpdateLevel(level);
			flag = buildingVm.Value.Data.IsRed | flag;
		}
		HasRed = flag;
	}

	public void OnCloseBuildingUpgrade()
	{
		optRequest.Raise("OnCloseBuildingUpgrade");
		curBuildingItem.EnableOpt();
		curBuildingItem = null;
	}

	public void OpenUnLockPropWindow()
	{
		List<PropDataBase> list = new List<PropDataBase>();
		if (upgradeBuildingId == 1)
		{
			DRFarmSeed[] dataRows = GameEntry.DataTable.GetDataTable<DRFarmSeed>().GetDataRows((DRFarmSeed p) => p.UnlockType == 1 && p.UnlockTypeEx == upgradeBuildingLevel);
			for (int num = 0; num < dataRows.Length; num++)
			{
				PropDataBase item = PropDataBase.CreateByType(PropTypeEnum.FarmSeed, dataRows[num].Id);
				list.Add(item);
			}
		}
		if (list.Count > 0)
		{
			PropGetViewModel userData = new PropGetViewModel(this, list);
			openWindowRequest.Raise(new OpenViewArg(typeof(UnLockPropsWindow), userData), delegate
			{
				upgradeBuildingId = 0;
				upgradeBuildingLevel = 0;
			});
		}
	}

	private async void OnBuildingUpgrade(HomelandBuildingItemViewModel buildingItem)
	{
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().UpgradeHomeland(buildingItem.Data.Id);
		if (num)
		{
			Toast.ShowInfo("升级成功！");
			hlVm.UpdateBuildingEffect(buildingItem.EffectItemVms);
			upgradeBuildingId = buildingItem.Data.Id;
			upgradeBuildingLevel = buildingItem.Data.Level;
			OnCloseBuildingUpgrade();
			CheckUpgradeCoin();
			buildingItem.UpdateLevel(level);
		}
		else
		{
			Toast.ShowInfo("升级失败！");
		}
		buildingItem.EnableOpt();
		if (num)
		{
			buildingItem.PlayUpgradeEffect();
			CheckBuildingsLevelAndCoin();
		}
	}

	private async void OnVisitFriend(HomelandFriendItemViewModel friendItemVm)
	{
		optCommand.Enabled = false;
		if (curFriendItem == null)
		{
			curFriendItem = friendItemVm;
			friendItemVm.SetSelect(isSelect: true);
		}
		else
		{
			if (curFriendItem == friendItemVm)
			{
				IsSelf = false;
				friendItemVm.SetSelect(isSelect: true);
				optRequest.Raise("ShowFriendHomeland");
				optCommand.Enabled = true;
				return;
			}
			curFriendItem.SetSelect(isSelect: false);
			curFriendItem = friendItemVm;
			friendItemVm.SetSelect(isSelect: true);
		}
		List<HomelandBuildingData> list = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetFriendBuildingInfos(friendItemVm.Data);
		if (friendItemVm.Data.HomelandLevel == 0)
		{
			optCommand.Enabled = true;
			return;
		}
		if (friendBuildingVms != null)
		{
			friendBuildingVms.Clear();
		}
		else
		{
			friendBuildingVms = new List<HomelandBuildingItemViewModel>();
		}
		for (int i = 0; i < list.Count; i++)
		{
			friendBuildingVms.Add(new HomelandBuildingItemViewModel(this, list[i], friendItemVm.Data.HomelandLevel, isSelf: false));
		}
		FriendName = friendItemVm.Data.Name;
		Level = friendItemVm.Data.HomelandLevel;
		IsSelf = false;
		optRequest.Raise("ShowFriendHomeland");
		optCommand.Enabled = true;
	}

	private void LeftFriend()
	{
		IsSelf = true;
		curFriendItem.SetSelect(isSelect: false);
		Level = hlVm.HomelandLevel;
		optRequest.Raise("ShowSelfHomeland");
	}

	public HomelandBuildingItemViewModel GetBuildVMById(int id)
	{
		if (buildingVms.ContainsKey(id))
		{
			return buildingVms[id];
		}
		return null;
	}

	public HomelandBuildingItemViewModel GetFriendBuildVMById(int id)
	{
		for (int i = 0; i < friendBuildingVms.Count; i++)
		{
			if (friendBuildingVms[i].Data.Id == id)
			{
				return friendBuildingVms[i];
			}
		}
		return null;
	}

	public List<HomelandBuildingItemViewModel> GetBuildVMs()
	{
		if (buildingVms2 == null)
		{
			buildingVms2 = buildingVms.Values.ToList();
		}
		return buildingVms2;
	}

	public override void Close()
	{
		base.Close();
		hlVm = null;
	}
}
