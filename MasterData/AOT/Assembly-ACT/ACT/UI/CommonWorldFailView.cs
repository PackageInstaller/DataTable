using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
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

namespace ACT.UI;

public class CommonWorldFailView : BaseUIView<CommonWorldFailViewInputController>
{
	[SerializeField]
	private CommonWorldSettlementCharacter commonWorldSettlementCharacter;

	[SerializeField]
	private LocalizeStringEvent _name;

	[SerializeField]
	private LocalizeStringEvent _time;

	[SerializeField]
	private GameObject _multipleStar;

	[SerializeField]
	private GameObject _singleStar;

	[SerializeField]
	private List<CommonSubWorldEntranceTargetItem> _targetItems;

	[SerializeField]
	private GameObject _targetRoot;

	public ActButton Rechallenge;

	public ActButton ExitRaid;

	public GameObject CostPower;

	public TextMeshProUGUI CostPowerText;

	public GameObject CostTimes;

	public TextMeshProUGUI CurrentTimesText;

	public TextMeshProUGUI TotalTimesText;

	public Color extraEnoughNormal;

	public Color extraNotEnoughNormal;

	public ViewControlRoot viewControlRoot;

	public ViewControlLayer viewControlLayer;

	public PowerBar PowerBar;

	public OperateBtnPrompt powerBarPrompt;

	[SerializeField]
	private GameObject _jumpRoot;

	[SerializeField]
	private GameObject _tipsView;

	public WorldFailJumpItem worldFailJumpToCharacterEntry;

	public WorldFailJumpItem worldFailJumpToHandBookEntry;

	private CommonWorldFailViewData m_data;

	private bool _leaveServiceCompleted;

	private bool _leaveServiceSucceeded;

	private Action _afterLeaveService;

	private int _cachedRaidId;

	private int _cachedRaidType;

	private TrainingContents _cachedTeamTeachingContent;

	private int _cachedTempleId;

	private TeamUsage _cachedTempleTeamUsage;

	private int _cachedAbyssLastChallengeStageIndex;

	private int _cacheAbyssGroupId;

	private List<TeamUsage> _cachedAbyssTeamUsages;

	private SceneStatus _sceneStatus => MonoECS.instance.clientSceneStatus;

	private bool IsTeamTeachingRaid => _cachedRaidType == 9;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
		Rechallenge.SetBtnClick(OnClickRechallengeButtonHandle);
		ExitRaid.SetBtnClick(OnClickExitRaidButtonHandle);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		CacheRuntimeNodes();
		CacheLeaveServiceContext();
		RefreshUI();
		LeaveCurrentService();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("RaidShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Fail");
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
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
			CacheTeamTeachingContent();
			break;
		case SceneStatus.Temple:
			_cachedTempleId = Model<TempleModel>.Interface.CurChallengeTempleId;
			_cachedTempleTeamUsage = CreateTempleTeamUsage();
			break;
		case SceneStatus.Abyss:
			_cachedAbyssLastChallengeStageIndex = Model<AbyssModel>.Interface.LastChallengeStageIndex;
			_cacheAbyssGroupId = Model<AbyssModel>.Interface.GroupId;
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

	private void CacheRuntimeNodes()
	{
		if ((object)_targetRoot == null)
		{
			_targetRoot = transform.Find("Content/Control/Right/CommonSubWorldEntranceTarget")?.gameObject;
		}
		if ((object)_jumpRoot == null)
		{
			_jumpRoot = transform.Find("Content/Control/Right/JumpRoot")?.gameObject;
		}
		if ((object)_tipsView == null)
		{
			_tipsView = transform.Find("Content/Control/Button/TipsView")?.gameObject;
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

	private async void OnClickRechallengeButtonHandle()
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
					titleId = 483,
					commonId = 1609,
					OnConfirm = () =>
					{
						ReopenRaid();
					},
					CancelCommonId = 14,
					ConfirmCommonId = 13
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
			TeamUsage teamUsage = _cachedTempleTeamUsage;
			await Singleton<GameManager>.instance.worldManager.LeaveWorld(() =>
			{
				RunAfterLeaveService(() =>
				{
					G.service.EnterTempleChallenge(templeId, teamUsage, (bool b) =>
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
			});
		}
		else
		{
			if (_sceneStatus != SceneStatus.Abyss)
			{
				return;
			}
			await Singleton<GameManager>.instance.worldManager.LeaveWorld(() =>
			{
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
			});
		}
	}

	private async void ReopenRaid()
	{
		int raidId = _cachedRaidId;
		TeamUsage teamUsage = Model<RaidModel>.Interface.GetTeamTeachingTrialTeamUsage(raidId) ?? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidId);
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
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = MonoECS.instance.clientSceneStatus,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		await CloseAsync();
		Singleton<GameManager>.instance.worldManager.LeaveWorld(() =>
		{
			RunAfterLeaveService(() =>
			{
				G.service.RaidEnterInfo(raidId, teamUsage, (bool r) =>
				{
					if (r)
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid).Forget();
					}
				});
			});
		}).Forget();
	}

