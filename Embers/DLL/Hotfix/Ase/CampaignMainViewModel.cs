#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CampaignMainViewModel : OptionBase
{
	private List<string> _msgList = new List<string>();

	private string _curMainTask;

	private string _curBranchTaskInfo;

	private string _pushTimeText;

	private string _lastTask1;

	private bool _showLastTask1;

	private string _lastTask2;

	private bool _showLastTask2;

	private string _curMainTaskIcon = "";

	private string _lastTaskIcon1 = "";

	private string _lastTaskIcon2 = "";

	private bool _haveNextTask;

	private SimpleCommand<string> _openWindowCmd;

	private InteractionRequest _refreshMsgListRst = new InteractionRequest();

	private string _pushTextFormat;

	private long _pushTime;

	private Timer _pushTimer;

	private ISubscription<CampaignMessage> _msgNotify;

	private string CampaignMainStoryCacheKey = "Campaign_CachedMainNode";

	private CampaignShopViewModel shopViewModel;

	private PropExchangeViewModel exchangeViewModel;

	private PropExchangeViewModel exchangeWeaponViewModel;

	private PropExchangeViewModel exchangePackViewModel;

	public List<string> MsgList => _msgList;

	public string CurMainTask
	{
		get
		{
			return _curMainTask;
		}
		set
		{
			Set(ref _curMainTask, value, "CurMainTask");
		}
	}

	public string CurBranchTaskInfo
	{
		get
		{
			return _curBranchTaskInfo;
		}
		set
		{
			Set(ref _curBranchTaskInfo, value, "CurBranchTaskInfo");
		}
	}

	public string PushTimeText
	{
		get
		{
			return _pushTimeText;
		}
		set
		{
			Set(ref _pushTimeText, value, "PushTimeText");
		}
	}

	public string LastTask1
	{
		get
		{
			return _lastTask1;
		}
		set
		{
			Set(ref _lastTask1, value, "LastTask1");
		}
	}

	public bool ShowLastTask1
	{
		get
		{
			return _showLastTask1;
		}
		set
		{
			Set(ref _showLastTask1, value, "ShowLastTask1");
		}
	}

	public string LastTask2
	{
		get
		{
			return _lastTask2;
		}
		set
		{
			Set(ref _lastTask2, value, "LastTask2");
		}
	}

	public bool ShowLastTask2
	{
		get
		{
			return _showLastTask2;
		}
		set
		{
			Set(ref _showLastTask2, value, "ShowLastTask2");
		}
	}

	public string CurMainTaskIcon
	{
		get
		{
			return _curMainTaskIcon;
		}
		set
		{
			Set(ref _curMainTaskIcon, value, "CurMainTaskIcon");
		}
	}

	public string LastTaskIcon1
	{
		get
		{
			return _lastTaskIcon1;
		}
		set
		{
			Set(ref _lastTaskIcon1, value, "LastTaskIcon1");
		}
	}

	public string LastTaskIcon2
	{
		get
		{
			return _lastTaskIcon2;
		}
		set
		{
			Set(ref _lastTaskIcon2, value, "LastTaskIcon2");
		}
	}

	public bool HaveNextTask
	{
		get
		{
			return _haveNextTask;
		}
		set
		{
			Set(ref _haveNextTask, value, "HaveNextTask");
		}
	}

	public SimpleCommand<string> OpenWindowCmd => _openWindowCmd;

	public InteractionRequest RefreshMsgListRst => _refreshMsgListRst;

	public CampaignShopViewModel ShopViewModel => shopViewModel;

	public CampaignMainViewModel()
	{
	}

	public CampaignMainViewModel(OptionBase parent)
	{
		base.parent = parent;
		IMessenger service = Context.GetApplicationContext().GetService<IMessenger>();
		_msgNotify = service.Subscribe<CampaignMessage>(OnMessage);
		_openWindowCmd = new SimpleCommand<string>(OpenWindow);
		shopViewModel = new CampaignShopViewModel(this)
		{
			CurTabIndex = CampaignService.GetMainShopId()
		};
		AddChild(shopViewModel);
		exchangeViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeViewModel);
		exchangeWeaponViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeWeaponViewModel);
		exchangePackViewModel = new PropExchangeViewModel(this);
		AddChild(exchangePackViewModel);
		CampaignServiceData.MainInfo mainInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetMainInfo();
		if (mainInfo != null)
		{
			RefreshData(mainInfo);
			TryPlayCurrentMainNodeStory(mainInfo);
		}
	}

	public async UniTask RequestData()
	{
		await shopViewModel.RequestData();
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ShopGoodItemData shopGoodItemData)
		{
			ShopDefinition.OnShopGoodItemClick(shopGoodItemData.ExcData, GetExchangeViewModel, this, "CampaignShop");
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				await OnConfirmExc(optionArg);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	private void OnMessage(CampaignMessage msg)
	{
		if (msg != null && msg.Type == CampaignMsgType.MainInfoRefresh)
		{
			CampaignServiceData.MainInfo mainInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetMainInfo();
			if (mainInfo != null)
			{
				RefreshData(mainInfo);
			}
		}
	}

	private void RefreshData(CampaignServiceData.MainInfo mainInfo)
	{
		if (mainInfo == null)
		{
			return;
		}
		CancelTimer();
		List<int> list = new List<int>();
		list.AddRange(mainInfo.MainTaskProgress);
		list.Sort();
		int count = list.Count;
		int curMainTask = ((count > 0) ? list[count - 1] : 0);
		int num = ((count > 1) ? list[count - 2] : 0);
		int num2 = ((count > 2) ? list[count - 3] : 0);
		DRCampaign dRCampaign = ((curMainTask > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(curMainTask) : null);
		DRCampaign dRCampaign2 = ((num > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(num) : null);
		DRCampaign dRCampaign3 = ((num2 > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(num2) : null);
		if (dRCampaign == null)
		{
			CurMainTask = "";
			HaveNextTask = false;
			PushTimeText = "";
		}
		else
		{
			CurMainTask = dRCampaign.StoryName;
			CurMainTaskIcon = ((dRCampaign.StoryTabIcon.Count > 1) ? dRCampaign.StoryTabIcon[1] : "");
			HaveNextTask = GameEntry.DataTable.GetDataRows((DRCampaign p) => p.NodeType == 1 && p.Id > curMainTask).Length != 0;
			_pushTime = (long)Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetLeftServiceTime(mainInfo.NextMainStageTime).TotalSeconds;
			_pushTextFormat = dRCampaign.PushText;
			StartTimer();
		}
		if (dRCampaign2 == null)
		{
			ShowLastTask1 = false;
		}
		else
		{
			LastTask1 = dRCampaign2.StoryName;
			LastTaskIcon1 = ((dRCampaign2.StoryTabIcon.Count > 0) ? dRCampaign2.StoryTabIcon[0] : "");
			ShowLastTask1 = true;
		}
		if (dRCampaign3 == null)
		{
			ShowLastTask2 = false;
		}
		else
		{
			LastTask2 = dRCampaign3.StoryName;
			LastTaskIcon2 = ((dRCampaign3.StoryTabIcon.Count > 0) ? dRCampaign3.StoryTabIcon[0] : "");
			ShowLastTask2 = true;
		}
		DRCampaign curBranchTaskConfig = mainInfo.GetCurBranchTaskConfig();
		if (curBranchTaskConfig == null)
		{
			CurBranchTaskInfo = "";
		}
		else
		{
			List<object> list2 = new List<object>();
			List<object> list3 = new List<object>();
			for (int num3 = 0; num3 < curBranchTaskConfig.CalcFactor.Count; num3++)
			{
				int num4 = curBranchTaskConfig.CalcFactor[num3];
				int symbolType = ((curBranchTaskConfig.ClacSymbol.Count > num3) ? curBranchTaskConfig.ClacSymbol[num3] : 0);
				int argNum = ((curBranchTaskConfig.CalcNum.Count > num3) ? curBranchTaskConfig.CalcNum[num3] : 0);
				long factorValue = ((num4 > 0) ? GetFactorValue(num4, mainInfo.BranchTaskProgressInfos).Item1 : 0);
				list2.Add(CampaignService.CalculateFactor(factorValue, symbolType, argNum, showDecimal: true));
			}
			for (int num5 = 0; num5 < curBranchTaskConfig.NodePaceFactor.Count; num5++)
			{
				int num6 = curBranchTaskConfig.NodePaceFactor[num5];
				int symbolType2 = ((curBranchTaskConfig.ClacSymbol.Count > num5) ? curBranchTaskConfig.ClacSymbol[num5] : 0);
				int argNum2 = ((curBranchTaskConfig.CalcNum.Count > num5) ? curBranchTaskConfig.CalcNum[num5] : 0);
				long factorValue2 = ((num6 > 0) ? GetFactorValue(num6, mainInfo.BranchTaskProgressInfos).Item2 : 0);
				list3.Add(CampaignService.CalculateFactor(factorValue2, symbolType2, argNum2, showDecimal: false));
			}
			CurBranchTaskInfo = string.Format(curBranchTaskConfig.TargetText, list2.ToArray()) + "\n" + string.Format(curBranchTaskConfig.NodePaceText, list3.ToArray());
			CurBranchTaskInfo = CurBranchTaskInfo.Replace("\\n", "\n");
		}
		RefreshMsgList(mainInfo);
		static (long, long) GetFactorValue(int id, List<CampaignServiceData.BranchTaskInfo> data)
		{
			CampaignServiceData.BranchTaskInfo branchTaskInfo = data.Find((CampaignServiceData.BranchTaskInfo p) => p.PlayId.Equals(id));
			if (branchTaskInfo != null)
			{
				return (branchTaskInfo.TotalValue, branchTaskInfo.YesterdayValue);
			}
			return (0L, 0L);
		}
	}

	private void RefreshMsgList(CampaignServiceData.MainInfo mainInfo)
	{
		if (mainInfo == null)
		{
			return;
		}
		_msgList.Clear();
		List<int> list = new List<int>();
		list.AddRange(mainInfo.MainTaskProgress);
		list.Sort();
		int count = list.Count;
		int num = ((count > 0) ? list[count - 1] : 0);
		DRCampaign dRCampaign = ((num > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(num) : null);
		if (dRCampaign != null)
		{
			_msgList.Add(dRCampaign.NodeTip);
		}
		List<int> list2 = new List<int>();
		list2.AddRange(mainInfo.BranchTaskProgress);
		list2.Sort();
		int count2 = list2.Count;
		int num2 = ((count2 > 0) ? list2[count2 - 1] : 0);
		DRCampaign dRCampaign2 = ((num2 > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(num2) : null);
		if (dRCampaign2 != null)
		{
			_msgList.Add(dRCampaign2.NodeTip);
		}
		foreach (CampaignServiceData.BossKillInfo bossKillInfo in mainInfo.BossKillInfos)
		{
			DRCampaignLevel dataRow = GameEntry.DataTable.GetDataRow((DRCampaignLevel p) => p.CopyId.Equals(bossKillInfo.CopyId));
			if (dataRow != null)
			{
				if (bossKillInfo.ReportType == 1)
				{
					List<string> playerNames = bossKillInfo.PlayerNames;
					string text = ((playerNames.Count > 0) ? playerNames[0] : "");
					string text2 = ((playerNames.Count > 1) ? ("、" + playerNames[1]) : "");
					string text3 = ((playerNames.Count > 2) ? ("、" + playerNames[2]) : "");
					_msgList.Add(text + text2 + text3 + "成功击退" + dataRow.Name + "，为赤潮守备战做出卓越贡献！");
				}
				else if (bossKillInfo.ReportType == 2)
				{
					_msgList.Add(dataRow.ClearTips);
				}
			}
		}
		_refreshMsgListRst.Raise();
	}

	private PropExchangeViewModel GetExchangeViewModel(ShopExcData excData)
	{
		return excData.Prop.PropTypeEnum switch
		{
			PropTypeEnum.GiftPack => exchangePackViewModel, 
			PropTypeEnum.Weapon => exchangeWeaponViewModel, 
			_ => exchangeViewModel, 
		};
	}

	private async UniTask OnConfirmExc(OptionArg optionArg)
	{
		if (optionArg.Obj is PropExchangeViewModel propExchangeViewModel)
		{
			await ShopDefinition.OnExchangeConfirm(this, propExchangeViewModel, shopViewModel, null);
		}
	}

	private async void OpenWindow(string target)
	{
		_openWindowCmd.Enabled = false;
		switch (target)
		{
		case "Rule":
		{
			DRGameExplain dataRow = GameEntry.DataTable.GetDataRow<DRGameExplain>(7005);
			if (dataRow == null)
			{
				Callback(null);
				break;
			}
			string title = dataRow.Title;
			string content = dataRow.Content;
			GamePlayTipsViewModel userData3 = new GamePlayTipsViewModel(this, title, content);
			openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData3), Callback);
			break;
		}
		case "Timeline":
		{
			List<int> campaignIds = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().GetMainInfo()?.MainTaskProgress;
			CampaignTimelineViewModel userData2 = new CampaignTimelineViewModel(this, campaignIds);
			openWindowRequest.Raise(new OpenViewArg(typeof(CampaignTimelineWindow), userData2), Callback);
			break;
		}
		case "Start":
			try
			{
				if (!(Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetCampaignOpenState() ?? false))
				{
					Toast.ShowInfo("尊敬的传火者大人，活动已结束，期待下次再见");
					Callback(null);
				}
				else if (await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestCampaignDetailInfo() == null)
				{
					Callback(null);
				}
				else
				{
					CampaignMapViewModel userData = new CampaignMapViewModel(this);
					openWindowRequest.Raise(new OpenViewArg(typeof(CampaignMapWindow), userData), Callback);
				}
				break;
			}
			catch (Exception ex)
			{
				Log.Error(ex?.ToString() + ex.StackTrace);
				Callback(null);
				break;
			}
		}
		void Callback(OpenViewArg arg)
		{
			_openWindowCmd.Enabled = true;
		}
	}

	protected override void Dispose(bool disposing)
	{
		CancelTimer();
		_msgNotify?.Dispose();
		_msgNotify = null;
		base.Dispose(disposing);
	}

	private void StartTimer()
	{
		_pushTimer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
	}

	private void OnComplete()
	{
		_pushTime--;
		if (_pushTime <= 0)
		{
			_pushTime = 0L;
			CancelTimer();
		}
		DateTime localDateTime = TimeHelper.GetLocalDateTime(_pushTime);
		PushTimeText = string.Format(_pushTextFormat, localDateTime.ToString("dd天HH时mm分"));
	}

	private void CancelTimer()
	{
		if (_pushTimer != null)
		{
			_pushTimer.Cancel();
			_pushTimer = null;
		}
	}

	private void TryPlayCurrentMainNodeStory(CampaignServiceData.MainInfo mainInfo)
	{
		DRCampaign currentCampaignConfig = GetCurrentCampaignConfig(mainInfo?.MainTaskProgress);
		TryPlayCampaignNodeStory(currentCampaignConfig, CampaignMainStoryCacheKey);
	}

	private async void TryPlayCampaignNodeStory(DRCampaign campaignConfig, string cacheKey)
	{
		if (campaignConfig == null || campaignConfig.Id <= 0)
		{
			return;
		}
		int currentNode = campaignConfig.Id;
		if (PlayerPrefs.GetInt(cacheKey, 0) == currentNode)
		{
			return;
		}
		try
		{
			if (campaignConfig.CurStory == null)
			{
				return;
			}
			foreach (int item in campaignConfig.CurStory)
			{
				if (item > 0 && !(await Singleton<Story>.Instance.PlayStory(0u, item)))
				{
					break;
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		finally
		{
			PlayerPrefs.SetInt(cacheKey, currentNode);
			PlayerPrefs.Save();
		}
	}

	private static DRCampaign GetCurrentCampaignConfig(List<int> progressList)
	{
		if (progressList == null || progressList.Count <= 0)
		{
			return null;
		}
		int num = 0;
		for (int i = 0; i < progressList.Count; i++)
		{
			if (progressList[i] > num)
			{
				num = progressList[i];
			}
		}
		if (num <= 0)
		{
			return null;
		}
		return GameEntry.DataTable.GetDataRow<DRCampaign>(num);
	}
}
