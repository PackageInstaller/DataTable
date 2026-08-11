#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using GameFramework.Runtime;
using Unity.Mathematics;
using UnityEngine;

namespace Ase;

public class CopySecondType3ViewModel : CopyEnterViewModel
{
	public const int JumpParaMulti = 0;

	public const int JumpParaFirePower = 1;

	public const int JumpParaExtreme = 2;

	public const int JumpParaEntry = 3;

	private const int MultiRankTypeId = 1;

	private static readonly Color EntryCountAvailableColor = new Color(82f / 85f, 0.79607844f, 42f / 85f, 1f);

	private static readonly Color EntryCountEmptyColor = new Color(0.85490197f, 0.8235294f, 41f / 51f, 1f);

	private readonly InteractionRequest<CopyType3Page> pageRequest = new InteractionRequest<CopyType3Page>();

	private readonly InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private readonly SimpleCommand<string> optCommand;

	private readonly CopyType3Page initPage;

	private readonly CopySecondType3EntryViewModel entryViewModel;

	private readonly CopySecondType3FirePowerViewModel firePowerViewModel;

	private readonly CopySecondType3ExtremeViewModel extremeViewModel;

	private CopyType3Page currentPage;

	private CopyItemViewModel curSelectItem;

	private List<CopyItemViewModel> copyItemVms;

	private List<ReceiveItemViewModel> rewardItems;

	private List<int> adItemList;

	private readonly HashSet<int> teamTagPropIdSet = new HashSet<int>();

	private int currentMultiCopyType;

	private int currentFirePowerCopyType;

	private int currentExtremeCopyType;

	private int curEntryCount;

	private string entryCountText;

	private string entryCountDesc;

	private string curBossIcon;

	private string curBossIconPath;

	private string curBossNameAndLv;

	private string curCopyDesc;

	private int curRewardCountMax;

	private bool showFirstItem;

	private Color entryCountColor;

	private int score;

	private string timeLeft;

	private bool hasMonthlyCard;

	private ISubscription<ShopMessage> subscriptionShopMsg;

	public CopyType3Page CurrentPage => currentPage;

	public CopySecondType3EntryViewModel EntryViewModel => entryViewModel;

	public CopySecondType3FirePowerViewModel FirePowerViewModel => firePowerViewModel;

	public CopySecondType3ExtremeViewModel ExtremeViewModel => extremeViewModel;

	public IInteractionRequest PageRequest => pageRequest;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public CopyItemViewModel CurSelectItem
	{
		get
		{
			return curSelectItem;
		}
		private set
		{
			Set(ref curSelectItem, value, "CurSelectItem");
			RefreshCurSelectCopyDisplay();
		}
	}

	public List<CopyItemViewModel> CopyItemVms => copyItemVms;

	public List<ReceiveItemViewModel> RewardItems => rewardItems;

	public List<int> AdItemList => adItemList;

	public int CurEntryCount
	{
		get
		{
			return curEntryCount;
		}
		private set
		{
			Set(ref curEntryCount, value, "CurEntryCount");
		}
	}

	public string EntryCountText
	{
		get
		{
			return entryCountText;
		}
		private set
		{
			Set(ref entryCountText, value, "EntryCountText");
		}
	}

	public string EntryCountDesc
	{
		get
		{
			return entryCountDesc;
		}
		private set
		{
			Set(ref entryCountDesc, value, "EntryCountDesc");
		}
	}

	public Color EntryCountColor
	{
		get
		{
			return entryCountColor;
		}
		private set
		{
			Set(ref entryCountColor, value, "EntryCountColor");
		}
	}