	private async void OnClickExitRaidButtonHandle()
	{
		if (_sceneStatus == SceneStatus.Raid)
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
		}
		else if (_sceneStatus == SceneStatus.Temple)
		{
			RunAfterLeaveService(() =>
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
			});
		}
		else if (_sceneStatus == SceneStatus.Abyss)
		{
			RunAfterLeaveService(() =>
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST);
			});
		}
		await CloseAsync();
	}

	private void OnPowerRefresh(BaseEventContent baseEventContent)
	{
		RefreshRaidCostState();
	}

	private void RefreshUI()
	{
		bool isTeamTeachingRaid = IsTeamTeachingRaid;
		_tipsView?.SetActive(!isTeamTeachingRaid);
		commonWorldSettlementCharacter.Refresh(_sceneStatus, Station);
		RefreshTargetTask();
		RefreshMiddleButton();
		RefreshWorldFailJumpEntryActive();
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	private void RefreshTargetTask()
	{
		List<ChallengeTargetTrackerModel.RuntimeTarget> targets = Model<ChallengeTargetTrackerModel>.Interface.GetTargets();
		bool active = targets.Count > 0;
		_targetRoot?.SetActive(active);
		int num = 0;
		int num2 = 0;
		PowerBar.gameObject.SetActive(value: false);
		switch (_sceneStatus)
		{
		case SceneStatus.Raid:
		{
			ACT.Config.Raid raid = RuntimeConfigs.data.raids[_cachedRaidId];
			RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(_cachedRaidId);
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
			num = Model<TempleModel>.Interface.GetCurChallengeTempleData().staticData.name;
			num2 = Model<ChallengeTargetTrackerModel>.Interface.GetChallengeRuntime();
			break;
		case SceneStatus.Abyss:
			num = CoreUtils.GetData(Model<AbyssModel>.Interface.CurAbyssStageId, RuntimeConfigs.data.abyssDatas).abyssNameLocal;
			num2 = ((Model<AbyssModel>.Interface.SettlementTime > 0) ? Model<AbyssModel>.Interface.SettlementTime : Model<AbyssModel>.Interface.GetAbyssTotalTime());
			break;
		}
		_name.StringReference.TableEntryReference = num;
		int num3 = num2 / 60;
		int num4 = num2 % 60;
		_time.GetVariable<string>("0").Value = $"{num3:D2}";
		_time.GetVariable<string>("1").Value = $"{num4:D2}";
		for (int i = 0; i < _targetItems.Count; i++)
		{
			if (i < targets.Count)
			{
				int targetId = targets[i].TargetId;
				_targetItems[i].gameObject.SetActive(value: true);
				_targetItems[i].RefreshUI(i, targetId, isComplete: false, -1, lastIsComplete: false, IsTeamTeachingRaid);
			}
			else
			{
				_targetItems[i].gameObject.SetActive(value: false);
			}
		}
		_multipleStar.SetActive(targets.Count > 1);
		_singleStar.SetActive(targets.Count <= 1);
	}

	private void RefreshMiddleButton()
	{
		if (_sceneStatus == SceneStatus.Raid && !IsTeamTeachingRaid)
		{
			RefreshRaidCostState();
			return;
		}
		CostPower.SetActive(value: false);
		CostTimes.SetActive(value: false);
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

	private void RefreshWorldFailJumpEntryActive()
	{
		RaidType cachedRaidType = (RaidType)_cachedRaidType;
		bool flag = cachedRaidType == RaidType.dairy || cachedRaidType == RaidType.weekly || cachedRaidType == RaidType.boss || cachedRaidType == RaidType.upGrade;
		bool flag2 = !IsTeamTeachingRaid & flag;
		_jumpRoot?.SetActive(flag2);
		worldFailJumpToCharacterEntry?.gameObject.SetActive(flag2 && worldFailJumpToCharacterEntry.JumpIsLegal());
		worldFailJumpToHandBookEntry?.gameObject.SetActive(flag2 && worldFailJumpToHandBookEntry.JumpIsLegal());
		RefreshJumpPromptState();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			viewControlLayer.UnFocus();
			viewControlLayer.Focus();
		}
		RefreshJumpPromptState();
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			viewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			viewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			viewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			viewControlRoot.SelectDown();
			break;
		}
	}

	public void OnRightStickPress()
	{
		if (PowerBar != null && PowerBar.addPowerBtn != null && PowerBar.addPowerBtn.gameObject.activeSelf && PowerBar.addPowerBtn.IsInteractable())
		{
			SetPowerBarPromptActive(active: false);
			PowerBar.addPowerBtn.OnSubmit(null);
		}
	}

	public void SetPowerBarPromptActive(bool active)
	{
		powerBarPrompt?.SetVisible(active);
	}

	private void RefreshJumpPromptState()
	{
		worldFailJumpToCharacterEntry?.RefreshGamepadPromptState();
		worldFailJumpToHandBookEntry?.RefreshGamepadPromptState();
	}
}
