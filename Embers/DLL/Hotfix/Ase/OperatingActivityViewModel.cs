#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class OperatingActivityViewModel : OptionBase
{
	private List<ActivityViewModelBase> _activityViewModels = new List<ActivityViewModelBase>();

	private TabItemData _tabTypeItemData1;

	private TabItemData _tabTypeItemData2;

	private List<ActivityTabItemData> tabItemDataList = new List<ActivityTabItemData>();

	private int autoSelectActivityId;

	private int curSelectTypeId;

	private int curTabType = 1;

	private InteractionRequest refreshActTabListRst = new InteractionRequest();

	private InteractionRequest<bool> onActivityTabClick = new InteractionRequest<bool>();

	private InteractionRequest _redChangeRst = new InteractionRequest();

	private InteractionRequest<OpenViewArgTemp> openWindowRequest2 = new InteractionRequest<OpenViewArgTemp>();

	private ISubscription<OpActivityMessage> sub_opActivityMessage;

	private List<ActivityViewModelBase> _waitDisposeList = new List<ActivityViewModelBase>();

	private float windowMaskLeftTime;

	private bool isWindowVisible;

	public Action<OpActAnimateState> AniAction;

	private OpActAnimateState _animateState = OpActAnimateState.Enter;

	public OpActAnimateState AnimateState => _animateState;

	public float WindowMaskLeftTime
	{
		get
		{
			return windowMaskLeftTime;
		}
		set
		{
			Set(ref windowMaskLeftTime, value, "WindowMaskLeftTime");
		}
	}

	public List<ActivityViewModelBase> ActivityViewModels => _activityViewModels;

	public InteractionRequest RefreshActTabListRst => refreshActTabListRst;

	public int AutoSelectActivityId
	{
		get
		{
			return autoSelectActivityId;
		}
		set
		{
			autoSelectActivityId = value;
		}
	}

	public int CurSelectTypeId
	{
		get
		{
			return curSelectTypeId;
		}
		set
		{
			curSelectTypeId = value;
		}
	}

	public int CurTabType
	{
		get
		{
			return curTabType;
		}
		set
		{
			Set(ref curTabType, value, "CurTabType");
		}
	}

	public TabItemData TabTypeItemData1 => _tabTypeItemData1;

	public TabItemData TabTypeItemData2 => _tabTypeItemData2;

	public List<ActivityTabItemData> TabItemDataList => tabItemDataList;

	public InteractionRequest<bool> OnActivityTabClick => onActivityTabClick;

	public InteractionRequest RedChangeRst => _redChangeRst;

	public IInteractionRequest OpenWindowRequest2 => openWindowRequest2;

	public bool IsWindowVisible => isWindowVisible;

	public OperatingActivityViewModel(OptionBase parent, int autoSelectActivityId = 0)
	{
		base.parent = parent;
		_tabTypeItemData1 = new TabItemData(this, -1);
		_tabTypeItemData2 = new TabItemData(this, -2);
		this.autoSelectActivityId = autoSelectActivityId;
		Dictionary<int, ActivityViewModelBase> dictionary = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.ActivityViewModels;
		if (dictionary == null)
		{
			return;
		}
		foreach (ActivityViewModelBase value in dictionary.Values)
		{
			if (value.IsUnderWay() && value.DisplayInActWindow())
			{
				AddActivity(value);
				if (value.ActivityTypeId == autoSelectActivityId)
				{
					CurTabType = value.CurType;
				}
			}
		}
		_tabTypeItemData1.IsSelected = CurTabType == 1;
		_tabTypeItemData2.IsSelected = CurTabType == 2;
		sub_opActivityMessage = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetMessager().Subscribe<OpActivityMessage>(OnOpActivityChanged);
	}

	public override async void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("UpdateWindowMaskTime") && optionArg.Obj is float newLeftTime)
			{
				UpdateWindowMaskLeftTime(newLeftTime);
			}
			else if (optionArg.OptionName.Equals("SetUiVisible") && optionArg.Obj is bool uiVisible)
			{
				SetUiVisible(uiVisible);
			}
		}
		else if (obj is PropGetViewModel propGetViewModel)
		{
			propGetViewModel.MergeProp();
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				ArmourPopupViewModel userData = new ArmourPopupViewModel(this, (ArmourData)knapsackItemViewModel.PropDataBase);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
				return;
			}
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: false);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is TabItemData tabItemData)
		{
			if (tabItemData.TabIndex >= 0)
			{
				OnTabClick(tabItemData);
			}
			else
			{
				OnTypeTabClick(tabItemData);
			}
		}
		else if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			battleReadyViewModel.SetStartBattleResult(await EnterBattleWorldHeroTry(battleReadyViewModel));
		}
		else
		{
			if (obj is TowerActivityAreaViewModel)
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(TowerActivityAreaWindow), obj));
				return;
			}
			OpenViewArgTemp arg = obj as OpenViewArgTemp;
			if (arg != null)
			{
				openWindowRequest2.Raise(arg, delegate
				{
					arg.CallBack?.Invoke();
				});
			}
			else
			{
				ActivityChallengeWindowOpenArg challengeWindowArg = obj as ActivityChallengeWindowOpenArg;
				if (challengeWindowArg != null)
				{
					if (string.IsNullOrEmpty(challengeWindowArg.WindowPath))
					{
						openWindowRequest.Raise(new OpenViewArg(typeof(ActivityChallengeWindow), challengeWindowArg.ViewModel, challengeWindowArg.Callback));
					}
					else
					{
						openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityChallengeWindow), challengeWindowArg.WindowPath, challengeWindowArg.ViewModel), delegate
						{
							challengeWindowArg.Callback?.Invoke();
						});
					}
				}
				else if (obj is ShortTermCheckinViewModel)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(GameScoreWindow), new GameScoreViewModel(this, 2)));
				}
			}
		}
		base.ItemOnClick(obj);
	}

	private void OnTypeTabClick(TabItemData tabItemData)
	{
		CurTabType = -tabItemData.TabIndex;
		_tabTypeItemData1.IsSelected = CurTabType == 1;
		_tabTypeItemData2.IsSelected = CurTabType == 2;
		RefreshTabDataList();
		if (tabItemDataList.Count > 0)
		{
			OnTabClick(tabItemDataList[0]);
		}
		refreshActTabListRst.Raise();
	}

	private void OnTabClick(TabItemData tabItemData, bool moveTabPanel = false)
	{
		if (tabItemData == null || tabItemData.IsSelected)
		{
			return;
		}
		if (curSelectTypeId > 0)
		{
			tabItemDataList.Find((ActivityTabItemData p) => p.TabIndex == curSelectTypeId)?.SetSelected(false);
		}
		tabItemDataList.Find((ActivityTabItemData p) => p.TabIndex == tabItemData.TabIndex)?.SetSelected(true);
		int num = curSelectTypeId;
		curSelectTypeId = tabItemData.TabIndex;
		if (num != curSelectTypeId)
		{
			onActivityTabClick.Raise(moveTabPanel);
		}
	}

	private void AddActivity(ActivityViewModelBase activityViewModel)
	{
		if (activityViewModel == null)
		{
			return;
		}
		int typeId = activityViewModel.ActivityTypeId;
		_activityViewModels.ForEach(delegate(ActivityViewModelBase p)
		{
			if (p.ActivityTypeId == typeId)
			{
				p.Dispose();
			}
		});
		_activityViewModels.RemoveAll((ActivityViewModelBase p) => p.ActivityTypeId == typeId);
		activityViewModel.SetViewParent(this);
		activityViewModel.RefreshActivityTime();
		activityViewModel.StartTimer();
		activityViewModel.RequestDataBeforeShow();
		_activityViewModels.Add(activityViewModel);
		SortActViewModels();
		RefreshTabDataList();
		refreshActTabListRst.Raise();
	}

	private void SortActViewModels()
	{
		_activityViewModels.Sort(delegate(ActivityViewModelBase a, ActivityViewModelBase b)
		{
			if (a.Finished != b.Finished)
			{
				if (!b.Finished)
				{
					return 1;
				}
				return -1;
			}
			return (a.Priority != b.Priority) ? a.Priority.CompareTo(b.Priority) : a.ActivityTypeId.CompareTo(b.ActivityTypeId);
		});
	}

	private void RefreshTabDataList()
	{
		tabItemDataList.ForEach(delegate(ActivityTabItemData p)
		{
			p.Dispose();
		});
		tabItemDataList.Clear();
		_activityViewModels.ForEach(delegate(ActivityViewModelBase p)
		{
			if (p.IsUnderWay() && p.CurType == CurTabType)
			{
				ActivityTabItemData activityTabItemData = new ActivityTabItemData(this, p.ActivityTypeId)
				{
					TextNormal = p.ActivityName,
					TextSelected = p.ActivityName,
					IconNormal = p.ActivityTabIcon,
					IconSelected = p.ActivityTabIcon
				};
				activityTabItemData.StartTimer(p.LeftActivityTime);
				tabItemDataList.Add(activityTabItemData);
			}
		});
	}

	private void RemoveActivity(int activityId)
	{
		foreach (ActivityViewModelBase item in _activityViewModels.FindAll((ActivityViewModelBase p) => p.ActivityTypeId == activityId))
		{
			_waitDisposeList.Add(item);
		}
		if (_activityViewModels.RemoveAll((ActivityViewModelBase p) => p.ActivityTypeId == activityId) > 0)
		{
			RefreshTabDataList();
			refreshActTabListRst.Raise();
		}
	}

	private void OnOpActivityChanged(OpActivityMessage message)
	{
		if (message == null)
		{
			return;
		}
		int num = 0;
		if (message.Arg != null && message.Arg is int num2)
		{
			num = num2;
		}
		if (message.Type == OpActivityMessageEnum.ActivityOpen)
		{
			ActivityViewModelBase activityViewModelBase = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(num);
			if (activityViewModelBase.IsUnderWay())
			{
				AddActivity(activityViewModelBase);
			}
		}
		else if (message.Type == OpActivityMessageEnum.ActivityClose)
		{
			RemoveActivity(num);
		}
		else if (message.Type == OpActivityMessageEnum.ActivityOn)
		{
			if (num > 0)
			{
				ActivityViewModelBase activityViewModelBase2 = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(num);
				if (activityViewModelBase2.IsUnderWay())
				{
					AddActivity(activityViewModelBase2);
				}
			}
		}
		else if (message.Type == OpActivityMessageEnum.ActivityOff)
		{
			if (num > 0)
			{
				RemoveActivity(num);
			}
		}
		else if (message.Type == OpActivityMessageEnum.RedChange)
		{
			_redChangeRst.Raise();
		}
		else if (message.Type == OpActivityMessageEnum.ActivityFinishStateChange || message.Type == OpActivityMessageEnum.ActivityTabTypeChange)
		{
			SortActViewModels();
			RefreshTabDataList();
			refreshActTabListRst.Raise();
		}
	}

	private async Task<bool> EnterBattleWorldHeroTry(BattleReadyViewModel readyVm)
	{
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetActivityCopyById(readyVm.ReadyData.TargetId);
		if (copyData == null)
		{
			return false;
		}
		CopyEnterInfoData copyEnterInfoData = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyData, new List<int> { 1104 }, readyVm.TeamData(), (int)readyVm.ReadyData.BattleMode, readyVm.ReadyData.CopyDropType, null);
		if (copyEnterInfoData != null)
		{
			bool flag = GameEntry.DataTable.GetDataRow<DRTeamSet>(readyVm.ReadyData.TeamSetId)?.IsBattleProp ?? true;
			List<PeripheryHeroData> list = new List<PeripheryHeroData>();
			foreach (TeamMember teamMember in copyEnterInfoData.TeamMembers)
			{
				PeripheryHeroData peripheryHeroData = teamMember.GetPeripheryHeroData();
				if (!flag)
				{
					peripheryHeroData.ClearBattleProps();
				}
				list.Add(peripheryHeroData);
			}
			List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
			WorldData worldData = ActivityBattleWorldData.Create(copyData.Id, 0u, list, null, copyEnterInfoData.SeedID, copyEnterInfoData.RoomId, 0L, 0, Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid, 0, "", 0, 0u, battleAchievementMedals, copyData.Id);
			LoadingActivitiyBattleViewModel loadingSingleViewModel = new LoadingActivitiyBattleViewModel("Outer/Outer", worldData, autoUnload: true);
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(worldData.SceneLoadPath);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
			loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
			await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
			if (loadingSingleViewModel.LoadingSuccess)
			{
				readyVm.Close();
				UIWindowHelper.WindowRelease();
				await loadingSingleViewModel.CloseLoading();
				Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsSingleBattle(value: true);
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
				return true;
			}
		}
		return false;
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (!jumpParams.WindowName.Equals("OperatingActivityWindow") && !jumpParams.WindowName.Equals("OpActWindow"))
		{
			return true;
		}
		if (tabItemDataList == null || tabItemDataList.Count <= 0)
		{
			Log.Error("活动列表为空（活动数据未加载或活动未开启）");
			return true;
		}
		int targetActTypeId = 0;
		if (jumpParams.Args != null && jumpParams.Args.Count > 0)
		{
			int.TryParse(jumpParams.Args[0]?.ToString(), out targetActTypeId);
		}
		if (targetActTypeId <= 0)
		{
			Log.Error("运营活动跳转参数异常");
			return false;
		}
		ActivityTabItemData activityTabItemData = tabItemDataList.Find((ActivityTabItemData p) => p.TabIndex == targetActTypeId);
		if (activityTabItemData == null)
		{
			Toast.ShowInfo("目标活动未开启");
			Log.Error($"目标活动未开启：{targetActTypeId}");
			return false;
		}
		OnTabClick(activityTabItemData, moveTabPanel: true);
		return false;
	}

	private void UpdateWindowMaskLeftTime(float newLeftTime)
	{
		if (!(WindowMaskLeftTime >= newLeftTime))
		{
			WindowMaskLeftTime = newLeftTime;
		}
	}

	public void MarkWindowVisible(bool visible)
	{
		isWindowVisible = visible;
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}

	public override void Dispose()
	{
		if (_waitDisposeList != null)
		{
			foreach (ActivityViewModelBase waitDispose in _waitDisposeList)
			{
				waitDispose?.Dispose();
			}
		}
		if (_activityViewModels != null)
		{
			foreach (ActivityViewModelBase activityViewModel in _activityViewModels)
			{
				activityViewModel?.OnViewClose();
			}
		}
		sub_opActivityMessage?.Dispose();
		sub_opActivityMessage = null;
		base.Dispose();
	}

	private void SetUiVisible(bool visible)
	{
		if (!((_animateState == OpActAnimateState.Enter) & visible))
		{
			_animateState = (visible ? OpActAnimateState.ShowUi : OpActAnimateState.HideUi);
			AniAction?.Invoke(_animateState);
		}
	}
}