	public int Score
	{
		get
		{
			return score;
		}
		private set
		{
			Set(ref score, value, "Score");
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

	public bool HasMonthlyCard
	{
		get
		{
			return hasMonthlyCard;
		}
		private set
		{
			Set(ref hasMonthlyCard, value, "HasMonthlyCard");
		}
	}

	public string CurBossIcon
	{
		get
		{
			return curBossIcon;
		}
		private set
		{
			Set(ref curBossIcon, value, "CurBossIcon");
		}
	}

	public string CurBossIconPath
	{
		get
		{
			return curBossIconPath;
		}
		private set
		{
			Set(ref curBossIconPath, value, "CurBossIconPath");
		}
	}

	public string CurBossNameAndLv
	{
		get
		{
			return curBossNameAndLv;
		}
		private set
		{
			Set(ref curBossNameAndLv, value, "CurBossNameAndLv");
		}
	}

	public string CurCopyDesc
	{
		get
		{
			return curCopyDesc;
		}
		private set
		{
			Set(ref curCopyDesc, value, "CurCopyDesc");
		}
	}

	public int CurRewardCountMax
	{
		get
		{
			return curRewardCountMax;
		}
		private set
		{
			Set(ref curRewardCountMax, value, "CurRewardCountMax");
		}
	}

	public bool ShowFirstItem
	{
		get
		{
			return showFirstItem;
		}
		private set
		{
			Set(ref showFirstItem, value, "ShowFirstItem");
		}
	}

	public CopySecondType3ViewModel()
		: this(null, CopyType3Page.Entry)
	{
	}

	public CopySecondType3ViewModel(OptionBase parent)
		: this(parent, CopyType3Page.Entry)
	{
	}

	public CopySecondType3ViewModel(OptionBase parent, int para)
		: this(parent, GetJumpPage(para))
	{
	}

	private CopySecondType3ViewModel(OptionBase parent, CopyType3Page initPage)
	{
		base.parent = parent;
		this.initPage = initPage;
		optCommand = new SimpleCommand<string>(OnOpt);
		entryViewModel = new CopySecondType3EntryViewModel(this);
		firePowerViewModel = new CopySecondType3FirePowerViewModel(this);
		extremeViewModel = new CopySecondType3ExtremeViewModel(this);
		Init();
	}

	private void Init()
	{
		copyItemVms = new List<CopyItemViewModel>();
		rewardItems = new List<ReceiveItemViewModel>();
		adItemList = new List<int>();
		currentPage = initPage;
		TimeLeft = "剩余" + Utility.DateTime.GetLeftDateHour(Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType3TimeLeft(), "dd\\天hh\\时");
		entryViewModel.SetTimeLeft(TimeLeft);
		List<CopyData> type3CopyDatas = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType3CopyDatas();
		if (type3CopyDatas != null && type3CopyDatas.Count > 0)
		{
			RefreshAllCopys(type3CopyDatas, Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T3Score);
			RegisterType3Refresh();
		}
	}

	public override void OnOpen()
	{
		base.OnOpen();
		Score = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T3Score;
		GetCurCount();
		EnableOpt();
		GetSingleModeViewModel(currentPage)?.OnPageActivated();
		pageRequest.Raise(currentPage);
	}

	public override void Close()
	{
		if (copyItemVms != null && copyItemVms.Count > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CancelAllCopyTypeRed(copyItemVms[0].Data.CopyType);
		}
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().type3RefreshAction = null;
		base.Close();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			switch (optionArg.OptionName)
			{
			case "OpenEntryView":
				SwitchPage(CopyType3Page.Entry);
				break;
			case "OpenMultiView":
				SwitchPage(CopyType3Page.Multi);
				break;
			case "OpenFirePowerView":
				SwitchPage(CopyType3Page.FirePower);
				break;
			case "OpenExtremeView":
				SwitchPage(CopyType3Page.Extreme);
				break;
			default:
				base.ItemOnClick(obj);
				break;
			}
		}
		else if (obj is CopyItemViewModel copyItemViewModel)
		{
			OpenCopy(copyItemViewModel);
			if (copyItemViewModel.Data.HasNew && !copyItemViewModel.Data.IsLock)
			{
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(copyItemViewModel.Data, isRed: false);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				OpenArmourSampleView((ArmourData)knapsackItemViewModel.PropDataBase);
				return;
			}
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.SuitBox)
			{
				OpenSuitBoxSampleView((ArmourData)knapsackItemViewModel.PropDataBase);
				return;
			}
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				base.ItemOnClick((object)openViewArg);
			}
		}
		else if ("ReturnSingle".Equals(obj))
		{
			if (currentPage == CopyType3Page.FirePower)
			{
				firePowerViewModel.ItemOnClick(obj);
			}
			else if (currentPage == CopyType3Page.Extreme)
			{
				extremeViewModel.ItemOnClick(obj);
			}
		}
		else if ("ReturnMulti".Equals(obj))
		{
			SwitchPage(CopyType3Page.Multi);
			optCommand.Execute("ReturnMulti");
		}
		else
		{
			_ = obj is OpenViewArg;
			base.ItemOnClick(obj);
		}
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (!jumpParams.WindowName.Equals("CopySecondType3Window"))
		{
			return true;
		}
		int para = ((jumpParams.Args != null && jumpParams.Args.Count > 0) ? ((int)jumpParams.Args[0]) : 0);
		if (optionBase != this)
		{
			optionBase?.Close();
		}
		SwitchPage(GetJumpPage(para));
		return false;
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		base.RefreshWhenBack(arg);
		GetSingleModeViewModel(currentPage)?.RefreshWhenBack(arg);
	}

	public void SwitchPage(CopyType3Page page)
	{
		currentPage = page;
		GetSingleModeViewModel(page)?.OnPageActivated();
		pageRequest.Raise(page);
	}

	private CopySecondType3SingleModeViewModelBase GetSingleModeViewModel(CopyType3Page page)
	{
		return page switch
		{
			CopyType3Page.FirePower => firePowerViewModel, 
			CopyType3Page.Extreme => extremeViewModel, 
			_ => null, 
		};
	}

	public void InitMonthlyCardInfo()
	{
		HasMonthlyCard = (Singleton<ServiceSystem>.Instance?.GetService<IShopService>()?.GetMonthlyCardLeftDay() ?? (-1)) >= 0;
		GetCurCount();
		if (subscriptionShopMsg != null)
		{
			RemoveMonthlyCardInfo();
		}
		subscriptionShopMsg = Context.GetApplicationContext()?.GetService<IMessenger>()?.Subscribe<ShopMessage>(OnShopMsg);
	}

	public void RemoveMonthlyCardInfo()
	{
		if (subscriptionShopMsg != null)
		{
			subscriptionShopMsg.Dispose();
			subscriptionShopMsg = null;
		}
	}

	public void EnableOpt()
	{
		optCommand.Enabled = true;
	}

	public void EnableOpenMulti()
	{
		EnableOpt();
	}

	private static CopyType3Page GetJumpPage(int para)
	{
		return para switch
		{
			0 => CopyType3Page.Multi, 
			1 => CopyType3Page.FirePower, 
			2 => CopyType3Page.Extreme, 
			3 => CopyType3Page.Entry, 
			_ => CopyType3Page.Entry, 
		};
	}

	private void RegisterType3Refresh()
	{
		CacheType3ModeCopyTypes();
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().type3RefreshAction = delegate
		{
			CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
			TimeLeft = "剩余" + Utility.DateTime.GetLeftDateHour(copyVM.GetType3ModeTimeLeft(CopyType3Mode.Multi), "dd\\天hh\\时");
			entryViewModel.SetTimeLeft(TimeLeft);
			int type3ModeCopyType = copyVM.GetType3ModeCopyType(CopyType3Mode.Multi);
			int type3ModeCopyType2 = copyVM.GetType3ModeCopyType(CopyType3Mode.FirePower);
			int type3ModeCopyType3 = copyVM.GetType3ModeCopyType(CopyType3Mode.ExtremeChallenge);
			bool flag = type3ModeCopyType != currentMultiCopyType;
			bool flag2 = type3ModeCopyType2 != currentFirePowerCopyType;
			bool flag3 = type3ModeCopyType3 != currentExtremeCopyType;
			if (flag || flag2 || flag3)
			{
				CacheType3ModeCopyTypes();
				if (flag)
				{
					List<CopyData> type3CopyDatas = copyVM.GetType3CopyDatas();
					if (type3CopyDatas == null || type3CopyDatas.Count == 0)
					{
						Close();
						return;
					}
					RefreshAllCopys(type3CopyDatas, copyVM.T3Score);
					optRequest.Raise("RefreshCopy");
				}
				if (flag2)
				{
					firePowerViewModel.OnPageActivated();
				}
				if (flag3)
				{
					extremeViewModel.OnPageActivated();
				}
			}
		};
	}

	private void CacheType3ModeCopyTypes()
	{
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		currentMultiCopyType = copyVM.GetType3ModeCopyType(CopyType3Mode.Multi);
		currentFirePowerCopyType = copyVM.GetType3ModeCopyType(CopyType3Mode.FirePower);
		currentExtremeCopyType = copyVM.GetType3ModeCopyType(CopyType3Mode.ExtremeChallenge);
	}

	private void OnShopMsg(ShopMessage msg)
	{
		if (msg != null && msg.Type == ShopMessageEnum.MonthlyCardInfoChanged)
		{
			HasMonthlyCard = (Singleton<ServiceSystem>.Instance?.GetService<IShopService>()?.GetMonthlyCardLeftDay() ?? (-1)) >= 0;
			GetCurCount();
		}
	}

	private void OpenArmourSampleView(ArmourData armourData)
	{
		ArmourPopupViewModel userData = new ArmourPopupViewModel(this, armourData);
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
	}

	private void OpenSuitBoxSampleView(ArmourData armourData)
	{
		SuitBoxPreviewUtil.FillPreviewEntriesIfEmpty(armourData);
		RockPopupViewModel userData = new RockPopupViewModel(this, armourData);
		openWindowRequest.Raise(new OpenViewArg(typeof(RockPopupSampleWindow), userData));
	}

	private void RefreshAllCopys(List<CopyData> copyDatas, int currentScore)
	{
		copyItemVms.Clear();
		for (int i = 0; i < copyDatas.Count; i++)
		{
			CopyItemViewModel copyItemViewModel = new CopyItemViewModel(this, copyDatas[i]);
			copyItemViewModel.SetBossNameAndLv();
			copyItemVms.Add(copyItemViewModel);
		}
		RefreshMultiRecommendState();
		if (copyItemVms.Count > 0)
		{
			int defaultMultiCopyIndex = GetDefaultMultiCopyIndex();
			copyItemVms[defaultMultiCopyIndex].SetSelect(isSelect: true);
			CurSelectItem = copyItemVms[defaultMultiCopyIndex];
			if (copyItemVms[defaultMultiCopyIndex].Data.HasNew)
			{
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(copyItemVms[defaultMultiCopyIndex].Data, isRed: false);
			}
		}
		adItemList = curSelectItem?.Data?.Buffs ?? new List<int>();
		RefreshRewardItems();
		Score = currentScore;
		GetCurCount();
	}

	private void RefreshMultiRecommendState()
	{
		int num = -1;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			CopyItemViewModel copyItemViewModel = copyItemVms[i];
			if (copyItemViewModel != null)
			{
				copyItemViewModel.SetRecommend(isRecommend: false);
				if (!copyItemViewModel.Data.IsLock)
				{
					num = i;
				}
			}
		}
		if (num >= 0)
		{
			copyItemVms[num].SetRecommend(isRecommend: true);
		}
	}

	private void OpenCopy(CopyItemViewModel itemVm)
	{
		if (itemVm.Data.IsLevelLock)
		{
			Toast.ShowInfo($"传火等级达到Lv{itemVm.Data.AdvLevel}解锁！");
		}
		else if (curSelectItem != itemVm)
		{
			curSelectItem?.SetSelect(isSelect: false);
			if (string.IsNullOrEmpty(itemVm.BossNameAndLv))
			{
				itemVm.SetBossNameAndLv();
			}
			CurSelectItem = itemVm;
			curSelectItem.SetSelect(isSelect: true);
			adItemList = curSelectItem.Data.Buffs ?? new List<int>();
			RefreshRewardItems();
			GetCurCount();
			optRequest.Raise("RefreshCopy");
		}
	}

	private void RefreshRewardItems()
	{
		rewardItems.Clear();
		if (curSelectItem?.Data == null)
		{
			return;
		}
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == curSelectItem.Data.Drops && p.DropeType == 0);
		if (dataRow == null || dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
		{
			return;
		}
		for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
			if (propDataBase == null)
			{
				Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
				continue;
			}
			ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
			RefreshTeamTag(receiveItemViewModel);
			receiveItemViewModel.SetCountRange((dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num) ? dataRow.PropNumShow[num] : string.Empty);
			rewardItems.Add(receiveItemViewModel);
		}
		if (!curSelectItem.Data.IsNeedFirst || dataRow.FirstDropShow.Count != dataRow.FirstDropType.Count || dataRow.FirstDropShow.Count != dataRow.FirstDropNum.Count)
		{
			return;
		}
		for (int num2 = 0; num2 < dataRow.FirstDropShow.Count; num2++)
		{
			PropDataBase propDataBase2 = PropDataBase.CreateByType(dataRow.FirstDropType[num2], dataRow.FirstDropShow[num2], dataRow.FirstDropNum[num2]);
			if (propDataBase2 != null)
			{
				ReceiveItemViewModel receiveItemViewModel2 = new ReceiveItemViewModel(propDataBase2, this);
				RefreshTeamTag(receiveItemViewModel2);
				receiveItemViewModel2.SetLock(isLock: true);
				receiveItemViewModel2.SetGot(curSelectItem.Data.IsAccessed);
				if (curSelectItem.Data.IsAccessed)
				{
					rewardItems.Add(receiveItemViewModel2);
				}
				else
				{
					rewardItems.Insert(num2, receiveItemViewModel2);
				}
			}
		}
	}

	public void SetTeamTagPropIds(List<int> propIds)
	{
		teamTagPropIdSet.Clear();
		if (propIds != null)
		{
			for (int i = 0; i < propIds.Count; i++)
			{
				if (propIds[i] > 0)
				{
					teamTagPropIdSet.Add(propIds[i]);
				}
			}
		}
		for (int j = 0; j < rewardItems.Count; j++)
		{
			RefreshTeamTag(rewardItems[j]);
		}
	}

	private void RefreshTeamTag(ReceiveItemViewModel item)
	{
		item?.SetTeam(item.PropDataBase != null && teamTagPropIdSet.Contains(item.PropDataBase.Id));
	}

	private void GetCurCount()
	{
		int maxCount = 0;
		if (curSelectItem?.Data == null)
		{
			CurEntryCount = 0;
			RefreshEntryCountDisplay(maxCount);
			return;
		}
		maxCount = (HasMonthlyCard ? (curSelectItem.Data.RewardCountMax + 1) : curSelectItem.Data.RewardCountMax);
		int t3ConsumeCount = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T3ConsumeCount;
		CurEntryCount = math.clamp(maxCount - t3ConsumeCount, 0, maxCount);
		RefreshEntryCountDisplay(maxCount);
	}

	private void RefreshEntryCountDisplay(int maxCount)
	{
		EntryCountDesc = "本周剩余掉落次数";
		EntryCountText = $"{CurEntryCount}/{maxCount}";
		EntryCountColor = ((CurEntryCount > 0) ? EntryCountAvailableColor : EntryCountEmptyColor);
	}

	private void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if (optName.Equals("OnMulti"))
		{
			OnMulti();
		}
		else if (optName.Equals("ReturnMulti"))
		{
			OnMulti(isReturn: true);
		}
		else if (optName.Equals("OnRank"))
		{
			OnRank();
		}
	}

	private async void OnMulti(bool isReturn = false)
	{
		_ = 1;
		try
		{
			if (curSelectItem?.Data == null || CopyEntryLimitHelper.TryBlockEntry(curSelectItem.Data, isMulti: true))
			{
				EnableOpt();
				return;
			}
			Loading loading = await Loading.Show();
			await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateMultiRoom(curSelectItem.Data, isReturn);
			loading.Dispose();
			EnableOpt();
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			EnableOpt();
		}
	}

	public void OnRank()
	{
		try
		{
			if (curSelectItem?.Data == null)
			{
				EnableOpt();
				return;
			}
			GameEntry.DataTable.GetDataRow<DRRankType>(1);
			GameEntry.DataTable.GetDataRows((DRRank p) => p.RankType == 1 && p.RankTarget == curSelectItem.Data.CopyType);
			RankViewModel userData = new RankViewModel(this, 1, curSelectItem.Data.CopyType);
			openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), userData), delegate
			{
				EnableOpt();
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开排行榜失败！" + ex.Message + " / " + ex.StackTrace);
			EnableOpt();
		}
	}

	public static List<CopyData> FilterCurrentMultiCopyDatas(List<CopyData> copyDatas)
	{
		if (copyDatas == null || copyDatas.Count <= 6)
		{
			return copyDatas;
		}
		List<CopyData> list = new List<CopyData>();
		int num = copyDatas[0].Id / 100;
		for (int i = 0; i < copyDatas.Count && copyDatas[i].Id / 100 == num; i++)
		{
			list.Add(copyDatas[i]);
		}
		if (list.Count <= 0)
		{
			return copyDatas;
		}
		return list;
	}

	private int GetDefaultMultiCopyIndex()
	{
		for (int num = copyItemVms.Count - 1; num >= 0; num--)
		{
			CopyItemViewModel copyItemViewModel = copyItemVms[num];
			if (copyItemViewModel?.Data != null && !copyItemViewModel.Data.IsLock && HasRewardDisplayConfig(copyItemViewModel.Data))
			{
				return num;
			}
		}
		for (int num2 = copyItemVms.Count - 1; num2 >= 0; num2--)
		{
			CopyItemViewModel copyItemViewModel2 = copyItemVms[num2];
			if (copyItemViewModel2?.Data != null && !copyItemViewModel2.Data.IsLock)
			{
				return num2;
			}
		}
		return 0;
	}

	private static bool HasRewardDisplayConfig(CopyData copyData)
	{
		if (copyData != null && copyData.Drops > 0)
		{
			return GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == copyData.Drops && p.DropeType == 0) != null;
		}
		return false;
	}

	private static string ReplaceDesc(string desc)
	{
		if (!string.IsNullOrEmpty(desc) && desc.Contains("\\n"))
		{
			using (Utf16ValueStringBuilder utf16ValueStringBuilder = ZString.CreateStringBuilder())
			{
				utf16ValueStringBuilder.Append(desc);
				utf16ValueStringBuilder.Replace("\\n", "\n");
				return utf16ValueStringBuilder.ToString();
			}
		}
		return desc ?? string.Empty;
	}

	private void RefreshCurSelectCopyDisplay()
	{
		CurBossIcon = CurSelectItem?.Data?.BossIcon ?? string.Empty;
		CurBossIconPath = CurSelectItem?.Data?.BossIconPath ?? "CopySceneImgOther";
		CurBossNameAndLv = CurSelectItem?.BossNameAndLv ?? string.Empty;
		CurCopyDesc = ReplaceDesc(CurSelectItem?.Data?.Desc);
		CurRewardCountMax = (CurSelectItem?.Data?.RewardCountMax).GetValueOrDefault();
		ShowFirstItem = CurSelectItem?.Data != null && CurSelectItem.Data.IsNeedFirst && !CurSelectItem.Data.IsAccessed;
	}
}
