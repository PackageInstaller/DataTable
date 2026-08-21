#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomelandBuildingItemViewModel : OptionBase
{
	private List<CastingMaterialItemData> materialItemDatas = new List<CastingMaterialItemData>();

	private List<BuildingEffectItemViewModel> effectItemVms = new List<BuildingEffectItemViewModel>();

	private InteractionRequest updateMaterialRequest;

	private InteractionRequest playUpgradeEffectRequest;

	private long homelandCoin;

	private bool isLackGold;

	private bool isSelf;

	private long coinNeed;

	private int homelandLevel;

	private HomelandBuildingData data;

	private SimpleCommand<string> optCommand;

	public HomelandBuildingData Data
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

	public long HomelandCoin
	{
		get
		{
			return homelandCoin;
		}
		private set
		{
			Set(ref homelandCoin, value, "HomelandCoin");
		}
	}

	public long CoinNeed
	{
		get
		{
			return coinNeed;
		}
		private set
		{
			Set(ref coinNeed, value, "CoinNeed");
		}
	}

	public int HomelandLevel
	{
		get
		{
			return homelandLevel;
		}
		private set
		{
			Set(ref homelandLevel, value, "HomelandLevel");
		}
	}

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

	public List<CastingMaterialItemData> MaterialItemDatas => materialItemDatas;

	public List<BuildingEffectItemViewModel> EffectItemVms => effectItemVms;

	public IInteractionRequest UpdateMaterialRequest => updateMaterialRequest;

	public IInteractionRequest PlayUpgradeEffectRequest => playUpgradeEffectRequest;

	public ICommand OptCommand => optCommand;

	public HomelandBuildingItemViewModel()
	{
	}

	public HomelandBuildingItemViewModel(OptionBase parent, HomelandBuildingData data, int homelandLevel, bool isSelf)
	{
		base.parent = parent;
		this.data = data;
		optCommand = new SimpleCommand<string>(OnOpt);
		updateMaterialRequest = new InteractionRequest();
		playUpgradeEffectRequest = new InteractionRequest();
		this.homelandLevel = homelandLevel;
		this.isSelf = isSelf;
	}

	private void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenBuildingUpgradeView".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "OnOpenBuildingUpgrade"));
			optCommand.Enabled = true;
		}
		else if ("OnBuildingUpgrade".Equals(optName))
		{
			if (!data.IsRed)
			{
				optCommand.Enabled = true;
			}
			else
			{
				parent.ItemOnClick(new OptionArg(this, "OnBuildingUpgrade"));
			}
		}
		else if ("OnClose".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(null, "OnCloseBuildingUpgrade"));
			optCommand.Enabled = true;
		}
		else if ("OpenWindow".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "OpenWindow"));
		}
		else
		{
			optCommand.Enabled = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public void EnableOpt()
	{
		optCommand.Enabled = true;
	}

	public void UpdateData(HomelandBuildingData data)
	{
		Data = data;
	}

	public bool InitUpgradeMaterialsAddEffects()
	{
		if (data.Level >= data.LevelMax)
		{
			Toast.ShowInfo("模块已满级！");
			return false;
		}
		int nextLevel = data.Level + 1;
		DRBuildingLevelInfo levelInfo = GameEntry.DataTable.GetDataRow((DRBuildingLevelInfo p) => p.BuildingId == data.Id && p.Level == nextLevel);
		if (levelInfo == null)
		{
			Log.Error($"BuildingLevelInfo，找不到BuildingId【{data.Id}】,Level【{nextLevel}】的数据，请检查！");
			return false;
		}
		CoinNeed = levelInfo.MoneyNeed;
		HomelandCoin = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin);
		isLackGold = homelandCoin < coinNeed;
		if (levelInfo.NeedItem.Count != levelInfo.NeedItemCount.Count)
		{
			Log.Error($"BuildingLevelInfo，Id【{levelInfo.Id}】，道具数量不匹配！");
			return false;
		}
		materialItemDatas.Clear();
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		for (int num = 0; num < levelInfo.NeedItem.Count; num++)
		{
			KnapsackPropData knapsackPropData = knapsackViewModel.GetProp(levelInfo.NeedItem[num]);
			if (knapsackPropData == null)
			{
				knapsackPropData = KnapsackPropData.Create(levelInfo.NeedItem[num], 0);
			}
			materialItemDatas.Add(new CastingMaterialItemData(this, levelInfo.NeedItemCount[num], knapsackPropData));
			_ = knapsackPropData.Amount;
			_ = levelInfo.NeedItemCount[num];
		}
		effectItemVms.Clear();
		if (levelInfo.UpgradeEffectId.Count != levelInfo.UpgradeEffectVal.Count)
		{
			Log.Error($"BuildingLevelInfo，Id【{levelInfo.Id}】，等级效果数量不匹配！");
			return false;
		}
		HomeLandViewModel vm = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetVm();
		vm.SetParent(this);
		int i;
		for (i = 0; i < levelInfo.UpgradeEffectId.Count; i++)
		{
			DRHomeLandLevelEffect dataRow = GameEntry.DataTable.GetDataRow((DRHomeLandLevelEffect p) => p.Id == levelInfo.UpgradeEffectId[i]);
			BuildingEffectItemViewModel buildingEffectItemViewModel = new BuildingEffectItemViewModel();
			buildingEffectItemViewModel.RefreshEffect(dataRow, vm.GetEffectVal(levelInfo.UpgradeEffectId[i]), levelInfo.UpgradeEffectVal[i]);
			effectItemVms.Add(buildingEffectItemViewModel);
		}
		return true;
	}

	public void PlayUpgradeEffect()
	{
		playUpgradeEffectRequest.Raise();
	}

	public void UpdateLevel(int level)
	{
		HomelandLevel = level;
		data.InitUpgradeInfo(level);
	}
}
