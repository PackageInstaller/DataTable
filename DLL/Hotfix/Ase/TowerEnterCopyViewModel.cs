using System.Collections.Generic;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class TowerEnterCopyViewModel : OptionBase
{
	private SimpleCommand<string> optCmd;

	private StringBuilder strBuilder = new StringBuilder(4);

	private int areaIndex;

	private List<TowerCopyItemViewModel> copyItemVms;

	private TowerCopyItemViewModel selectItem;

	private List<int> curbpList = new List<int>(2) { 0, 0 };

	private HeroModel selectHeroModel;

	private int _skinConfigId;

	private int teamSetId;

	private int heroTryIndex;

	private bool rewardRedPoint;

	private string rewardNum;

	private int activityTypeId;

	private List<ActivityTaskData> towerTaskDatas;

	private int selectHeroId;

	private string heroSkinSuffix;

	private TeamBPConfigViewModel bpConfigViewModel;

	private readonly InteractionRequest changeSelectRequest;

	private TowerCopyDetailViewModel towerCopyDetailViewModel;

	public int SelectHeroId
	{
		get
		{
			return selectHeroId;
		}
		set
		{
			Set(ref selectHeroId, value, "SelectHeroId");
		}
	}

	public string HeroSkinSuffix
	{
		get
		{
			return heroSkinSuffix;
		}
		set
		{
			Set(ref heroSkinSuffix, value, "HeroSkinSuffix");
		}
	}

	public TowerCopyItemViewModel SelectLevelItem
	{
		get
		{
			return selectItem;
		}
		set
		{
			Set(ref selectItem, value, "SelectLevelItem");
		}
	}

	public TeamBPConfigViewModel BpConfigViewModel => bpConfigViewModel;

	public List<TowerCopyItemViewModel> CopyItemVms => copyItemVms;

	public IInteractionRequest ChangeSelectRequest => changeSelectRequest;

	public TowerCopyDetailViewModel CopyDetailViewModel => towerCopyDetailViewModel;

	public int AreaIndex => areaIndex;

	public CopyData CopyData => selectItem.CopyData;

	public SimpleCommand<string> OptCmd
	{
		get
		{
			return optCmd;
		}
		set
		{
			optCmd = value;
		}
	}

	public List<ActivityTaskData> TowerTaskDatas
	{
		get
		{
			return towerTaskDatas;
		}
		set
		{
			towerTaskDatas = value;
		}
	}

	public bool RewardRedPoint
	{
		get
		{
			return rewardRedPoint;
		}
		set
		{
			Set(ref rewardRedPoint, value, "RewardRedPoint");
		}
	}

	public string RewardNum
	{
		get
		{
			return rewardNum;
		}
		set
		{
			Set(ref rewardNum, value, "RewardNum");
		}
	}

	public HeroModel SelectHeroModel
	{
		get
		{
			return selectHeroModel;
		}
		set
		{
			Set(ref selectHeroModel, value, "SelectHeroModel");
			SkinConfigId = ((!value.IsNullOrEmpty()) ? value.SkinConfigId : 0);
		}
	}

	public int SkinConfigId
	{
		get
		{
			return _skinConfigId;
		}
		set
		{
			Set(ref _skinConfigId, value, "SkinConfigId");
		}
	}

	public TowerEnterCopyViewModel(OptionBase parent, List<TowerCopyItemViewModel> towerCopyItemViewModels, int index, List<ActivityTaskData> towerTaskDatas, int lastPlayCopyId, int activityTypeId)
	{
		OptCmd = new SimpleCommand<string>(OnOpt);
		changeSelectRequest = new InteractionRequest();
		base.parent = parent;
		copyItemVms = towerCopyItemViewModels;
		towerCopyDetailViewModel = new TowerCopyDetailViewModel(this);
		areaIndex = index;
		this.towerTaskDatas = towerTaskDatas;
		this.activityTypeId = activityTypeId;
		bpConfigViewModel = new TeamBPConfigViewModel(this, curbpList);
		GetDefaultSelect(lastPlayCopyId);
		SetRewardRedPointImg();
		SetRewardText();
	}

	private void SetRewardText()
	{
		int num = 0;
		for (int i = 0; i < towerTaskDatas.Count; i++)
		{
			if (towerTaskDatas[i].CompleteState == 1)
			{
				num++;
			}
		}
		RewardNum = $"<color=#ffc962>{num}</color>/{towerTaskDatas.Count}";
	}

	public void SetRewardRedPointImg()
	{
		RewardRedPoint = SetRewardRedPoint();
	}

	private bool SetRewardRedPoint()
	{
		if (parent is TowerActivityAreaViewModel towerActivityAreaViewModel)
		{
			towerActivityAreaViewModel.InitTowerDatas();
		}
		for (int i = 0; i < towerTaskDatas.Count; i++)
		{
			if (towerTaskDatas[i].CompleteState == 1 && towerTaskDatas[i].RewardState == 0)
			{
				RewardRedPoint = true;
				break;
			}
			RewardRedPoint = false;
		}
		return RewardRedPoint;
	}

	private void OnOpt(string optName)
	{
		if ("OpenRewardWindow".Equals(optName))
		{
			int maxActivityRank = (parent as TowerActivityAreaViewModel).MaxActivityRank;
			TowerRewardViewModel userData = new TowerRewardViewModel(this, maxActivityRank, TowerTaskDatas, activityTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(TowerRewardWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TowerCopyItemViewModel towerCopyItemViewModel)
		{
			for (int i = 0; i < copyItemVms.Count; i++)
			{
				if (copyItemVms[i] == towerCopyItemViewModel)
				{
					copyItemVms[i].SelectLevel = true;
					SelectLevelItem = towerCopyItemViewModel;
					ChangeCopyDetailViewModel(towerCopyItemViewModel.CopyData, towerCopyItemViewModel.FinishLevel, towerCopyItemViewModel.UnLock);
				}
				else
				{
					copyItemVms[i].SelectLevel = false;
				}
			}
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is HeroSelectionViewModel heroSelectionViewModel)
		{
			if (heroSelectionViewModel.Result == null)
			{
				return;
			}
			heroSelectionViewModel.Result.TryGetValue(0, out var value);
			int num = 0;
			if (value != null)
			{
				if (num != value.HeroModel.Id || !(heroSkinSuffix == value.HeroModel.SkinSuffix) || teamSetId != value.TeamSetId || heroTryIndex != value.HeroTryId)
				{
					SelectHeroModel = value.HeroModel;
					SelectHeroId = SelectHeroModel.Id;
					HeroSkinSuffix = SelectHeroModel.SkinSuffix;
					teamSetId = value.TeamSetId;
					heroTryIndex = value.TryHeroIndex;
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetTowerBattleConfig(SelectHeroId, teamSetId, curbpList);
				}
			}
			else
			{
				SelectHeroModel = null;
				SelectHeroId = 0;
				HeroSkinSuffix = string.Empty;
				teamSetId = 0;
				heroTryIndex = 0;
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetTowerBattleConfig(SelectHeroId, teamSetId, curbpList);
			}
		}
		else
		{
			if (!(obj is BattlePropConfigViewModel userData))
			{
				return;
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropConfigWindow), userData), delegate
			{
				bpConfigViewModel.Refresh(selectItem.CopyData.Id);
				List<int> bPIds = bpConfigViewModel.GetBPIds();
				if (bPIds[0] != curbpList[0] || bPIds[1] != curbpList[1])
				{
					curbpList = bPIds;
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetTowerBattleConfig(selectHeroId, teamSetId, curbpList);
				}
			});
		}
	}

	public void OpenHeroSelectWindow()
	{
		HeroTrySelectionViewModel heroTrySelectionViewModel = new HeroTrySelectionViewModel(this, selectItem.CopyData.TeamSeatId);
		heroTrySelectionViewModel.SetSelectHero(selectHeroId, heroTryIndex, teamSetId);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroSelection2Window), heroTrySelectionViewModel), delegate
		{
		});
	}

	private void GetDefaultSelect(int lastPlayCopyId)
	{
		TowerCopyItemViewModel towerCopyItemViewModel = null;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (lastPlayCopyId != 0)
			{
				if (copyItemVms[i].CopyData.Id == lastPlayCopyId)
				{
					towerCopyItemViewModel = copyItemVms[i];
				}
			}
			else if (copyItemVms[i].UnLock)
			{
				towerCopyItemViewModel = copyItemVms[i];
			}
			copyItemVms[i].SetParent(this);
		}
		if (towerCopyItemViewModel == null)
		{
			towerCopyItemViewModel = copyItemVms[0];
		}
		towerCopyItemViewModel.SelectLevel = true;
		SelectLevelItem = towerCopyItemViewModel;
		ChangeCopyDetailViewModel(towerCopyItemViewModel.CopyData);
	}

	private void ChangeCopyDetailViewModel(CopyData copyData, bool finishLevel = false, bool unlock = true)
	{
		CopyDetailViewModel.ChangeViewModel(copyData, finishLevel, unlock);
	}

	public void EnterBattle()
	{
		if (selectHeroId == 0)
		{
			Toast.ShowInfo("未配置英雄");
			return;
		}
		int copyId = copyItemVms[0].CopyId;
		CopyData copyData = copyItemVms[0].CopyData;
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().PlayTower(copyData, dataRow.CopyRank, 0, "Outer/Outer", sendTowerBattleData: true);
	}
}
