#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CopySecondType5ViewModel : CopyEnterViewModel
{
	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private Dictionary<int, List<CopyRankItemViewModel>> rankVms;

	private List<CopyTypeItemViewModel> typeVms;

	private Dictionary<int, List<CopyItemViewModel>> copyItemVms;

	private CopyData data;

	private int zone;

	private long totalScore;

	private long curScore;

	private string timeLeft = "";

	private bool red;

	private List<int> adItemList;

	private CopyST4RewardViewModel rewardVM;

	private List<CopyReward4ItemViewModel> rewardVmList = new List<CopyReward4ItemViewModel>();

	private CopyViewModel copyVM;

	private CopyTypeItemViewModel curTypeSelect;

	private CopyHeroSelectViewModel heroSelectVM;

	private string buffIcon;

	private CopyItemViewModel curSelectItem;

	private bool isOpenList;

	private string ruleDesc;

	private CopyST5EnterItemViewModel copySt5EnterItemVM;

	private SelectBuffViewModel selectBuffVM;

	private bool isChecking;

	public long TotalScore
	{
		get
		{
			return totalScore;
		}
		private set
		{
			Set(ref totalScore, value, "TotalScore");
		}
	}

	public long CurScore
	{
		get
		{
			return curScore;
		}
		private set
		{
			Set(ref curScore, value, "CurScore");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		private set
		{
			Set(ref red, value, "Red");
		}
	}

	public bool IsOpenList
	{
		get
		{
			return isOpenList;
		}
		private set
		{
			Set(ref isOpenList, value, "IsOpenList");
		}
	}

	public string TimeLeft
	{
		get
		{
			return timeLeft;
		}
		private set
		{
			Set(ref timeLeft, value, "TimeLeft");
		}
	}

	public CopyItemViewModel CurSelectItem
	{
		get
		{
			return curSelectItem;
		}
		private set
		{
			Set(ref curSelectItem, value, "CurSelectItem");
		}
	}

	public string RuleDesc
	{
		get
		{
			return ruleDesc;
		}
		set
		{
			ruleDesc = value;
		}
	}

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyTypeItemViewModel> TypeVms => typeVms;

	public ICommand OptCommand => optCommand;

	public CopyST4RewardViewModel RewardVm => rewardVM;

	public List<CopyItemViewModel> CopyItemVms
	{
		get
		{
			if (curTypeSelect != null)
			{
				return copyItemVms[curTypeSelect.Data.CopyTypeId];
			}
			return null;
		}
	}

	public List<CopyRankItemViewModel> RankItemVms
	{
		get
		{
			if (curTypeSelect != null)
			{
				return rankVms[curTypeSelect.Data.CopyTypeId];
			}
			return null;
		}
	}

	public List<int> AdItemList => adItemList;

	public CopyST5EnterItemViewModel CopySt5EnterItemVm
	{
		get
		{
			return copySt5EnterItemVM;
		}
		private set
		{
			Set(ref copySt5EnterItemVM, value, "CopySt5EnterItemVm");
		}
	}

	public SelectBuffViewModel SelectBuffVM
	{
		get
		{
			return selectBuffVM;
		}
		private set
		{
			Set(ref selectBuffVM, value, "SelectBuffVM");
		}
	}

	public string BuffIcon
	{
		get
		{
			return buffIcon;
		}
		private set
		{
			Set(ref buffIcon, value, "BuffIcon");
		}
	}

	public CopyHeroSelectViewModel HeroSelectVm => heroSelectVM;

	public CopySecondType5ViewModel(OptionBase parent, int zone)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		typeVms = new List<CopyTypeItemViewModel>();
		copyItemVms = new Dictionary<int, List<CopyItemViewModel>>();
		rankVms = new Dictionary<int, List<CopyRankItemViewModel>>();
		copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		heroSelectVM = new CopyHeroSelectViewModel(this);
		selectBuffVM = new SelectBuffViewModel(this);
		RefreshAllCopys(zone);
		if (curTypeSelect == null)
		{
			TimeLeft = "";
		}
		else
		{
			TimeLeft = Utility.DateTime.GetLeftDateHour(curTypeSelect.Data.EndTime - copyVM.GetCurTime(), "dd\\天hh\\时") ?? "";
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().typeRefreshAction = delegate(long curTime)
		{
			OnCheckTypeRefresh(curTime);
		};
		DRGameExplain dataRow = GameEntry.DataTable.GetDataRow<DRGameExplain>(3001);
		ruleDesc = ((dataRow == null) ? "" : dataRow.Content.Replace("\\n", "\n"));
	}

	public override async void ItemOnClick(object obj)
	{
		if (obj is CopyTypeItemViewModel itemVm)
		{
			SaveTeamLocal();
			await OpenCopyType(itemVm);
			int copyTypeId = curTypeSelect.Data.CopyTypeId;
			AddTeamConfig(copyTypeId);
		}
		else if (obj is CopyItemViewModel itemVm2)
		{
			SelectCopy(itemVm2);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is CopyReward4ItemViewModel reward5ItemVm)
		{
			GetRewards(reward5ItemVm);
		}
		else if ("OpenSingle".Equals(obj))
		{
			OnOpt("OpenEnter");
		}
		else if ("ReturnSingle".Equals(obj))
		{
			OnOpt("ReturnEnter");
		}
		else if ("OpenAddBuff".Equals(obj))
		{
			OnOpt("OpenAddBuff");
		}
		else
		{
			if (obj is CopyHeroItemViewModel heroItemViewModel)
			{
				SelectHeroInConfig(heroItemViewModel);
				RefreshHeroSelectVm();
				return;
			}
			if (obj is OptionArg optionArg)
			{
				if (optionArg.OptionName.Equals("OpenBpConfig"))
				{
					CopyST5EnterItemViewModel item = (CopyST5EnterItemViewModel)optionArg.Obj;
					openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropConfigWindow), item.BPConfigVM), delegate
					{
						copySt5EnterItemVM.BpConfigViewModel.RefreshCopyType5(item.CopyTypeId);
						copySt5EnterItemVM.SetBpList();
						copySt5EnterItemVM.RemoveCofigVM();
					});
				}
				else
				{
					if ("SelectBuffConfirm".Equals(optionArg.OptionName))
					{
						int num = (int)optionArg.Obj;
						copySt5EnterItemVM.SetBuff(num);
						BuffIcon = GetBuffIcon(num);
						return;
					}
					if ("ResetTeam".Equals(optionArg.OptionName))
					{
						SendServerReset();
						return;
					}
					if ("OpenTeamConfigView".Equals(optionArg.OptionName))
					{
						OpenTeamConfigView();
						return;
					}
					if ("SortTeam".Equals(optionArg.OptionName))
					{
						List<int> heroListInt = copySt5EnterItemVM.GetHeroListInt();
						heroSelectVM.SortHeroList(heroListInt, null);
						Dictionary<int, CopyType5Team> curTeamConfig = GetCurTeamConfig();
						RefreshHeroInPrefig(curTeamConfig);
						return;
					}
					if ("UnselectTeamHero".Equals(optionArg.OptionName))
					{
						if (optionArg.Obj is CopyTeamItemViewModel teamItemVm && copySt5EnterItemVM != null)
						{
							UnselectTeamHero(teamItemVm);
						}
						return;
					}
					if ("SelectPrefig".Equals(optionArg.OptionName))
					{
						if (optionArg.Obj is CopyTeamViewModel copyTeam && copySt5EnterItemVM != null)
						{
							Dictionary<int, CopyType5Team> curTeamConfig2 = GetCurTeamConfig();
							if (SelectTeamInPrefig(copyTeam, curTeamConfig2))
							{
								RefreshHeroSelectVm();
								RefreshHeroInPrefig(curTeamConfig2);
							}
						}
						return;
					}
				}
			}
		}
		base.ItemOnClick(obj);
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenList".Equals(optName))
		{
			IsOpenList = !isOpenList;
		}
		else if ("CloseList".Equals(optName))
		{
			IsOpenList = false;
			optCommand.Enabled = true;
		}
		else
		{
			if ("HideTeamView".Equals(optName))
			{
				RefreshAllTeams();
				HideTeamView();
				optRequest.Raise("HideTeamView");
				optCommand.Enabled = true;
				return;
			}
			if ("OpenReward".Equals(optName))
			{
				try
				{
					if (rewardVM == null)
					{
						rewardVM = new CopyST4RewardViewModel(this, $"{totalScore}", rewardVmList, 5);
						optRequest.Raise("OpenReward");
						rewardVM.IsVisible = true;
					}
					else
					{
						rewardVM.RefreshData($"{totalScore}");
						optRequest.Raise("OpenReward");
						rewardVM.IsVisible = true;
					}
					optCommand.Enabled = true;
				}
				catch (Exception ex)
				{
					Log.Error("打开奖励界面失败！" + ex.Message + "/" + ex.StackTrace);
					optCommand.Enabled = true;
				}
			}
			else if ("OpenEnter".Equals(optName))
			{
				await EnterSingle();
			}
			else if ("OpenAddBuff".Equals(optName))
			{
				OpenAddBuff();
			}
			else if ("OpenRank".Equals(optName))
			{
				try
				{
					int mainType = Singleton<ServiceSystem>.Instance.GetService<IRankService>().GetLatestRaceCopyConfig()?.Id ?? 1;
					RankViewModel rankVm = new RankViewModel(this, mainType, curSelectItem.Data.CopyType);
					await rankVm.RequestHeroChallengeData();
					openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), rankVm), delegate
					{
						optCommand.Enabled = true;
					});
				}
				catch (Exception)
				{
					optCommand.Enabled = true;
				}
			}
		}
		optCommand.Enabled = true;
	}

	private async Task OpenCopyType(CopyTypeItemViewModel itemVm)
	{
		curTypeSelect.SetSelect(isSelect: false);
		curTypeSelect = itemVm;
		curTypeSelect.SetSelect(isSelect: true);
		CurScore = curTypeSelect.Data.CurScore;
		int typeId = itemVm.Data.CopyTypeId;
		List<CopyData> newDatas = curTypeSelect.Data.CopyDataList;
		if (!copyItemVms.ContainsKey(typeId))
		{
			copyItemVms.Add(typeId, new List<CopyItemViewModel>());
			int i;
			for (i = 0; i < newDatas.Count; i++)
			{
				float rate = 0f;
				DRCopyScore dataRow = GameEntry.DataTable.GetDataRow((DRCopyScore p) => p.CopyType == typeId && p.CopyRank == newDatas[i].CopyRank);
				if (dataRow == null)
				{
					Log.Error($"CopyScore表查找积分倍率失败，找不到CopyType为【{typeId}】，CopyRank为【{newDatas[i].CopyRank}】的数据！");
				}
				else
				{
					rate = dataRow.Times;
				}
				CopyItemViewModel item = new CopyItemViewModel(this, newDatas[i], rate);
				copyItemVms[typeId].Add(item);
			}
			SelectLastCopy();
			rankVms.Add(typeId, new List<CopyRankItemViewModel>());
		}
		else
		{
			for (int num = 0; num < copyItemVms[typeId].Count; num++)
			{
				if (copyItemVms[typeId][num].IsSelect)
				{
					CurSelectItem = copyItemVms[typeId][num];
					adItemList = curSelectItem.Data.GetBuffsReverseOrder();
				}
			}
		}
		await GetRankList();
		optRequest.Raise("RefreshCopyItems");
	}

	private void SelectCopy(CopyItemViewModel itemVm)
	{
		if (!itemVm.IsSelect && !itemVm.Data.IsLock)
		{
			if (curSelectItem != null)
			{
				curSelectItem.SetSelect(isSelect: false);
			}
			CurSelectItem = itemVm;
			curSelectItem.SetSelect(isSelect: true);
			IsOpenList = false;
			SaveSelectCopy();
		}
	}

	private void SelectLastCopy()
	{
		int copyTypeId = curTypeSelect.Data.CopyTypeId;
		if (!copyItemVms.ContainsKey(copyTypeId))
		{
			return;
		}
		List<CopyItemViewModel> list = copyItemVms[copyTypeId];
		int t5CopySelect = copyVM.GetT5CopySelect(copyTypeId);
		CopyItemViewModel copyItemViewModel = null;
		CopyItemViewModel copyItemViewModel2 = null;
		bool flag = false;
		for (int i = 0; i < list.Count; i++)
		{
			CopyItemViewModel copyItemViewModel3 = list[i];
			if (!flag && !copyItemViewModel3.Data.IsLock)
			{
				copyItemViewModel = copyItemViewModel3;
				flag = true;
			}
			if (t5CopySelect == copyItemViewModel3.Data.Id && !copyItemViewModel3.Data.IsLock)
			{
				copyItemViewModel2 = copyItemViewModel3;
			}
		}
		if (copyItemViewModel2 != null)
		{
			copyItemViewModel = copyItemViewModel2;
		}
		CurSelectItem = copyItemViewModel;
		curSelectItem.SetSelect(isSelect: true);
		adItemList = curSelectItem.Data.GetBuffsReverseOrder();
	}

	private void SaveSelectCopy()
	{
		copyVM.SaveT5CopySelect(curSelectItem.Data.CopyType, curSelectItem.Data.Id);
	}

	private async UniTask OnCheckTypeRefresh(long curTime)
	{
		if (isChecking)
		{
			return;
		}
		isChecking = true;
		if (curTypeSelect != null)
		{
			if (curTypeSelect.Data.EndTime == 0L)
			{
				TimeLeft = "";
				return;
			}
			if (copyVM.CheckTypeOpen(curTypeSelect.Data))
			{
				long leftTime = curTypeSelect.Data.EndTime - curTime;
				TimeLeft = Utility.DateTime.GetLeftDateHour(leftTime, "dd\\天hh\\时") ?? "";
				return;
			}
			int zoneNew = copyVM.T5Zone;
			if (zoneNew == 0)
			{
				Close();
				return;
			}
			Loading loading = await Loading.Show();
			try
			{
				await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyInfo();
			}
			catch (Exception)
			{
				Close();
				return;
			}
			finally
			{
				loading.Dispose();
			}
			RefreshAllCopys(zoneNew);
			long leftTime2 = curTypeSelect.Data.EndTime - curTime;
			TimeLeft = Utility.DateTime.GetLeftDateHour(leftTime2, "dd\\天hh\\时") ?? "";
			GetRankList();
			optRequest.Raise("RefreshCopyItems");
			optRequest.Raise("RefreshCopyTypeItems");
		}
		else
		{
			TimeLeft = "";
		}
	}

	public void RefreshAllCopys(int zone)
	{
		try
		{
			this.zone = zone;
			typeVms.Clear();
			curTypeSelect = null;
			List<CopyTypeData> type5ZoneAllCopyType = copyVM.GetType5ZoneAllCopyType(this.zone);
			for (int i = 0; i < type5ZoneAllCopyType.Count; i++)
			{
				int copyTypeId = type5ZoneAllCopyType[i].CopyTypeId;
				if (copyVM.CheckTypeOpen(type5ZoneAllCopyType[i]))
				{
					CopyType5Team teamConfig = GetTeamConfig(copyTypeId, type5ZoneAllCopyType[i]);
					teamConfig.SetTeamTag(i + 1);
					CopyTypeItemViewModel item = CopyTypeItemViewModel.CreateType5(this, type5ZoneAllCopyType[i], teamConfig);
					if (curTypeSelect == null && !type5ZoneAllCopyType[i].IsLock)
					{
						curTypeSelect = item;
						curTypeSelect.SetSelect(isSelect: true);
					}
					typeVms.Add(item);
				}
			}
			copyItemVms.Clear();
			rankVms.Clear();
			int typeId = curTypeSelect.Data.CopyTypeId;
			AddTeamConfig(typeId);
			List<CopyData> newDatas = curTypeSelect.Data.CopyDataList;
			copyItemVms.Add(typeId, new List<CopyItemViewModel>());
			rankVms.Add(typeId, new List<CopyRankItemViewModel>());
			curSelectItem = null;
			int j;
			for (j = 0; j < newDatas.Count; j++)
			{
				float rate = 0f;
				DRCopyScore dataRow = GameEntry.DataTable.GetDataRow((DRCopyScore p) => p.CopyType == typeId && p.CopyRank == newDatas[j].CopyRank);
				if (dataRow == null)
				{
					Log.Error($"CopyScore表查找积分倍率失败，找不到CopyType为【{typeId}】，CopyRank为【{newDatas[j].CopyRank}】的数据！");
				}
				else
				{
					rate = dataRow.Times;
				}
				CopyItemViewModel item2 = new CopyItemViewModel(this, newDatas[j], rate);
				copyItemVms[typeId].Add(item2);
			}
			SelectLastCopy();
			GetCopyTypeReward();
		}
		catch (Exception)
		{
		}
	}

	public async Task OnJump()
	{
		TotalScore = copyVM.GetType5TotalScore();
		Dictionary<int, bool> t5RewardState = copyVM.T5RewardState;
		if (rewardVmList != null && rewardVmList.Count > 0)
		{
			for (int i = 0; i < rewardVmList.Count; i++)
			{
				if (t5RewardState.ContainsKey(rewardVmList[i].Id) && t5RewardState[rewardVmList[i].Id])
				{
					rewardVmList[i].SetState(3);
					continue;
				}
				long score = 0L;
				if (rewardVmList[i].CheckType == 1)
				{
					for (int j = 0; j < typeVms.Count; j++)
					{
						if (rewardVmList[i].CopyZoneType == typeVms[j].Data.CopyTypeId)
						{
							score = typeVms[j].Data.TotalScore;
							break;
						}
					}
				}
				if (rewardVmList[i].CheckScore(score, totalScore))
				{
					rewardVmList[i].SetState(1);
				}
				else
				{
					rewardVmList[i].SetState(2);
				}
			}
			rewardVmList.Sort(new CopyReward4ItemVmSort());
		}
		CurScore = curTypeSelect.Data.CurScore;
		optRequest.Raise("RefreshCopyItems");
		if (rankVms != null)
		{
			rankVms.Clear();
		}
		await GetRankList();
		CheckRed();
	}

	private void ResetScore()
	{
		OnJump();
	}

	private async UniTask EnterSingle()
	{
		if (copySt5EnterItemVM.EnvironId == 0)
		{
			OnOpt("OpenAddBuff");
			optCommand.Enabled = true;
			return;
		}
		int num = 0;
		if (copySt5EnterItemVM.TeamItemList != null)
		{
			for (int i = 0; i < copySt5EnterItemVM.TeamItemList.Count; i++)
			{
				if (i == 0 && copySt5EnterItemVM.TeamItemList[i].HeroId == 0)
				{
					AlertDialog.Show("提示", "每个队伍需要配置主控烬天使才能出战", "确定", null).Callbackable().OnCallback(delegate
					{
						optCommand.Enabled = true;
					});
					return;
				}
				if (copySt5EnterItemVM.TeamItemList[i].HeroId != 0)
				{
					num++;
				}
			}
		}
		if (num < 2)
		{
			AlertDialog.Show("提示", "至少配置2名烬天使才能出战", "确定", null).Callbackable().OnCallback(delegate
			{
				optCommand.Enabled = true;
			});
		}
		else if (!copySt5EnterItemVM.BPEnough())
		{
			string message = (copySt5EnterItemVM.BPCountEnough() ? "当前队伍中的战斗道具数量不足,是否要继续挑战" : "当前队伍中的战斗道具尚未配置齐全，是否要继续挑战");
			IAsyncResult<int> result = AlertDialog.Show("提示", message, "确定", "取消");
			result.Callbackable().OnCallback(async delegate
			{
				if (result.Result == -1)
				{
					await CheckEnter();
				}
				else
				{
					optCommand.Enabled = true;
				}
			});
		}
		else
		{
			await CheckEnter();
		}
	}

	private async UniTask CheckEnter()
	{
		if (!copySt5EnterItemVM.IsBlock)
		{
			IAsyncResult<int> confirmResult = AlertDialog.Show("提示", "开始战斗后将锁定当前出战的烬天使！除非使用重置功能，否则在当期肃清裂隙的其他挑战中不可重复使用已锁定的烬天使。", "确定", "取消");
			confirmResult.Callbackable().OnCallback(async delegate
			{
				if (confirmResult.Result == -1)
				{
					await EnterSingleInternal();
				}
				else
				{
					optCommand.Enabled = true;
				}
			});
		}
		else
		{
			await EnterSingleInternal();
		}
	}

	private async UniTask EnterSingleInternal()
	{
		_ = 1;
		try
		{
			SaveTeamLocal();
			if (await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetRaceCopyTroop(copySt5EnterItemVM.TeamConfig))
			{
				copySt5EnterItemVM.SetBlock(block: true);
				copySt5EnterItemVM.SetCopyId(curSelectItem.Data.Id);
				if (!(await EnterBattleWorld(copySt5EnterItemVM)))
				{
					Toast.ShowInfo("进入战斗失败！请重试！");
				}
				optCommand.Enabled = true;
			}
			else
			{
				Toast.ShowInfo("锁定队伍失败！请重试！");
				optCommand.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("进入战斗失败！请重试！");
			Log.Error("进入战斗失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private async void SendServerReset()
	{
		optCommand.Enabled = false;
		IAsyncResult<int> confirmResult = AlertDialog.Show("提示", "是否确认重置当前挑战的队伍配置？重置后，当前挑战的积分和排行榜排名将被清空，当期肃清裂隙的历史最高总积分及其总积分排行榜排名不变，仍可领取本期达成的积分奖励。", "确定", "取消");
		confirmResult.Callbackable().OnCallback(async delegate
		{
			if (confirmResult.Result == -1)
			{
				copySt5EnterItemVM.SetBuff(0);
				BuffIcon = "";
				copySt5EnterItemVM.ResetTeam();
				SaveTeamLocal();
				if (await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().ResetRaceCopyTroop(copySt5EnterItemVM.CopyTypeId))
				{
					Toast.ShowInfo("重置成功！");
					ResetScore();
				}
				optCommand.Enabled = true;
			}
			else
			{
				optCommand.Enabled = true;
			}
		});
	}

	private CopyType5Team GetTeamConfig(int copyType, CopyTypeData copyTypeData = null)
	{
		try
		{
			if (copyVM.Type5TeamConfigs == null)
			{
				copyVM.LoadT5LocalTeam();
			}
			if (copyVM.Type5TeamConfigs.ContainsKey(copyType))
			{
				return copyVM.Type5TeamConfigs[copyType];
			}
			if (copyTypeData == null)
			{
				copyTypeData = copyVM.GetCopyTypeById(5, copyType);
			}
			CopyType5Team copyType5Team = CopyType5Team.CreateEmpty(copyType, copyTypeData.EndTime);
			copyVM.SetType5TeamConfig(copyType5Team);
			return copyType5Team;
		}
		catch (Exception)
		{
		}
		return CopyType5Team.CreateEmpty(copyType, 0L);
	}

	private void SaveTeamLocal()
	{
		if (copyVM != null)
		{
			copySt5EnterItemVM.Save();
			copyVM.SaveType5TeamConfigLocal(copySt5EnterItemVM.TeamConfig);
			curTypeSelect.SetTeamConfig(copySt5EnterItemVM.TeamConfig);
		}
	}

	private void AddTeamConfig(int typeId)
	{
		int teamTag = 0;
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (typeVms[i].Data.CopyTypeId == typeId)
			{
				teamTag = i + 1;
			}
		}
		CopyType5Team teamConfig = GetTeamConfig(typeId);
		teamConfig.SetTeamTag(teamTag);
		if (copySt5EnterItemVM == null)
		{
			copySt5EnterItemVM = new CopyST5EnterItemViewModel(this, teamConfig);
		}
		else
		{
			copySt5EnterItemVM.RefreshData(teamConfig);
		}
		BuffIcon = GetBuffIcon(copySt5EnterItemVM.EnvironId);
	}

	private void OpenAddBuff()
	{
		try
		{
			if (selectBuffVM.CopyType != curTypeSelect.Data.CopyTypeId)
			{
				List<DRRecommend> list = new List<DRRecommend>();
				if (curTypeSelect != null && curTypeSelect.Data.ZoneEnvironIds != null && curTypeSelect.Data.ZoneEnvironIds.Count > 0)
				{
					for (int i = 0; i < curTypeSelect.Data.ZoneEnvironIds.Count; i++)
					{
						int environId = curTypeSelect.Data.ZoneEnvironIds[i];
						DRRecommend dataRow = GameEntry.DataTable.GetDataRow((DRRecommend p) => p.AssociatedId == environId);
						if (dataRow == null)
						{
							Log.Error($"找不到Recommend配置 {environId}，副本类型{curTypeSelect.Data.CopyTypeId}");
						}
						else
						{
							list.Add(dataRow);
						}
					}
				}
				selectBuffVM.RefreshRecommends(list, curTypeSelect.Data.CopyTypeId);
				optRequest.Raise("RefreshBuffList");
			}
			selectBuffVM.SetShow(copySt5EnterItemVM.EnvironId);
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开Buff选择失败！请重试！");
			Log.Error("打开Buff选择失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private string GetBuffIcon(int buffId)
	{
		if (buffId == 0)
		{
			return "";
		}
		return $"UIBuff_{buffId}";
	}

	private void OpenTeamConfigView()
	{
		copySt5EnterItemVM.SetHighlight(isHighlight: true);
		heroSelectVM.SortHeroList(copySt5EnterItemVM.GetHeroListInt(), null);
		InitHeroSelectVm();
		Dictionary<int, CopyType5Team> curTeamConfig = GetCurTeamConfig();
		RefreshHeroInPrefig(curTeamConfig);
		optRequest.Raise("OpenTeamView");
	}

	private void InitHeroSelectVm()
	{
		if (heroSelectVM == null)
		{
			return;
		}
		for (int i = 0; i < heroSelectVM.HeroItemViewModels.Count; i++)
		{
			heroSelectVM.HeroItemViewModels[i].ResetAllTag();
		}
		Dictionary<int, CopyType5Team> type5TeamConfigs = copyVM.Type5TeamConfigs;
		for (int j = 0; j < typeVms.Count; j++)
		{
			int copyTypeId = typeVms[j].Data.CopyTypeId;
			if (!type5TeamConfigs.ContainsKey(copyTypeId))
			{
				continue;
			}
			CopyType5Team copyType5Team = type5TeamConfigs[copyTypeId];
			List<int> heroList = copyType5Team.HeroList;
			if (heroList == null)
			{
				continue;
			}
			for (int k = 0; k < heroList.Count; k++)
			{
				int num = heroList[k];
				if (num == 0)
				{
					continue;
				}
				int seatIndex = k + 1;
				for (int l = 0; l < heroSelectVM.HeroItemViewModels.Count; l++)
				{
					if (heroSelectVM.HeroItemViewModels[l].HeroModel.Id == num)
					{
						heroSelectVM.HeroItemViewModels[l].SetTag(copyType5Team.TeamTag, seatIndex);
						heroSelectVM.HeroItemViewModels[l].SetBlock(copyType5Team.IsBlock);
						break;
					}
				}
			}
		}
	}

	private void RefreshHeroSelectVm()
	{
		if (copySt5EnterItemVM == null || heroSelectVM == null || copySt5EnterItemVM.IsBlock)
		{
			return;
		}
		List<int> list = copySt5EnterItemVM?.GetHeroListInt();
		for (int i = 0; i < heroSelectVM.HeroItemViewModels.Count; i++)
		{
			if (!heroSelectVM.HeroItemViewModels[i].IsBlock && heroSelectVM.HeroItemViewModels[i].HaveTag && heroSelectVM.HeroItemViewModels[i].TagIndex == copySt5EnterItemVM.TeamTag)
			{
				heroSelectVM.HeroItemViewModels[i].ResetAllTag();
			}
		}
		if (list != null)
		{
			for (int j = 0; j < list.Count; j++)
			{
				int num = list[j];
				if (num == 0)
				{
					continue;
				}
				int seatIndex = j + 1;
				for (int k = 0; k < heroSelectVM.HeroItemViewModels.Count; k++)
				{
					if (heroSelectVM.HeroItemViewModels[k].HeroModel.Id == num)
					{
						heroSelectVM.HeroItemViewModels[k].SetTag(copySt5EnterItemVM.TeamTag, seatIndex);
						break;
					}
				}
			}
		}
		heroSelectVM.CancelCurSelect();
	}

	private void RefreshAllTeams()
	{
		Dictionary<int, List<int>> dictionary = new Dictionary<int, List<int>>();
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (!GetTeamConfig(typeVms[i].Data.CopyTypeId, typeVms[i].Data).IsBlock)
			{
				dictionary.Add(typeVms[i].TeamTag, new List<int> { 0, 0, 0 });
			}
		}
		for (int j = 0; j < heroSelectVM.HeroItemViewModels.Count; j++)
		{
			CopyHeroItemViewModel copyHeroItemViewModel = heroSelectVM.HeroItemViewModels[j];
			if (copyHeroItemViewModel.HaveTag && dictionary.ContainsKey(copyHeroItemViewModel.TagIndex))
			{
				int tagIndex = copyHeroItemViewModel.TagIndex;
				int seatTag = copyHeroItemViewModel.SeatTag;
				if (tagIndex == 0 || seatTag <= 0 || seatTag > 3)
				{
					Log.Error($"英雄选则数据不合法 teamTag：{tagIndex} seatIndex：{seatTag}");
				}
				else
				{
					dictionary[tagIndex][seatTag - 1] = copyHeroItemViewModel.HeroModel.Id;
				}
			}
		}
		for (int k = 0; k < typeVms.Count; k++)
		{
			int copyTypeId = typeVms[k].Data.CopyTypeId;
			int teamTag = typeVms[k].TeamTag;
			CopyType5Team teamConfig = GetTeamConfig(copyTypeId, typeVms[k].Data);
			if (!teamConfig.IsBlock)
			{
				List<int> roleIds = dictionary[teamTag];
				teamConfig.RefreshData(roleIds, isBlock: false);
				typeVms[k].SetTeamConfig(teamConfig);
			}
		}
		copyVM.SaveType5TeamConfigLocal();
	}

	public void HideTeamView()
	{
		if (copySt5EnterItemVM != null)
		{
			copySt5EnterItemVM.SetHighlight(isHighlight: false);
		}
	}

	private void RefreshHeroInPrefig(Dictionary<int, CopyType5Team> curTeamConfig)
	{
		heroSelectVM.RefreshHeroInPrefig(copySt5EnterItemVM.TeamTag, curTeamConfig);
	}

	private bool SelectTeamInPrefig(CopyTeamViewModel copyTeam, Dictionary<int, CopyType5Team> curTeamConfig)
	{
		List<HeroModel> list = new List<HeroModel>();
		HeroModel[] unlockedTeamHerosBySlot = new HeroModel[copyTeam.HeroItemViewModels.Count];
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < copyTeam.HeroItemViewModels.Count; i++)
		{
			CopyHeroItemViewModel copyHeroItemViewModel = copyTeam.HeroItemViewModels[i];
			if (copyHeroItemViewModel == null)
			{
				continue;
			}
			HeroModel heroModel = copyHeroItemViewModel.HeroModel;
			list.Add(heroModel);
			if (heroModel != null && heroModel.Id != 0)
			{
				num++;
				if (copyHeroItemViewModel.IsBlock)
				{
					num2++;
				}
				else
				{
					unlockedTeamHerosBySlot[i] = heroModel;
				}
			}
		}
		if (num2 > 0 && num > 0)
		{
			if (num2 >= num)
			{
				Toast.ShowInfo("该预设烬天使已在其他挑战出战");
				return false;
			}
			IAsyncResult<int> confirmResult = AlertDialog.Show("提示", "所选队伍中有已锁定的烬天使，是否使用剩下的烬天使作为队伍配置？", "确定", "取消");
			confirmResult.Callbackable().OnCallback(delegate
			{
				if (confirmResult.Result == -1)
				{
					HashSet<int> selectedHeroIds = ApplyUnlockedTeamAsCurrent(unlockedTeamHerosBySlot);
					RemoveHeroesFromOtherTeams(selectedHeroIds, curTeamConfig);
					RefreshHeroSelectVm();
					RefreshHeroInPrefig(curTeamConfig);
				}
			});
			return false;
		}
		copySt5EnterItemVM.SetHero(list);
		HashSet<int> hashSet = new HashSet<int>();
		for (int num3 = 0; num3 < list.Count; num3++)
		{
			HeroModel heroModel2 = list[num3];
			if (heroModel2 != null && heroModel2.Id != 0)
			{
				hashSet.Add(heroModel2.Id);
			}
		}
		RemoveHeroesFromOtherTeams(hashSet, curTeamConfig);
		return true;
	}

	private HashSet<int> ApplyUnlockedTeamAsCurrent(HeroModel[] unlockedTeamHerosBySlot)
	{
		HashSet<int> hashSet = new HashSet<int>();
		if (copySt5EnterItemVM == null)
		{
			return hashSet;
		}
		List<CopyTeamItemViewModel> teamItemList = copySt5EnterItemVM.TeamItemList;
		if (teamItemList != null)
		{
			for (int i = 0; i < teamItemList.Count; i++)
			{
				teamItemList[i]?.RefreshData(0, "", 0);
			}
		}
		if (unlockedTeamHerosBySlot != null && teamItemList != null)
		{
			int num = Mathf.Min(teamItemList.Count, unlockedTeamHerosBySlot.Length);
			for (int j = 0; j < num; j++)
			{
				HeroModel heroModel = unlockedTeamHerosBySlot[j];
				if (heroModel != null && heroModel.Id != 0)
				{
					teamItemList[j].RefreshData(heroModel.Id, heroModel.SkinSuffix, heroModel.SkinConfigId);
					hashSet.Add(heroModel.Id);
				}
			}
		}
		copySt5EnterItemVM.TeamConfig.RefreshData(copySt5EnterItemVM.GetHeroListInt(), isBlock: false);
		return hashSet;
	}

	private void RemoveHeroesFromOtherTeams(HashSet<int> selectedHeroIds, Dictionary<int, CopyType5Team> curTeamConfig)
	{
		if (copySt5EnterItemVM == null || selectedHeroIds == null || selectedHeroIds.Count <= 0 || curTeamConfig == null)
		{
			return;
		}
		foreach (KeyValuePair<int, CopyType5Team> item in curTeamConfig)
		{
			if (item.Value.TeamTag == copySt5EnterItemVM.TeamTag || item.Value.IsBlock)
			{
				continue;
			}
			List<int> heroList = item.Value.HeroList;
			for (int i = 0; i < heroList.Count; i++)
			{
				if (heroList[i] != 0 && selectedHeroIds.Contains(heroList[i]))
				{
					heroList[i] = 0;
				}
			}
		}
	}

	private Dictionary<int, CopyType5Team> GetCurTeamConfig()
	{
		Dictionary<int, CopyType5Team> type5TeamConfigs = copyVM.Type5TeamConfigs;
		Dictionary<int, CopyType5Team> dictionary = new Dictionary<int, CopyType5Team>();
		for (int i = 0; i < typeVms.Count; i++)
		{
			int copyTypeId = typeVms[i].Data.CopyTypeId;
			dictionary[copyTypeId] = type5TeamConfigs[copyTypeId];
		}
		return dictionary;
	}

	private void SelectHeroInConfig(CopyHeroItemViewModel heroItemViewModel)
	{
		if (copySt5EnterItemVM == null)
		{
			return;
		}
		if (!heroItemViewModel.IsSelected)
		{
			heroSelectVM.CancelCurSelect(heroItemViewModel);
			heroItemViewModel.SetSelected(value: true);
		}
		if (heroItemViewModel.IsBlock)
		{
			Toast.ShowInfo("该烬天使已在其他挑战出战");
			return;
		}
		if (heroItemViewModel.HaveTag && heroItemViewModel.TagIndex == copySt5EnterItemVM.TeamTag)
		{
			copySt5EnterItemVM.RemoveHero(heroItemViewModel.HeroModel.Id);
		}
		else
		{
			if (!copySt5EnterItemVM.AddHero(heroItemViewModel.HeroModel.Id, heroItemViewModel.HeroModel.SkinSuffix, heroItemViewModel.HeroModel.SkinConfigId))
			{
				Toast.ShowInfo("至多配置3名烬天使");
				return;
			}
			if (heroItemViewModel.HaveTag && heroItemViewModel.TagIndex != copySt5EnterItemVM.TeamTag)
			{
				heroItemViewModel.ResetAllTag();
			}
		}
		copySt5EnterItemVM.TeamConfig.RefreshData(copySt5EnterItemVM.GetHeroListInt(), isBlock: false);
	}

	private void UnselectTeamHero(CopyTeamItemViewModel teamItemVm)
	{
		int heroId = teamItemVm.HeroId;
		if (heroId != 0)
		{
			copySt5EnterItemVM.RemoveHero(heroId);
			heroSelectVM.CancelHeroSelectType5(heroId);
		}
	}

	private async Task GetRankList()
	{
		int copyType = curTypeSelect.Data.CopyTypeId;
		if (rankVms == null)
		{
			rankVms = new Dictionary<int, List<CopyRankItemViewModel>>();
		}
		if (!rankVms.ContainsKey(copyType))
		{
			rankVms.Add(copyType, new List<CopyRankItemViewModel>());
		}
		if (rankVms[copyType].Count > 0)
		{
			optRequest.Raise("RefreshCopyRanks");
			return;
		}
		optRequest.Raise("SetRankLoading");
		List<CopyPlayerRankData> list = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRankList(5, copyType);
		if (list == null)
		{
			rankVms[copyType].Clear();
			CreateEmptyRank(copyType, 0, 1);
			optRequest.Raise("RefreshCopyRanks");
			Log.Error("获取玩家排行数据失败，请重试！");
			Toast.ShowInfo("获取玩家排行数据失败，请重试！");
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			CopyRankItemViewModel item = new CopyRankItemViewModel(this, list[i].score, list[i].icon, list[i].iconFrame, list[i].iconTitle, list[i].index, list[i].playerName);
			rankVms[copyType].Add(item);
		}
		if (list.Count < 3)
		{
			CreateEmptyRank(copyType, list.Count, 1);
		}
		optRequest.Raise("RefreshCopyRanks");
	}

	private void CreateEmptyRank(int copyType, int curCount, int emptyCount)
	{
		for (int i = 0; i < emptyCount; i++)
		{
			CopyRankItemViewModel item = new CopyRankItemViewModel(this, curCount + i + 1);
			rankVms[copyType].Add(item);
		}
	}

	private void GetCopyTypeReward()
	{
		rewardVmList = new List<CopyReward4ItemViewModel>();
		DRScoreReward[] dataRows = GameEntry.DataTable.GetDataRows((DRScoreReward p) => p.ScoreTaskTarget == zone);
		if (dataRows == null)
		{
			Log.Error($"找不到区域星级奖励数据 区域：{zone}");
		}
		else
		{
			AddRewardsList(dataRows, "总积分达到");
		}
		int i;
		for (i = 0; i < typeVms.Count; i++)
		{
			DRScoreReward[] dataRows2 = GameEntry.DataTable.GetDataRows((DRScoreReward p) => p.ScoreTaskTarget == typeVms[i].Data.CopyTypeId);
			if (dataRows2 == null)
			{
				Log.Error($"找不到区域星级奖励数据 副本类型：{typeVms[i].Data.CopyTypeId}");
			}
			else
			{
				AddRewardsList(dataRows2, "[" + typeVms[i].Data.CopyTypeName + "]积分达到");
			}
		}
		rewardVmList.Sort(new CopyReward4ItemVmSort());
	}

	private void AddRewardsList(DRScoreReward[] scoreRewards, string name)
	{
		for (int i = 0; i < scoreRewards.Length; i++)
		{
			DRScoreReward dRScoreReward = scoreRewards[i];
			if (dRScoreReward.ScoreReward.Count != dRScoreReward.ScoreRewardType.Count || dRScoreReward.ScoreReward.Count != dRScoreReward.ScoreRewardNum.Count)
			{
				Log.Error($"ScoreReward表，奖励配置长度不对，Id：{dRScoreReward.Id}");
			}
			List<PropDataBase> list = new List<PropDataBase>();
			for (int j = 0; j < dRScoreReward.ScoreReward.Count; j++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dRScoreReward.ScoreRewardType[j], dRScoreReward.ScoreReward[j], dRScoreReward.ScoreRewardNum[j]);
				if (propDataBase != null)
				{
					list.Add(propDataBase);
				}
				else
				{
					Log.Error($"ScoreReward表，奖励配置异常，Id：{dRScoreReward.Id}，找不到Prop Id为{dRScoreReward.ScoreReward[j]}的道具！");
				}
			}
			CopyReward4ItemViewModel copyReward4ItemViewModel = new CopyReward4ItemViewModel(this, name, scoreRewards[i].Id, scoreRewards[i].ScoreTaskTarget, scoreRewards[i].ScoreTaskNum, list);
			rewardVmList.Add(copyReward4ItemViewModel);
			copyReward4ItemViewModel.SetCheckType(dRScoreReward.ScoreTaskType);
			if (copyVM.GetReward5State(scoreRewards[i].Id))
			{
				copyReward4ItemViewModel.SetState(3);
			}
		}
	}

	private async Task GetRewards(CopyReward4ItemViewModel reward5ItemVm)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		Loading loading = await Loading.Show();
		try
		{
			RewardThings rewardThings = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyReward(reward5ItemVm.Id);
			loading.Dispose();
			if (rewardThings != null)
			{
				PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				reward5ItemVm.SetState(3);
				copyVM.SetReward5State(reward5ItemVm.Id, get: true);
				CheckRed();
				rewardVM.Sort();
				rewardVmList.Sort(new CopyReward4ItemVmSort());
			}
		}
		catch (Exception)
		{
			loading.Dispose();
		}
		optCommand.Enabled = true;
	}

	private void CheckRed()
	{
		bool flag = false;
		if (rewardVmList.Count > 0)
		{
			for (int i = 0; i < rewardVmList.Count; i++)
			{
				if (rewardVmList[i].State == 1)
				{
					flag = true;
					break;
				}
			}
		}
		Red = flag;
	}

	public override void Close()
	{
		SaveTeamLocal();
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}
}
