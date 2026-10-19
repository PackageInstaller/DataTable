using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.ViewComponent.RaidView;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CommonWorldSuccessView : BaseUIView<CommonWorldSuccessViewInputController>
{
	public class CommonWorldSuccessData : UIViewData
	{
		public MonoScrollBagComponent.Param scrollBagParam;

		public List<ItemUnifierProxy> rewardItemProxies;
	}

	[SerializeField]
	private CommonWorldSettlementCharacter commonWorldSettlementCharacter;

	[SerializeField]
	private LocalizeStringEvent _name;

	[SerializeField]
	private LocalizeStringEvent _time;

	[SerializeField]
	private GameObject _perfect;

	[SerializeField]
	private GameObject _multipleStar;

	[SerializeField]
	private List<GameObject> _stars;

	[SerializeField]
	private List<GameObject> _starBGs;

	[SerializeField]
	private GameObject _singleStar;

	[SerializeField]
	private GameObject _singleStarLight;

	[SerializeField]
	private GameObject _singleStarBG;

	[SerializeField]
	private List<CommonSubWorldEntranceTargetItem> _targetItems;

	[SerializeField]
	public CanvasGroup _rewardCanvasGroup;

	[SerializeField]
	private CommonSubWorldEntranceRewards _rewards;

	public ActButton ExitRaid;

	public ActButton ReturnHomePage;

	public ActButton ReChallenge;

	public ActButton NextLevel;

	public GameObject CostPower;

	public TextMeshProUGUI CostPowerText;

	public GameObject CostTimes;

	public TextMeshProUGUI CurrentTimesText;

	public TextMeshProUGUI TotalTimesText;

	public Color extraEnoughNormal;

	public Color extraNotEnoughNormal;

	public GameObject GamepadTipsRoot;

	public Dictionary<CommonWorldSuccessViewType, List<GameObject>> ControlDownPromts;

	public Dictionary<CommonWorldSuccessViewType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<CommonWorldSuccessViewType, ViewControlLayer> ControlLayerDic;

	public PowerBar PowerBar;

	public OperateBtnPrompt powerPrompt;

	[SerializeField]
	private TextMeshProUGUI doubleRewardText;

	private CommonWorldSuccessData _commonWorldSuccessData;

	private bool _leaveServiceCompleted;

	private bool _leaveServiceSucceeded;

	private Action _afterLeaveService;

	private int _cachedRaidId;

	private int _cachedRaidType;

	private int _cachedTeamTeachingTime = -1;

	private TrainingContents _cachedTeamTeachingContent;

	private int _cachedTempleId;

	private TeamUsage _cachedTempleTeamUsage;

	private int _cachedAbyssLastChallengeStageIndex;

	private int _cacheAbyssGroupId;

	private int _cachedAbyssNextStageIndex;

	private List<TeamUsage> _cachedAbyssTeamUsages;

	private SceneStatus _sceneStatus => MonoECS.instance.clientSceneStatus;

	private bool IsTeamTeachingRaid => Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid();

	private CommonWorldSuccessViewType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
		ExitRaid.SetBtnClick(OnClickExitRaidButtonHandle);
		ReturnHomePage.SetBtnClick(OnClickReturnHomePageButtonHandle);
		ReChallenge.SetBtnClick(OnClickReChallengeButtonHandle);
		NextLevel.SetBtnClick(OnClickNextLevelButtonHandle);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void Init()
	{
		base.Init();
		_commonWorldSuccessData = uiViewData as CommonWorldSuccessData;
		CacheLeaveServiceContext();
		RefreshUI();
		LeaveCurrentService();
	}

	protected override void UnInit()
	{
		ReleaseRewardItemProxies();
		base.UnInit();
	}

	private void ReleaseRewardItemProxies()
	{
		if (_commonWorldSuccessData?.rewardItemProxies != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_commonWorldSuccessData.rewardItemProxies);
			ListPool<ItemUnifierProxy>.Release(_commonWorldSuccessData.rewardItemProxies);
			_commonWorldSuccessData.rewardItemProxies = null;
		}
	}

	private void CacheLeaveServiceContext()
	{
		_leaveServiceCompleted = false;
		_leaveServiceSucceeded = false;
		_afterLeaveService = null;
		switch (_sceneStatus)
		{
		case SceneStatus.Raid:
			_cachedRaidId = Model<RaidModel>.Interface.CurrentRaidId;
			_cachedRaidType = Model<RaidModel>.Interface.GetRaidType(_cachedRaidId);
			_cachedTeamTeachingTime = (Model<TeamTeachingModel>.HasInstance() ? Model<TeamTeachingModel>.Interface.LastChallengeTime : (-1));
			CacheTeamTeachingContent();
			break;
		case SceneStatus.Temple:
			_cachedTempleId = Model<TempleModel>.Interface.CurChallengeTempleId;
			_cachedTempleTeamUsage = CreateTempleTeamUsage();
			break;
		case SceneStatus.Abyss:
			_cachedAbyssLastChallengeStageIndex = Model<AbyssModel>.Interface.LastChallengeStageIndex;
			_cacheAbyssGroupId = Model<AbyssModel>.Interface.GroupId;
			_cachedAbyssNextStageIndex = Model<AbyssModel>.Interface.CurAbyssStageIndex + 1;
			_cachedAbyssTeamUsages = Model<AbyssModel>.Interface.lastChangeTeamUsages;
			break;
		case SceneStatus.Rogue:
		case SceneStatus.Trainingground:
			break;
		}
	}

	private void CacheTeamTeachingContent()
	{
		_cachedTeamTeachingContent = null;
		if (_cachedRaidType != 9)
		{
			return;
		}
		if (Model<TeamTeachingModel>.HasInstance())
		{
			_cachedTeamTeachingContent = Model<TeamTeachingModel>.Interface.CurrentTrainingContent;
		}
		if (_cachedTeamTeachingContent != null || RuntimeConfigs.data?.trainingContentss == null)
		{
			return;
		}
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value.raidID == _cachedRaidId)
			{
				_cachedTeamTeachingContent = value;
				break;
			}
		}
	}

	private TeamUsage CreateTempleTeamUsage()
	{
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId;
		int[] templeCharactersId = Model<TeamModel>.Interface.templeCharactersId;
		foreach (int characterId in templeCharactersId)
		{
			TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
			teamCharacterUsage.CharacterId = characterId;
			teamCharacterUsage.IsTrial = false;
			teamUsage.CharacterUsage.Add(teamCharacterUsage);
		}
		return teamUsage;
	}

	private void LeaveCurrentService()
	{
		switch (_sceneStatus)
		{
		case SceneStatus.Raid:
			G.service.LeaveRaid(OnLeaveServiceComplete);
			break;
		case SceneStatus.Temple:
			G.service.LeaveTemple(OnLeaveServiceComplete, resetData: false);
			break;
		case SceneStatus.Abyss:
			G.service.LeaveAbyss(OnLeaveServiceComplete);
			break;
		default:
			OnLeaveServiceComplete(success: true);
			break;
		}
	}

	private void OnLeaveServiceComplete(bool success)
	{
		_leaveServiceCompleted = true;
		_leaveServiceSucceeded = success;
		Action afterLeaveService = _afterLeaveService;
		_afterLeaveService = null;
		if (success)
		{
			afterLeaveService?.Invoke();
		}
	}

	private void RunAfterLeaveService(Action action)
	{
		if (_leaveServiceCompleted)
		{
			if (_leaveServiceSucceeded)
			{
				action?.Invoke();
			}
		}
		else
		{
			_afterLeaveService = action;
		}
	}

	private async void OnClickExitRaidButtonHandle()
	{
		switch (_sceneStatus)
		{
		case SceneStatus.Raid:
		{
			int raidId = _cachedRaidId;
			int raidType = _cachedRaidType;
			RunAfterLeaveService(() =>
			{
				Model<RaidModel>.Interface.CostRate = 1;
				switch ((RaidType)raidType)
				{
				case RaidType.dairy:
				case RaidType.weekly:
				case RaidType.parkour:
				case RaidType.boss:
				{
					ACT.Config.Raid raid = CoreUtils.GetData(raidId, RuntimeConfigs.data.raids);
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
					{
						RaidEntranceId = raid.belongEntranceData,
						OnClose = () =>
						{
							Model<RaidModel>.Interface.OpenHandBookView(raid.belongEntranceData);
						}
					});
					break;
				}
				case RaidType.characterTutorial:
					if (!Model<RaidModel>.Interface.GetIsCharacterTrial(raidId))
					{
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMTEACHING, new TeamTeachingViewData
						{
							OnClose = () =>
							{
								Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
							}
						});
					}
					else
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
					}
					break;
				case RaidType.teamTeaching:
				{
					int[] array = _cachedTeamTeachingContent?.teamCharacter;
					if (array != null && array.Length > 0)
					{
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMTEACHING, new TeamTeachingViewData
						{
							MainTabId = _cachedTeamTeachingContent.IdBelong,
							TrainingContentId = _cachedTeamTeachingContent.id,
							ChallengeTime = _cachedTeamTeachingTime,
							DeferCompletedChallengeSort = true,
							OnClose = () =>
							{
								Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
							}
						});
					}
					else
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
					}
					break;
				}
				default:
					Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
					break;
				}
			});
			break;
		}
		case SceneStatus.Temple:
			RunAfterLeaveService(() =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
			});
			break;
		case SceneStatus.Abyss:
			RunAfterLeaveService(() =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
			});
			break;
		}
		await CloseAsync();
	}

	private void OnClickReturnHomePageButtonHandle()
	{
		if (_sceneStatus == SceneStatus.Abyss)
		{
			RunAfterLeaveService(() =>
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST);
			});
		}
	}

	private async void OnClickReChallengeButtonHandle()
	{
		if (_sceneStatus == SceneStatus.Raid)
		{
			RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(_cachedRaidId);
			if (raidTypeConfig == null)
			{
				return;
			}
			if (raidTypeConfig.cost != null && raidTypeConfig.cost.Count > 0 && Model<PowerModel>.Interface.PowerCount < Model<RaidModel>.Interface.PowerCost)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
			}
			else if (raidTypeConfig.cycleType == 2 && GetLeftTimesByTypeId(raidTypeConfig.id) <= 0)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
				{
					titleId = 63,
					commonId = 740,
					OnConfirm = () =>
					{
						ReopenRaid();
					},
					CancelCommonId = 14,
					ConfirmCommonId = 13
				});
			}
			else if (raidTypeConfig.raidType == 6)
			{
				int raidId = _cachedRaidId;
				TeamUsage teamUsage = Model<RaidModel>.Interface.GetTeamTeachingTrialTeamUsage(raidId) ?? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidId);
				if (teamUsage == null)
				{
					return;
				}
				RunAfterLeaveService(() =>
				{
					G.service.RaidEnterInfo(raidId, teamUsage, async (bool r) =>
					{
						if (r)
						{
							await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
						}
					});
				});
			}
			else
			{
				ReopenRaid();
			}
		}
		else if (_sceneStatus == SceneStatus.Temple)
		{
			int templeId = _cachedTempleId;
			TeamUsage teamUsage2 = _cachedTempleTeamUsage;
			RunAfterLeaveService(() =>
			{
				G.service.EnterTempleChallenge(templeId, teamUsage2, (bool b) =>
				{
					if (b)
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Temple).Forget();
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"进入神庙[{templeId}]失败!!!");
					}
				});
			});
		}
		else
		{
			if (_sceneStatus != SceneStatus.Abyss)
			{
				return;
			}
			RunAfterLeaveService(() =>
			{
				G.service.AbyssEnter(_cachedAbyssLastChallengeStageIndex, _cacheAbyssGroupId, _cachedAbyssTeamUsages, async (bool r) =>
				{
					if (r)
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Abyss).Forget();
					}
				});
			});
		}
	}

	private void ReopenRaid()
	{
		int raidId = _cachedRaidId;
		TeamUsage teamUsage = Model<RaidModel>.Interface.GetTeamTeachingTrialTeamUsage(raidId);
		if (teamUsage == null)
		{
			teamUsage = new TeamUsage();
			teamUsage.BattleCharacterIdx = 0;
			teamUsage.EquipPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			foreach (Character curTeamCharacter in CharacterDataHelper.GetCurTeamCharacters())
			{
				TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
				teamCharacterUsage.CharacterId = curTeamCharacter.Id;
				teamUsage.CharacterUsage.Add(teamCharacterUsage);
			}
		}
		if (teamUsage == null)
		{
			return;
		}
		RunAfterLeaveService(() =>
		{
			G.service.RaidEnterInfo(raidId, teamUsage, async (bool r) =>
			{
				if (r)
				{
					await Singleton<GameManager>.instance.worldManager.LeaveWorld(() =>
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid).Forget();
					});
				}
			});
		});
	}

	private void OnClickNextLevelButtonHandle()
	{
		if (_sceneStatus == SceneStatus.Abyss)
		{
			RunAfterLeaveService(() =>
			{
				MonoAbyssListData uiData = new MonoAbyssListData
				{
					IsOpenAbyssTeamPanel = true,
					AbyssType = Model<AbyssModel>.Interface.CurAbyssType
				};
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST, uiData);
			});
		}
	}

	private void RefreshUI()
	{
		commonWorldSettlementCharacter.Refresh(_sceneStatus, Station);
		RefreshTargetTask();
		RefreshMiddleButton();
		RefreshDoubleRewardText();
	}

	private void RefreshDoubleRewardText()
	{
		if (doubleRewardText == null)
		{
			return;
		}
		doubleRewardText.gameObject.SetActive(value: false);
		if (_sceneStatus != SceneStatus.Raid)
		{
			return;
		}
		int doubleDungeonActivityId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId();
		if (Model<ActivityCenterModel>.Interface.GetActivityIsOpening(doubleDungeonActivityId))
		{
			List<int> raidTypeList = Model<ActivityCenterModel>.Interface.GetRaidTypeList(doubleDungeonActivityId);
			if (raidTypeList != null && raidTypeList.Contains(_cachedRaidType))
			{
				(int, int) todayLeftDoubleRewardCount = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(doubleDungeonActivityId);
				string localizeString = LocalizationUtility.GetLocalizeString("Common", 2688);
				doubleRewardText.text = $"{localizeString}: {todayLeftDoubleRewardCount.Item1}/{todayLeftDoubleRewardCount.Item2}";
				doubleRewardText.gameObject.SetActive(value: true);
			}
		}
	}

	private void RefreshTargetTask()
	{
		List<ChallengeTargetTrackerModel.RuntimeTarget> targets = Model<ChallengeTargetTrackerModel>.Interface.GetTargets();
		StageChallengeTarget stageChallengeTarget = null;
		int num = 0;
		int num2 = 0;
		PowerBar.gameObject.SetActive(value: false);
		switch (_sceneStatus)
		{
		case SceneStatus.Raid:
		{
			ACT.Config.Raid raid = RuntimeConfigs.data.raids[_cachedRaidId];
			Model<RaidModel>.Interface.GetRaidInfo(_cachedRaidId);
			RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(_cachedRaidId);
			stageChallengeTarget = Model<RaidModel>.Interface.GetChallengeInfo();
			num = raid.raidName;
			num2 = Model<ChallengeTargetTrackerModel>.Interface.GetChallengeRuntime();
			if (IsTeamTeachingRaid)
			{
				TrainingContents currentTrainingContent = Model<TeamTeachingModel>.Interface.CurrentTrainingContent;
				if (currentTrainingContent != null)
				{
					num = currentTrainingContent.contentLv1name;
				}
				num2 = Model<TeamTeachingModel>.Interface.GetTeamTeachingTotalTime();
			}
			PowerBar.gameObject.SetActive(raidTypeConfig.cost != null && raidTypeConfig.cost.Count > 0);
			break;
		}
		case SceneStatus.Temple:
		{
			TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
			stageChallengeTarget = Model<TempleModel>.Interface.GetChallengeInfo();
			num = curChallengeTempleData.staticData.name;
			num2 = Model<ChallengeTargetTrackerModel>.Interface.GetChallengeRuntime();
			break;
		}
		case SceneStatus.Abyss:
			num = CoreUtils.GetData(Model<AbyssModel>.Interface.CurAbyssStageId, RuntimeConfigs.data.abyssDatas).abyssNameLocal;
			num2 = ((Model<AbyssModel>.Interface.SettlementTime > 0) ? Model<AbyssModel>.Interface.SettlementTime : Model<AbyssModel>.Interface.GetAbyssTotalTime());
			stageChallengeTarget = Model<AbyssModel>.Interface.GetChallengeInfo();
			break;
		}
		_name.StringReference.TableEntryReference = num;
		int num3 = num2 / 60;
		int num4 = num2 % 60;
		_time.GetVariable<string>("0").Value = $"{num3:D2}";
		_time.GetVariable<string>("1").Value = $"{num4:D2}";
		_multipleStar.SetActive(targets.Count > 1);
		_singleStar.SetActive(targets.Count <= 1);
		_singleStarLight.SetActive(value: false);
		bool flag = targets.Count > 0 && targets.All((ChallengeTargetTrackerModel.RuntimeTarget target) => target.Completed);
		if (IsTeamTeachingRaid)
		{
			bool flag2 = flag;
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(_cachedRaidId);
			flag = flag2 & (raidInfo != null && raidInfo.Target?.IsPerfect == true);
		}
		bool value = default;
		for (int num5 = 0; num5 < _targetItems.Count; num5++)
		{
			if (num5 < targets.Count)
			{
				int targetId = targets[num5].TargetId;
				Rules rule = targets[num5].Rule;
				bool completed = targets[num5].Completed;
				bool lastIsComplete = (stageChallengeTarget != null && stageChallengeTarget.TargetReward != null && stageChallengeTarget.TargetReward.TryGetValue(targetId, out value)) & value;
				int progress = ((rule.rulesId == 4) ? targets[num5].Progress : (-1));
				_targetItems[num5].gameObject.SetActive(value: true);
				_targetItems[num5].RefreshUI(num5, targetId, completed, progress, lastIsComplete);
				_starBGs[num5].SetActive(value: true);
				_stars[num5].SetActive(completed);
				if (num5 == 0)
				{
					_singleStarLight.SetActive(completed);
				}
			}
			else
			{
				_targetItems[num5].gameObject.SetActive(value: false);
				_starBGs[num5].SetActive(value: false);
			}
		}
		_perfect.SetActive(flag);
	}

	private void RefreshReward()
	{
		List<ItemUnifierProxy> list = _commonWorldSuccessData?.rewardItemProxies;
		List<Item> list2 = _commonWorldSuccessData?.scrollBagParam.allItems.items;
		bool flag = (list != null && list.Count > 0) || (list2 != null && list2.Count > 0);
		_rewardCanvasGroup.gameObject.SetActive(flag);
		if (!flag)
		{
			return;
		}
		List<ItemUnifierProxy> list3;
		if (list != null && list.Count > 0)
		{
			list3 = list;
			list3.Sort(SortUtility.SortItemUnifierProxyPopReward);
		}
		else
		{
			list3 = new List<ItemUnifierProxy>();
			ItemUnifierProxy.ItemUnifierPool.GetList(list2, list3);
			list3.Sort((ItemUnifierProxy a, ItemUnifierProxy b) => b.Quality.CompareTo(a.Quality));
		}
		_rewards.RefreshUI(list3, Station);
	}

	private void RefreshMiddleButton()
	{
		if (_sceneStatus == SceneStatus.Raid)
		{
			ExitRaid.gameObject.SetActive(value: true);
			ReChallenge.gameObject.SetActive(ShouldShowRaidReChallenge());
			RefreshRaidCostState();
		}
		else if (_sceneStatus == SceneStatus.Temple)
		{
			ExitRaid.gameObject.SetActive(value: true);
			ReChallenge.gameObject.SetActive(value: true);
		}
		else if (_sceneStatus == SceneStatus.Abyss)
		{
			ReturnHomePage.gameObject.SetActive(value: true);
			ReChallenge.gameObject.SetActive(value: true);
			int cachedAbyssNextStageIndex = _cachedAbyssNextStageIndex;
			AbyssStage abyssStage = Model<AbyssModel>.Interface.GetAbyssStage(0);
			bool active = Model<AbyssModel>.Interface.AbyssStages.Count > cachedAbyssNextStageIndex && (abyssStage?.IsUnlock ?? false);
			NextLevel.gameObject.SetActive(active);
		}
	}

	private bool ShouldShowRaidReChallenge()
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(_cachedRaidId, out var value) || !RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value.belongEntranceData, out var value2))
		{
			return true;
		}
		if (value2.raidType != 4)
		{
			return value2.raidType != 10;
		}
		return false;
	}

	private void OnPowerRefresh(BaseEventContent baseEventContent)
	{
		RefreshRaidCostState();
	}

	private void RefreshRaidCostState()
	{
		int raidId = ((_cachedRaidId > 0) ? _cachedRaidId : Model<RaidModel>.Interface.CurrentRaidId);
		RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(raidId);
		if (raidTypeConfig != null)
		{
			if (raidTypeConfig.cost != null && raidTypeConfig.cost.Count > 0)
			{
				CostPower.SetActive(value: true);
				CostPowerText.SetText("{0:0}", Model<RaidModel>.Interface.PowerCost);
				CostPowerText.color = ((Model<PowerModel>.Interface.PowerCount >= Model<RaidModel>.Interface.PowerCost) ? extraEnoughNormal : extraNotEnoughNormal);
			}
			else
			{
				CostPower.SetActive(value: false);
			}
			if (raidTypeConfig.cycleType == 2)
			{
				int leftTimesByTypeId = GetLeftTimesByTypeId(raidTypeConfig.id);
				CurrentTimesText.color = ((leftTimesByTypeId > 0) ? extraEnoughNormal : extraNotEnoughNormal);
				CurrentTimesText.SetText("{0:0}", leftTimesByTypeId);
				TotalTimesText.SetText("{0:0}", raidTypeConfig.cycleParm[1]);
				CostTimes.SetActive(value: true);
			}
			else
			{
				CostTimes.SetActive(value: false);
			}
		}
	}

	private int GetUsedTimesByEnteranceId(int entranceId)
	{
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[entranceId];
		int num = 0;
		int[] raidId = raidEntranceData.raidId;
		foreach (int raidId2 in raidId)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
			if (raidInfo != null)
			{
				num += raidInfo.TakeRewardCount;
			}
		}
		return num;
	}

	private int GetLeftTimesByTypeId(int typeId)
	{
		int num = 0;
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[typeId];
		int num2 = 0;
		int[] raidEntranceId = raidTypeData.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num2 += GetUsedTimesByEnteranceId(entranceId);
		}
		num = raidTypeData.cycleParm[1] - num2;
		return Mathf.Max(0, num);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("RaidShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		_rewardCanvasGroup.alpha = 1f;
		RefreshReward();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Success");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public void PlayOneStarAudio()
	{
		if (_singleStarLight.activeSelf || _stars.Count <= 0 || _stars[0].activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Gold");
		}
	}

	public void PlayTwoStarAudio()
	{
		if (_stars.Count <= 1 || _stars[1].activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Green");
		}
	}

	public void PlayThreeStarAudio()
	{
		if (_stars.Count <= 2 || _stars[2].activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Green");
		}
	}

	public void PlayPerfectAudio()
	{
		if (_perfect.activeSelf)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Success_Side");
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot?.SetActive(type == DeviceInputMode.Gamepad);
		if (type != DeviceInputMode.Gamepad)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
				if ((bool)component)
				{
					component.SetIsOn(val: false);
				}
			}
		}
		else
		{
			ChangeControlType(ControlType);
		}
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public async void ChangeControlType(CommonWorldSuccessViewType controlType)
	{
		await UniTask.DelayFrame(1);
		CommonWorldSuccessViewType controlType2 = ControlType;
		ControlType = controlType;
		ControlLayerDic[controlType2].UnFocus();
		ControlLayerDic[controlType].Focus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (ControlType == CommonWorldSuccessViewType.Reward && EventSystemHelper.CurrentSelected != null)
		{
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			if ((bool)component)
			{
				component.SetIsOn(val: true);
			}
		}
	}

	public void OnGamepadConfirm()
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnRightStickPress()
	{
		if (ControlType == CommonWorldSuccessViewType.Main && PowerBar != null && PowerBar.addPowerBtn != null && PowerBar.addPowerBtn.gameObject.activeSelf && PowerBar.addPowerBtn.IsInteractable())
		{
			SetPowerBarPromptActive(active: false);
			PowerBar.addPowerBtn.OnSubmit(null);
		}
	}

	public void SetPowerBarPromptActive(bool active)
	{
		powerPrompt?.SetVisible(active);
	}
}
