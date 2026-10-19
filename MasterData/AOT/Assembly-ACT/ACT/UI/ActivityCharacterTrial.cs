using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityCharacterTrial : ActivityCenterBaseUIView<ActivityCharacterTrialController>
{
	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	public TimeAndDesItem TimeAndDesItem;

	public CharacterProfessionIcon CharacterProfessionIcon;

	public BImage CharacterQulity;

	public TextMeshProUGUI CharacterName;

	public CharacterMannerItem CharacterMannerItem;

	public List<CharacterOverTagtem> CharacterOverTagtems;

	public List<ActivityCharacterTrialItem> ActivityCharacterTrialItems;

	public CommonScrollBagComponent CommonScrollBagComponent;

	public GameObject NormalButton;

	public ActButton ReceiveButton;

	public GameObject ReceivedButton;

	public Button GotoGacha;

	public Button GotoTrail;

	public ActButton HelpButton;

	public GameObject GamepadTipsRoot;

	public Dictionary<ActivityCharacterTrialControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<ActivityCharacterTrialControlType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<ActivityCharacterTrialControlType, ViewControlLayer> ControlLayerDic;

	public GameObject Prompt_A;

	private ActivitRoleTrialInfo _activityRoleTrialInfo;

	private new ImageAssetStation Station;

	private int curSelectChallengeGroupId;

	private GameObject _currentCharacterGameObject;

	private ActivityCenterData _activityCenterData;

	private ActivityCharacterTrialControlType ControlType
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

	protected override void Init()
	{
		ActivityCenterView activityCenterView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ACTIVITYCENTER) as ActivityCenterView;
		Station = activityCenterView.Station;
		RefreshUI();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").Play();
		}
	}

	protected override void UnInit()
	{
		Station = null;
	}

	private void ReportActivityEvent(int activityId, int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OnClickReceiveRewardButtonHandle()
	{
		ActivityData data = CoreUtils.GetData(_activityRoleTrialInfo.ActivityId, RuntimeConfigs.data.activityDatas);
		ActivityChallengeGroup data2 = CoreUtils.GetData(curSelectChallengeGroupId, RuntimeConfigs.data.activityChallengeGroups);
		int activityId = data.id;
		int challengeGroupId = data2.id;
		int challengeId = data2.challengeId[0];
		G.service.ActivityRoleTrialRewardReq(activityId, challengeGroupId, challengeId, (ActivityRoleTrialRewardAck r) =>
		{
			if (r != null)
			{
				ReportActivityEvent(activityId, challengeId, challengeGroupId, 3);
				List<Item> list = ListPool<Item>.Get();
				for (int i = 0; i < r.Items.Count; i++)
				{
					Item item = new Item
					{
						Id = r.Items[i].Index,
						Count = r.Items[i].Count
					};
					list.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
				RefreshRewardState(challengeGroupId);
				Model<ActivityCenterModel>.Interface.RefreshActivityCharacterTrialRedDotState();
				for (int j = 0; j < ActivityCharacterTrialItems.Count; j++)
				{
					if (ActivityCharacterTrialItems[j].challengeGroupId == challengeGroupId)
					{
						ActivityCharacterTrialItems[j].RefreshUI(challengeGroupId, Station);
					}
				}
			}
		});
	}

	public void OnClickGotoGachaBtnHandle()
	{
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[curSelectChallengeGroupId];
		int item = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]].extraParm[1];
		RuntimeJumpData jumpData = new RuntimeJumpData
		{
			ModelType = LuminModelType.Gacha,
			JumpType = 2,
			Params = new List<int>
			{
				JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_CARDDRAW],
				item
			}
		};
		JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(jumpData);
		if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
		{
			Model<JumpModel>.Interface.JumpTo(jumpData);
		}
		else if (!string.IsNullOrEmpty(jumpResult.Message))
		{
			GameUtility.OpenToolTip(jumpResult.Message);
		}
		ReportActivityEvent(_activityRoleTrialInfo.ActivityId, activityChallengeGroup.challengeId[0], activityChallengeGroup.id, 4);
	}

	public void OnClickGotoTrailBtnHandle()
	{
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[curSelectChallengeGroupId];
		int num = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]].extraParm[0];
		if (num != 0)
		{
			foreach (ItemKv item in CoreUtils.GetData(num, RuntimeConfigs.data.CharacterProbationRaids).typeRaidID)
			{
				if (item.id != 3)
				{
					continue;
				}
				TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(item.count);
				G.service.RaidEnterInfo(item.count, raidTrialTeamUsage, async (bool r) =>
				{
					if (r)
					{
						await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
					}
				});
				break;
			}
		}
		ReportActivityEvent(_activityRoleTrialInfo.ActivityId, activityChallengeGroup.challengeId[0], activityChallengeGroup.id, 2);
	}

	private void RefreshUI()
	{
		_activityRoleTrialInfo = Model<ActivityCenterModel>.Interface.GetActivityRoleTrialInfo(Model<ActivityCenterModel>.Interface.SelectActivityId);
		if (_activityRoleTrialInfo == null)
		{
			return;
		}
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activityRoleTrialInfo.ActivityId);
		TimeAndDesItem.Init(_activityCenterData, -1L);
		ReceiveButton.SetBtnClick(OnClickReceiveRewardButtonHandle);
		GotoGacha.SetBtnClick(OnClickGotoGachaBtnHandle);
		GotoTrail.SetBtnClick(OnClickGotoTrailBtnHandle);
		ActivityData activityData = RuntimeConfigs.data.activityDatas[_activityRoleTrialInfo.ActivityId];
		for (int i = 0; i < ActivityCharacterTrialItems.Count; i++)
		{
			if (i >= activityData.activityChallengGroup.Length)
			{
				ActivityCharacterTrialItems[i].gameObject.SetActive(value: false);
				continue;
			}
			int activityChallengeGroupId = activityData.activityChallengGroup[i];
			ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityChallengeGroupId];
			_ = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
			ActivityCharacterTrialItems[i].RefreshUI(activityChallengeGroupId, Station);
			ActivityCharacterTrialItems[i].onValueChanged.RemoveAllListeners();
			ActivityCharacterTrialItems[i].onValueChanged.AddListener((bool value) =>
			{
				OnClickItemBtnHandle(value, activityChallengeGroupId);
			});
			if (i == 0)
			{
				ActivityCharacterTrialItems[i].SetIsOn(val: true);
				RefreshRewardState(activityChallengeGroupId);
			}
		}
		Model<ActivityCenterModel>.Interface.RefreshActivityCharacterTrialRedDotState();
	}

	private void OnClickItemBtnHandle(bool value, int challengeGroupId)
	{
		if (value)
		{
			ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[challengeGroupId];
			int num = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]].extraParm[0];
			RefreshCharacterInfo(num);
			RefreshRewardState(challengeGroupId);
			curSelectChallengeGroupId = challengeGroupId;
			AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
			switch (num)
			{
			case 11101:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/1101");
				break;
			case 11301:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/1301");
				break;
			case 12701:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/2701");
				break;
			case 10401:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/0401");
				break;
			case 12201:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/2201");
				break;
			case 12501:
				audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/2501");
				break;
			}
			audioManager.PlaySound("event:/UI/Interface/DrawCard/Role/Click");
			CharacterTrialClick(num, 2);
		}
	}

	private void RefreshCharacterInfo(int characterId)
	{
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[characterId];
		EntityData entityData = RuntimeConfigs.data.entityDatas[characterId];
		CharacterProfessionIcon.UpdateDisPlay(characterId);
		Station.LoadImage(176, entityCharacterData.stars, CharacterQulity);
		CharacterName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, entityData.nameLocal);
		CharacterMannerItem.Init(Station, entityCharacterData.mannerType);
		int[] characterTagGroup = entityCharacterData.characterTagGroup;
		for (int i = 0; i < CharacterOverTagtems.Count; i++)
		{
			CharacterOverTagtems[i].gameObject.SetActive(characterTagGroup.Length > i);
			if (characterTagGroup.Length > i)
			{
				CharacterOverTagtems[i].Init(characterTagGroup[i]);
				CharacterOverTagtems[i].BtnClick.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
					{
						characterId = characterId
					});
				});
			}
		}
		if (_currentCharacterGameObject != null)
		{
			_currentCharacterGameObject.SetActive(value: false);
			_currentCharacterGameObject = null;
		}
		Transform transform = base.transform.Find(characterId.ToString());
		if (transform != null)
		{
			transform.gameObject.SetActive(value: true);
			_currentCharacterGameObject = transform.gameObject;
			transform.GetComponent<BetterAnimation>().GetSequence("Show").Play();
		}
	}

	private void RefreshRewardState(int activityChallengeGroupId)
	{
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityChallengeGroupId];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		ActivityCenterModel.ActivityRewardState activityCharacterTrialRewardState = Model<ActivityCenterModel>.Interface.GetActivityCharacterTrialRewardState(activityChallengeGroupId);
		NormalButton.SetActive(activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Normal);
		ReceiveButton.gameObject.SetActive(activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Receive);
		ReceivedButton.SetActive(activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Received);
		Collection collection = RuntimeConfigs.data.collections[activityChallengeData.challengeReward[0]];
		List<Item> list = ListPool<Item>.Get();
		for (int i = 0; i < collection.certain.Count; i++)
		{
			Item item = new Item
			{
				Id = collection.certain[i].id,
				Count = collection.certain[i].count
			};
			list.Add(item);
		}
		List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
		ItemUnifierProxy.ItemUnifierPool.GetList(list, list2);
		ListPool<Item>.Release(list);
		list2.Sort(SortUtility.SortItemUnifierProxy2);
		CommonScrollBagComponent.ItemShowType = ((activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Received) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem);
		CommonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		CommonScrollBagComponent.Station = Station;
		CommonScrollBagComponent.ItemSource = list2;
		Prompt_A.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && activityCharacterTrialRewardState == ActivityCenterModel.ActivityRewardState.Receive);
	}

	private void CharacterTrialClick(int characterId, int clickType)
	{
		foreach (ItemKv item in CoreUtils.GetData(characterId, RuntimeConfigs.data.CharacterProbationRaids).typeRaidID)
		{
			if (item.id == 3)
			{
				CharacterTrialActivityClickEvent evt = EventTrackSolver.Instance.GetEvt<CharacterTrialActivityClickEvent>();
				evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
				evt.raidId = item.count;
				evt.status = clickType;
				EventTrackSolver.Instance.Dispatch(evt);
			}
		}
	}

	public void OnInputModeChange(DeviceInputMode deviceInputMode)
	{
		if (GetController() != null)
		{
			GamepadTipsRoot.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
			if (deviceInputMode == DeviceInputMode.Gamepad)
			{
				ChangeControlType(ActivityCharacterTrialControlType.Main);
			}
		}
	}

	public async void ChangeControlType(ActivityCharacterTrialControlType controlType)
	{
		await UniTask.DelayFrame(1);
		ActivityCharacterTrialControlType controlType2 = ControlType;
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
		if (controlType == ActivityCharacterTrialControlType.Main && EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
		case MoveDirection.Down:
			return;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (ControlType == ActivityCharacterTrialControlType.Main && EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
		else if (ControlType == ActivityCharacterTrialControlType.Reward)
		{
			ItemUIComponentBase itemUIComponentBase = EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>();
			if (itemUIComponentBase != null)
			{
				itemUIComponentBase.SetIsOn(val: true);
			}
		}
	}

	public void OnConfirm()
	{
		if (ControlType == ActivityCharacterTrialControlType.Main)
		{
			if (ReceiveButton.gameObject.activeSelf && ReceiveButton.IsInteractable())
			{
				ReceiveButton.OnSubmit(null);
			}
		}
		else if (ControlType == ActivityCharacterTrialControlType.Reward)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnClose()
	{
		(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ACTIVITYCENTER) as ActivityCenterView).Exit();
	}
}
