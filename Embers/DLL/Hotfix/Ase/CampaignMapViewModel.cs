#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CampaignMapViewModel : OptionBase
{
	private SimpleCommand<string> _openWindowCmd;

	private List<CampaignAreaData> _areaDataList = new List<CampaignAreaData>();

	private string _curBranchTaskInfo;

	private bool _showSearchEffect;

	private string _pushTimeText;

	private string _pushTextFormat;

	private long _pushTime;

	private Timer _pushTimer;

	private InteractionRequest _refreshMatRst = new InteractionRequest();

	private InteractionRequest<List<CampaignAreaType>> _refreshAreaRst = new InteractionRequest<List<CampaignAreaType>>();

	private InteractionRequest<CampaignAreaData> _clickAreaRst = new InteractionRequest<CampaignAreaData>();

	private List<PropDataBase> _materials = new List<PropDataBase>();

	private bool openPropPopupWindowEnable = true;

	private InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> openPropPopupRst = new InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>>();

	private ChatBarViewModel chatBar;

	private ISubscription<CampaignMessage> _msgNotify;

	private string CampaignBranchStoryCacheKey = "Campaign_CachedBranchNode";

	private SimpleCommand<float> _searchMonsterCmd;

	private SimpleCommand<CampaignBuildingData> _upgradeBuildingCmd;

	public SimpleCommand<string> OpenWindowCmd => _openWindowCmd;

	public List<CampaignAreaData> AreaDataList => _areaDataList;

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

	public bool ShowSearchEffect
	{
		get
		{
			return _showSearchEffect;
		}
		set
		{
			Set(ref _showSearchEffect, value, "ShowSearchEffect");
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

	public InteractionRequest RefreshMatRst => _refreshMatRst;

	public InteractionRequest<List<CampaignAreaType>> RefreshAreaRst => _refreshAreaRst;

	public InteractionRequest<CampaignAreaData> ClickAreaRst => _clickAreaRst;

	public List<PropDataBase> Materials => _materials;

	public InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> OpenPropPopupRst => openPropPopupRst;

	public ChatBarViewModel ChatBar => chatBar;

	public SimpleCommand<float> SearchMonsterCmd => _searchMonsterCmd;

	public CampaignMapViewModel()
	{
	}

	public CampaignMapViewModel(OptionBase parent)
	{
		base.parent = parent;
		IMessenger service = Context.GetApplicationContext().GetService<IMessenger>();
		_msgNotify = service.Subscribe<CampaignMessage>(OnMessage);
		_searchMonsterCmd = new SimpleCommand<float>(TrySearchMonster);
		_upgradeBuildingCmd = new SimpleCommand<CampaignBuildingData>(TryUpgradeBuilding);
		_openWindowCmd = new SimpleCommand<string>(OpenWindow);
		chatBar = AddChild(new ChatBarViewModel(this));
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
		CampaignServiceData.MainInfo mainInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetMainInfo();
		if (mainInfo != null)
		{
			RefreshData(mainInfo);
			TryPlayCurrentBranchNodeStory(mainInfo);
		}
		CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
		if (detailInfo != null)
		{
			RefreshData(detailInfo);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ChatViewModel userData)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(ChatWindow), userData), delegate
			{
				chatBar?.ActiveChatCommand();
			});
		}
		else if (obj is CampaignAreaData areaData)
		{
			OnAreaClick(areaData);
		}
		else if (obj is OptionArg { Obj: var obj2 } optionArg)
		{
			if (obj2 is KeyValuePair<RoleMoneyEnum, Vector3> context && optionArg.OptionName == "OnIconBtnClick" && openPropPopupWindowEnable)
			{
				openPropPopupRst.Raise(context);
			}
		}
		else if (obj is CampaignBuildingInfoViewModel campaignBuildingInfoViewModel)
		{
			if (_upgradeBuildingCmd.Enabled)
			{
				_upgradeBuildingCmd.Execute(campaignBuildingInfoViewModel.Data);
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
		if (msg == null)
		{
			return;
		}
		if (msg.Type == CampaignMsgType.MainInfoRefresh)
		{
			CampaignServiceData.MainInfo mainInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetMainInfo();
			if (mainInfo != null)
			{
				RefreshData(mainInfo);
			}
		}
		else if (msg.Type == CampaignMsgType.DetailInfoRefresh)
		{
			CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
			if (detailInfo != null)
			{
				RefreshData(detailInfo);
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
		int num = ((mainInfo.MainTaskProgress.Count > 0) ? mainInfo.MainTaskProgress[mainInfo.MainTaskProgress.Count - 1] : 0);
		DRCampaign dRCampaign = ((num > 0) ? GameEntry.DataTable.GetDataRow<DRCampaign>(num) : null);
		if (dRCampaign == null)
		{
			PushTimeText = "";
			return;
		}
		_pushTime = (long)Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetLeftServiceTime(mainInfo.NextMainStageTime).TotalSeconds;
		_pushTextFormat = dRCampaign.PushText;
		StartTimer();
		RefreshMaterials(dRCampaign);
		DRCampaign curBranchTaskConfig = mainInfo.GetCurBranchTaskConfig();
		if (curBranchTaskConfig == null)
		{
			CurBranchTaskInfo = "";
			return;
		}
		List<object> list2 = new List<object>();
		List<object> list3 = new List<object>();
		for (int i = 0; i < curBranchTaskConfig.CalcFactor.Count; i++)
		{
			int num2 = curBranchTaskConfig.CalcFactor[i];
			int symbolType = ((curBranchTaskConfig.ClacSymbol.Count > i) ? curBranchTaskConfig.ClacSymbol[i] : 0);
			int argNum = ((curBranchTaskConfig.CalcNum.Count > i) ? curBranchTaskConfig.CalcNum[i] : 0);
			long factorValue = ((num2 > 0) ? GetFactorValue(num2, mainInfo.BranchTaskProgressInfos).Item1 : 0);
			list2.Add(CampaignService.CalculateFactor(factorValue, symbolType, argNum, showDecimal: true));
		}
		for (int j = 0; j < curBranchTaskConfig.NodePaceFactor.Count; j++)
		{
			int num3 = curBranchTaskConfig.NodePaceFactor[j];
			int symbolType2 = ((curBranchTaskConfig.ClacSymbol.Count > j) ? curBranchTaskConfig.ClacSymbol[j] : 0);
			int argNum2 = ((curBranchTaskConfig.CalcNum.Count > j) ? curBranchTaskConfig.CalcNum[j] : 0);
			long factorValue2 = ((num3 > 0) ? GetFactorValue(num3, mainInfo.BranchTaskProgressInfos).Item2 : 0);
			list3.Add(CampaignService.CalculateFactor(factorValue2, symbolType2, argNum2, showDecimal: false));
		}
		CurBranchTaskInfo = string.Format(curBranchTaskConfig.TargetText, list2.ToArray()) + "\n" + string.Format(curBranchTaskConfig.NodePaceText, list3.ToArray());
		CurBranchTaskInfo = CurBranchTaskInfo.Replace("\\n", "\n");
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

	private void RefreshData(CampaignServiceData.DetailInfo detailInfo)
	{
		if (detailInfo == null)
		{
			return;
		}
		_areaDataList.Clear();
		RefreshBuildingData(detailInfo.BuildingInfos, notify: false);
		foreach (CampaignServiceData.DailyTaskInfo dailyTaskInfo in detailInfo.DailyTaskInfos)
		{
			CampaignTaskData campaignTaskData = CampaignTaskData.CreateByServerData(this, dailyTaskInfo);
			if (campaignTaskData != null)
			{
				_areaDataList.Add(campaignTaskData);
			}
		}
		RefreshMonsterData(detailInfo.WorldBossInfos, null, notify: false);
		_refreshAreaRst.Raise(null);
	}

	private void RefreshBuildingData(List<CampaignServiceData.BuildingInfo> buildingInfos, bool notify)
	{
		if (buildingInfos == null)
		{
			return;
		}
		_areaDataList.RemoveAll((CampaignAreaData p) => p.Type.Equals(CampaignAreaType.Building));
		foreach (CampaignServiceData.BuildingInfo buildingInfo in buildingInfos)
		{
			CampaignBuildingData campaignBuildingData = CampaignBuildingData.CreateByServerData(this, buildingInfo);
			if (campaignBuildingData != null)
			{
				_areaDataList.Add(campaignBuildingData);
			}
		}
		if (notify)
		{
			_refreshAreaRst.Raise(new List<CampaignAreaType> { CampaignAreaType.Building });
		}
	}

	private void RefreshMonsterData(List<CampaignServiceData.WorldBossInfo> worldBossInfos, List<CampaignServiceData.WorldBossInfo> newSearchList, bool notify)
	{
		if (worldBossInfos == null)
		{
			return;
		}
		_areaDataList.RemoveAll((CampaignAreaData p) => p.Type == CampaignAreaType.EliteMonster || p.Type == CampaignAreaType.LordMonster || p.Type == CampaignAreaType.WorldBoss);
		foreach (CampaignServiceData.WorldBossInfo worldBossInfo in worldBossInfos)
		{
			CampaignMonsterData campaignMonsterData = CampaignMonsterData.CreateByServerData(this, worldBossInfo);
			if (campaignMonsterData != null)
			{
				_areaDataList.Add(campaignMonsterData);
				if (newSearchList != null && newSearchList.Exists((CampaignServiceData.WorldBossInfo p) => p.PlayId == worldBossInfo.PlayId && p.PointId == worldBossInfo.PointId))
				{
					campaignMonsterData.SearchNew = true;
				}
			}
		}
		if (notify)
		{
			_refreshAreaRst.Raise(new List<CampaignAreaType>
			{
				CampaignAreaType.EliteMonster,
				CampaignAreaType.LordMonster,
				CampaignAreaType.WorldBoss
			});
		}
	}

	private void RefreshMaterials(DRCampaign drCampaign)
	{
		if (drCampaign == null)
		{
			return;
		}
		_materials.Clear();
		for (int i = 0; i < drCampaign.ResIcon.Count; i++)
		{
			string icon = drCampaign.ResIcon[i];
			int num = ((drCampaign.ResProp.Count > i) ? drCampaign.ResProp[i] : 0);
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(num);
			if (dataRow != null)
			{
				int propOwnedCount = PropHelper.GetPropOwnedCount(num);
				PropDataBase item = new PropDataBase(dataRow, propOwnedCount)
				{
					Icon = icon
				};
				_materials.Add(item);
			}
		}
		_refreshMatRst.Raise();
	}

	private void RefreshMaterialCount()
	{
		if (_materials == null || _materials.Count <= 0)
		{
			return;
		}
		foreach (PropDataBase material in _materials)
		{
			int propOwnedCount = PropHelper.GetPropOwnedCount(material.Id);
			material.Amount = propOwnedCount;
		}
	}

	private void OnAreaClick(CampaignAreaData areaData)
	{
		_clickAreaRst.Raise(areaData);
	}

	private async void OnDailyUpdated()
	{
		ICampaignService service = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>();
		if (service != null)
		{
			Loading loading = await Loading.Show();
			CampaignServiceData.DetailInfo detailInfo = await service.RequestCampaignDetailInfo();
			loading?.Dispose();
			if (detailInfo != null)
			{
				RefreshData(detailInfo);
			}
		}
	}

	private void TrySearchMonster(float effectDuration)
	{
		ICampaignService service = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>();
		if (service == null)
		{
			Log.Error("ICampaignService不存在");
			return;
		}
		if (service == null || !service.GetCampaignOpenState())
		{
			Toast.ShowInfo("尊敬的传火者大人，活动已结束，期待下次再见");
			return;
		}
		if (service?.GetDetailInfo()?.ExistEliteMonster() == true)
		{
			Toast.ShowInfo("有尚未击败的精英辉烬兽，请传火者大人先击败当前精英辉烬兽");
			return;
		}
		DRCampaign dRCampaign = service.GetMainInfo()?.GetCurBranchTaskConfig();
		if (dRCampaign == null)
		{
			return;
		}
		PropDataBase propDataBase = PropDataBase.CreateByType(dRCampaign.ElitePropType, dRCampaign.ElitePropID, dRCampaign.ElitPropNum);
		if (propDataBase == null || propDataBase.Empty)
		{
			Log.Error($"无法根据Campaign表配置，创建对应的消耗道具数据:Type:{dRCampaign.ElitePropType} Id:{dRCampaign.ElitePropID} Count:{dRCampaign.ElitPropNum}");
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", $"是否消耗{dRCampaign.ElitPropNum}个{propDataBase.Name}，搜索一个精英辉烬兽的位置信息？\n注意，精英辉烬兽格外强大，推荐组队进行战斗！", "确定", "取消");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				RequestSearchMonster(effectDuration);
			}
		});
	}

	private async void RequestSearchMonster(float effectDuration)
	{
		_searchMonsterCmd.Enabled = false;
		Loading loading = await Loading.Show();
		List<CampaignServiceData.WorldBossInfo> result = await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestSearchBoss();
		loading?.Dispose();
		if (result == null)
		{
			_searchMonsterCmd.Enabled = true;
			return;
		}
		ShowSearchEffect = true;
		await UniTask.WaitForSeconds(effectDuration);
		OnSearchEffectFinished(result);
	}

	private void OnSearchEffectFinished(List<CampaignServiceData.WorldBossInfo> searchInfo)
	{
		ShowSearchEffect = false;
		CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
		if (detailInfo != null)
		{
			RefreshMonsterData(detailInfo.WorldBossInfos, searchInfo, notify: true);
		}
		RefreshMaterialCount();
		_searchMonsterCmd.Enabled = true;
	}

	private void TryUpgradeBuilding(CampaignBuildingData buildingData)
	{
		if (buildingData == null || !buildingData.IsUnlock)
		{
			return;
		}
		ICampaignService service = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>();
		if (service == null)
		{
			Log.Error("ICampaignService不存在");
			return;
		}
		if (service == null || !service.GetCampaignOpenState())
		{
			Toast.ShowInfo("尊敬的传火者大人，活动已结束，期待下次再见");
			return;
		}
		DRCampaignBuilding dataRow = GameEntry.DataTable.GetDataRow((DRCampaignBuilding p) => p.Group.Equals(buildingData.GroupId) && p.Level.Equals(buildingData.Level));
		if (dataRow == null)
		{
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int num = 0; num < dataRow.UpgradeMatType.Count; num++)
		{
			int type = dataRow.UpgradeMatType[num];
			int propId = ((dataRow.UpgradeMatId.Count > num) ? dataRow.UpgradeMatId[num] : 0);
			int count = ((dataRow.UpgradeMatNum.Count > num) ? dataRow.UpgradeMatNum[num] : 0);
			PropDataBase propDataBase = PropDataBase.CreateByType(type, propId, count);
			if (propDataBase != null && !propDataBase.Empty)
			{
				stringBuilder.Append((stringBuilder.Length > 0) ? ("," + propDataBase.Name) : propDataBase.Name);
			}
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", $"是否向{dataRow.Name}Lv.{dataRow.Level}捐献全部{stringBuilder}？捐献可获取等量功勋。", "确定", "取消");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				RequestUpgradeBuilding(buildingData.PositionId);
			}
		});
	}

	private async void RequestUpgradeBuilding(int pointId)
	{
		_upgradeBuildingCmd.Enabled = false;
		Loading loading = await Loading.Show();
		List<CampaignServiceData.BuildingInfo> obj = await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().RequestUpgradeBuilding(pointId);
		loading?.Dispose();
		if (obj == null)
		{
			_upgradeBuildingCmd.Enabled = true;
			return;
		}
		CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
		if (detailInfo != null)
		{
			RefreshBuildingData(detailInfo.BuildingInfos, notify: true);
		}
		Toast.ShowInfo("捐献成功");
		RefreshMaterialCount();
		_upgradeBuildingCmd.Enabled = true;
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

	public void OpenPropPopupWindow(DRProp drProp, Vector2 pos)
	{
		if (openPropPopupWindowEnable)
		{
			openPropPopupWindowEnable = false;
			Vector2 zero = Vector2.zero;
			if (pos.x < (0f - UIUtilly.GetCanvasSize().x) / 2f + 522f)
			{
				pos = new Vector2(pos.x + 50f, pos.y);
				zero = new Vector2(0f, 1f);
			}
			else
			{
				zero = Vector2.one;
			}
			PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, allowSkipWindow: true);
			propWindowViewModel.RefreshData(new PropData(drProp));
			propWindowViewModel.SetPosition(pos);
			propWindowViewModel.SetRectInfo(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), zero);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel, "CampaignMapWindow", isOpenWindow: true, "DEFAULT", delegate
			{
				openPropPopupWindowEnable = true;
			}));
		}
	}

	private void OpenWindow(string target)
	{
		_openWindowCmd.Enabled = false;
		if (target == "Rule")
		{
			DRGameExplain dataRow = GameEntry.DataTable.GetDataRow<DRGameExplain>(7006);
			if (dataRow == null)
			{
				Callback(null);
			}
			else
			{
				string title = dataRow.Title;
				string content = dataRow.Content;
				GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, title, content);
				openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData), Callback);
			}
		}
		Callback(null);
		void Callback(OpenViewArg arg)
		{
			_openWindowCmd.Enabled = true;
		}
	}

	protected override void Dispose(bool disposing)
	{
		CancelTimer();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveDailyUpdateAction(OnDailyUpdated);
		_msgNotify?.Dispose();
		_msgNotify = null;
		base.Dispose(disposing);
	}

	private void TryPlayCurrentBranchNodeStory(CampaignServiceData.MainInfo mainInfo)
	{
		DRCampaign currentCampaignConfig = GetCurrentCampaignConfig(mainInfo?.BranchTaskProgress);
		TryPlayCampaignNodeStory(currentCampaignConfig, CampaignBranchStoryCacheKey);
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
