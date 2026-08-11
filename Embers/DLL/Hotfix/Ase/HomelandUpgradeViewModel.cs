#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomelandUpgradeViewModel : OptionBase
{
	private List<CastingMaterialItemData> materialItemDatas = new List<CastingMaterialItemData>();

	private InteractionRequest updateMaterialRequest;

	private SimpleCommand<string> optCommand;

	private bool enableUpgrade;

	private long coinDataAmount;

	private bool isLackGold;

	private bool isUpgradeConfigError;

	private bool isLackLevel;

	private int coinNeed;

	private int levelOld;

	private int levelNew;

	private int conditionLevel;

	public long CoinDataAmount
	{
		get
		{
			return coinDataAmount;
		}
		private set
		{
			Set(ref coinDataAmount, value, "CoinDataAmount");
		}
	}

	public int CoinNeed
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

	public int LevelOld
	{
		get
		{
			return levelOld;
		}
		private set
		{
			Set(ref levelOld, value, "LevelOld");
		}
	}

	public int LevelNew
	{
		get
		{
			return levelNew;
		}
		private set
		{
			Set(ref levelNew, value, "LevelNew");
		}
	}

	public bool IsLackGold
	{
		get
		{
			return isLackGold;
		}
		private set
		{
			Set(ref isLackGold, value, "IsLackGold");
		}
	}

	public bool IsLackLevel
	{
		get
		{
			return isLackLevel;
		}
		private set
		{
			Set(ref isLackLevel, value, "IsLackLevel");
		}
	}

	public bool EnableUpgrade
	{
		get
		{
			return enableUpgrade;
		}
		private set
		{
			Set(ref enableUpgrade, value, "EnableUpgrade");
		}
	}

	public int ConditionLevel
	{
		get
		{
			return conditionLevel;
		}
		private set
		{
			Set(ref conditionLevel, value, "ConditionLevel");
		}
	}

	public List<CastingMaterialItemData> MaterialItemDatas => materialItemDatas;

	public IInteractionRequest UpdateMaterialRequest => updateMaterialRequest;

	public ICommand OptCommand => optCommand;

	public HomelandUpgradeViewModel()
	{
	}

	public HomelandUpgradeViewModel(OptionBase parent, int curLevel, DRHomeLandLevelInfo levelInfo)
	{
		base.parent = parent;
		updateMaterialRequest = new InteractionRequest();
		optCommand = new SimpleCommand<string>(OnOpt);
		InitLevelInfo(curLevel, levelInfo);
	}

	public void InitLevelInfo(int curLevel, DRHomeLandLevelInfo levelInfo)
	{
		if (levelOld != curLevel)
		{
			EnableUpgrade = true;
			LevelOld = curLevel;
			LevelNew = curLevel + 1;
			materialItemDatas.Clear();
			ConditionLevel = levelInfo.AccountLevelNeed;
			int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
			EnableUpgrade = level >= conditionLevel;
			IsLackLevel = level < conditionLevel;
			if (levelInfo.NeedItem.Count != levelInfo.NeedItemCount.Count)
			{
				isUpgradeConfigError = true;
				Log.Error($"HomeLandLevelInfo表，Id【{LevelNew}】，道具数量不匹配！");
				return;
			}
			CoinDataAmount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin);
			updateMaterialRequest.Raise();
			CoinNeed = levelInfo.MoneyNeed;
			IsLackGold = coinDataAmount < coinNeed;
			EnableUpgrade = !isLackLevel && !isLackGold && !isUpgradeConfigError;
		}
	}

	public void InitCoinInfo()
	{
		CoinDataAmount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin);
		IsLackGold = coinDataAmount < coinNeed;
		EnableUpgrade = !isLackLevel && !isLackGold && !isUpgradeConfigError;
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OnUpgradeLevel".Equals(optName) && EnableUpgrade)
		{
			parent.ItemOnClick(new OptionArg(null, "OnUpgradeLevel"));
		}
		else if ("OnClose".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(null, "OnCloseUpgradeLevel"));
		}
		else
		{
			optCommand.Enabled = true;
		}
	}

	public void EnableOpt()
	{
		optCommand.Enabled = true;
	}
}
