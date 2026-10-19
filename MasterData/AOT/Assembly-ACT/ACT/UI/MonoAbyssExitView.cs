using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.ViewComponent.RaidView;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoAbyssExitView : BaseUIView<AbyssExitViewInputController>
{
	public ActButton Continue;

	public ActButton Set;

	public ActButton RePlay;

	public ActButton Exit;

	public ActButton Leave;

	public GameObject GamePadTips;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	private const int AbyssRechallengeLocalizeId = 2913;

	private const int RechallengeLocalizeId = 487;

	private const int TeamTeachingExitConfirmLocalizeId = 2195;

	private const int TempleExitConfirmLocalizeId = 2200;

	private bool _isTeamTeaching;

	private bool _isRaid;

	private bool _isTemple;

	private bool _actionInProgress;

	private int _teamTeachingRaidId;

	private TrainingContents _teamTeachingContent;

	private int _raidId;

	private int _raidType;

	private int _templeId;

	private TeamUsage _templeTeamUsage;

	protected override void Init()
	{
		base.Init();
		CacheExitModeContext();
		RefreshReplayPresentation();
		Continue.SetBtnClick(OnClickContinueHandle);
		Set.SetBtnClick(OnClickSetHandle);
		RePlay.SetBtnClick(OnClickReplayHandle);
		Exit.SetBtnClick(OnClickExitHandle);
		Leave.SetBtnClick(OnClickLeaveHandle);
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void ReInit()
	{
		base.ReInit();
		CacheExitModeContext();
		RefreshReplayPresentation();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	private void OnClickContinueHandle()
	{
		Close();
	}

	private void OnClickSetHandle()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SETTINGS).Forget();
	}

	private void OnClickReplayHandle()
	{
		if (_isTeamTeaching)
		{
			RechallengeTeamTeaching();
			return;
		}
		if (_isRaid)
		{
			RechallengeRaid();
			return;
		}
		if (_isTemple)
		{
			RechallengeTemple();
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				G.service.RechallengeAbyss(onlyCurrentLayer: true, async (bool r) =>
				{
					if (r)
					{
						await Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: true, 0.5f);
						await Singleton<GameManager>.instance.worldManager.LeaveWorld(() =>
						{
							Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: false, 0.5f).Forget();
							Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Abyss).Forget();
						});
					}
				});
			},
			commonId = 2912
		});
	}

	private void OnClickExitHandle()
	{
		if (_isTeamTeaching)
		{
			ExitTeamTeaching();
			return;
		}
		if (_isRaid)
		{
			ExitRaid();
			return;
		}
		if (_isTemple)
		{
			ExitTemple();
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				G.service.LeaveAbyss(async (bool r) =>
				{
					if (r)
					{
						Close();
						Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
						await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ABYSSLIST);
						Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
					}
				});
			},
			titleId = 2127,
			commonId = 2198
		});
	}

	private void CacheExitModeContext()
	{
		AbyssExitViewData abyssExitViewData = uiViewData as AbyssExitViewData;
		bool flag = Model<TeamTeachingModel>.HasInstance() && Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid();
		_isTeamTeaching = (abyssExitViewData?.IsTeamTeaching ?? false) | flag;
		_isRaid = !_isTeamTeaching && (abyssExitViewData?.IsRaid ?? false);
		_isTemple = !_isTeamTeaching && !_isRaid && (abyssExitViewData?.IsTemple ?? false);
		if (_isTeamTeaching)
		{
			CacheTeamTeachingContext();
		}
		else if (_isRaid)
		{
			CacheRaidContext();
		}
		else if (_isTemple)
		{
			CacheTempleContext();
		}
	}

	private void RefreshReplayPresentation()
	{
		LocalizeStringEvent componentInChildren = RePlay.GetComponentInChildren<LocalizeStringEvent>(includeInactive: true);
		if (!(componentInChildren == null))
		{
			componentInChildren.StringReference.TableReference = "Common";
			componentInChildren.StringReference.TableEntryReference = 2913L;
			componentInChildren.RefreshString();
			if ((_isTeamTeaching || _isRaid || _isTemple) && !(RePlay == null))
			{
				componentInChildren.StringReference.TableReference = "Common";
				componentInChildren.StringReference.TableEntryReference = 487L;
				componentInChildren.RefreshString();
			}
		}
	}

	private void CacheTeamTeachingContext()
	{
		if (!Model<RaidModel>.HasInstance())
		{
			return;
		}
		_teamTeachingRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		if (Model<TeamTeachingModel>.HasInstance())
		{
			_teamTeachingContent = Model<TeamTeachingModel>.Interface.CurrentTrainingContent;
		}
		if (_teamTeachingContent != null || RuntimeConfigs.data?.trainingContentss == null)
		{
			return;
		}
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value?.raidID == _teamTeachingRaidId)
			{
				_teamTeachingContent = value;
				break;
			}
		}
	}

	private void RechallengeTeamTeaching()
	{
		if (_actionInProgress || _teamTeachingRaidId <= 0)
		{
			return;
		}
		int raidId = _teamTeachingRaidId;
		TeamUsage teamUsage = Model<RaidModel>.Interface.GetTeamTeachingTrialTeamUsage(raidId) ?? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidId);
		if (teamUsage == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[TeamTeaching] Raid {raidId} has no valid trial team configuration.");
			}
		}
		else
		{
			_actionInProgress = true;
			G.service.LeaveRaid((bool success) =>
			{
				OnTeamTeachingLeaveForRechallenge(success, raidId, teamUsage);
			});
		}
	}

	private async void OnTeamTeachingLeaveForRechallenge(bool success, int raidId, TeamUsage teamUsage)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = SceneStatus.Raid,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.RaidEnterInfo(raidId, teamUsage, OnTeamTeachingReenterComplete);
	}

	private void OnTeamTeachingReenterComplete(bool success)
	{
		_actionInProgress = false;
		Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(success ? SceneStatus.Raid : SceneStatus.Main).Forget();
	}

	private void ExitTeamTeaching()
	{
		if (!_actionInProgress)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				OnConfirm = () =>
				{
					_actionInProgress = true;
					G.service.LeaveRaid(OnTeamTeachingLeaveForExit);
				},
				commonId = 2194
			});
		}
	}

	private async void OnTeamTeachingLeaveForExit(bool success)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
		await CloseAsync();
		int[] array = _teamTeachingContent?.teamCharacter;
		if (array != null && array.Length > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMTEACHING, new TeamTeachingViewData
			{
				MainTabId = _teamTeachingContent.IdBelong,
				TrainingContentId = _teamTeachingContent.id,
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
		Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
		_actionInProgress = false;
	}

	private void CacheRaidContext()
	{
		if (Model<RaidModel>.HasInstance())
		{
			_raidId = Model<RaidModel>.Interface.CurrentRaidId;
			_raidType = Model<RaidModel>.Interface.GetRaidType(_raidId);
		}
	}

	private async void RechallengeRaid()
	{
		if (_actionInProgress || _raidId <= 0)
		{
			return;
		}
		RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(_raidId);
		if (raidTypeConfig != null)
		{
			if (raidTypeConfig.cost != null && raidTypeConfig.cost.Count > 0 && Model<PowerModel>.Interface.PowerCount < Model<RaidModel>.Interface.PowerCost)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
			}
			else if (raidTypeConfig.cycleType == 2 && GetRaidLeftTimes(raidTypeConfig.id) <= 0)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
				{
					titleId = 483,
					commonId = 1609,
					OnConfirm = StartRaidRechallenge,
					CancelCommonId = 14,
					ConfirmCommonId = 13
				});
			}
			else
			{
				StartRaidRechallenge();
			}
		}
	}

	private void StartRaidRechallenge()
	{
		if (_actionInProgress || _raidId <= 0)
		{
			return;
		}
		int raidId = _raidId;
		TeamUsage teamUsage = CreateCurrentRaidTeamUsage(raidId);
		if (teamUsage == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[Raid] Raid {raidId} has no valid team configuration.");
			}
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				_actionInProgress = true;
				G.service.LeaveRaid((bool success) =>
				{
					OnRaidLeaveForRechallenge(success, raidId, teamUsage);
				});
			},
			commonId = 2911
		});
	}

	private TeamUsage CreateCurrentRaidTeamUsage(int raidId)
	{
		TeamUsage teamUsage = Model<RaidModel>.Interface.GetTeamTeachingTrialTeamUsage(raidId) ?? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidId);
		if (teamUsage != null)
		{
			return teamUsage;
		}
		teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
		List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
		if (curTeamCharacters == null)
		{
			return teamUsage;
		}
		foreach (Character item in curTeamCharacters)
		{
			TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
			teamCharacterUsage.CharacterId = item.Id;
			teamUsage.CharacterUsage.Add(teamCharacterUsage);
		}
		return teamUsage;
	}

	private void OnRaidLeaveForRechallenge(bool success, int raidId, TeamUsage teamUsage)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = SceneStatus.Raid,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		_actionInProgress = false;
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
	}

	private void ExitRaid()
	{
		if (!_actionInProgress)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				OnConfirm = () =>
				{
					_actionInProgress = true;
					G.service.LeaveRaid(OnRaidLeaveForExit);
				},
				commonId = 2194
			});
		}
	}

	private (int, string[]) GetRaidExitConfirmLocalize()
	{
		string[] item = new string[0];
		if (_raidType == 6)
		{
			ACT.Config.Raid data = CoreUtils.GetData(_raidId, RuntimeConfigs.data.raids);
			if (data != null && data.tryRole != null && data.tryRole.Length != 0)
			{
				EntityCharacterProbation data2 = CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations);
				if (data2.isShow == 0 || 1 == 0)
				{
					EntityData data3 = CoreUtils.GetData(data2.characterId, RuntimeConfigs.data.entityDatas);
					return (2521, new string[1] { LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data3.nameLocal) });
				}
				return (2520, item);
			}
		}
		return _raidType switch
		{
			1 => (2195, item), 
			3 => (2196, item), 
			7 => (2194, item), 
			8 => (2197, item), 
			_ => (2195, item), 
		};
	}

	private async void OnRaidLeaveForExit(bool success)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
		await CloseAsync();
		switch ((RaidType)_raidType)
		{
		case RaidType.dairy:
		case RaidType.weekly:
		case RaidType.parkour:
		case RaidType.boss:
		{
			ACT.Config.Raid raid = CoreUtils.GetData(_raidId, RuntimeConfigs.data.raids);
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
		{
			ACT.Config.Raid data = CoreUtils.GetData(_raidId, RuntimeConfigs.data.raids);
			if (data != null && data.tryRole != null && data.tryRole.Length != 0)
			{
				if (CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations).isShow == 0)
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
		Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
		_actionInProgress = false;
	}

	private int GetRaidLeftTimes(int typeId)
	{
		if (!RuntimeConfigs.data.raidTypeDatas.TryGetValue(typeId, out var value) || value.cycleParm == null || value.cycleParm.Length < 2)
		{
			return 0;
		}
		int num = 0;
		int[] raidEntranceId = value.raidEntranceId;
		foreach (int key in raidEntranceId)
		{
			if (!RuntimeConfigs.data.raidEntranceDatas.TryGetValue(key, out var value2))
			{
				continue;
			}
			int[] raidId = value2.raidId;
			foreach (int raidId2 in raidId)
			{
				ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
				if (raidInfo != null)
				{
					num += raidInfo.TakeRewardCount;
				}
			}
		}
		return Mathf.Max(0, value.cycleParm[1] - num);
	}

	private void CacheTempleContext()
	{
		if (Model<TempleModel>.HasInstance())
		{
			_templeId = Model<TempleModel>.Interface.CurChallengeTempleId;
			_templeTeamUsage = CreateTempleTeamUsage();
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

	private void RechallengeTemple()
	{
		if (_actionInProgress || _templeId <= 0)
		{
			return;
		}
		int templeId = _templeId;
		TeamUsage teamUsage = _templeTeamUsage;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				_actionInProgress = true;
				G.service.LeaveTemple((bool success) =>
				{
					OnTempleLeaveForRechallenge(success, templeId, teamUsage);
				});
			},
			commonId = 2910
		});
	}

	private async void OnTempleLeaveForRechallenge(bool success, int templeId, TeamUsage teamUsage)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = SceneStatus.Temple,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		await Singleton<GameManager>.instance.worldManager.LeaveWorld();
		G.service.EnterTempleChallenge(templeId, teamUsage, OnTempleReenterComplete);
	}

	private void OnTempleReenterComplete(bool success)
	{
		_actionInProgress = false;
		if (!success && LuminApplication.LogEnabled)
		{
			Debug.LogError($"进入神庙[{_templeId}]失败!!!");
		}
		Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(success ? SceneStatus.Temple : SceneStatus.Main).Forget();
	}

	private void ExitTemple()
	{
		if (!_actionInProgress)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				OnConfirm = () =>
				{
					_actionInProgress = true;
					G.service.LeaveTemple(OnTempleLeaveForExit);
				},
				commonId = 2200
			});
		}
	}

	private async void OnTempleLeaveForExit(bool success)
	{
		if (!success)
		{
			_actionInProgress = false;
			return;
		}
		Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
		await CloseAsync();
		Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
		Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
		_actionInProgress = false;
	}

	private void OnClickLeaveHandle()
	{
	}

	public void OnInputControllerDeviceChange(DeviceInputMode type)
	{
		OnInputDeviceChange(type);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamePadTips.SetActive(type == DeviceInputMode.Gamepad);
		if (type == DeviceInputMode.Gamepad)
		{
			ViewControlLayer.ReFocus();
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
	}
}
