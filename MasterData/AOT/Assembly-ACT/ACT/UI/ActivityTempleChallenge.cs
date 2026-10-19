using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityTempleChallenge : ActivityCenterBaseUIView<ActivityTempleChallengeController>
{
	public enum Btn_state
	{
		locked = 1,
		Unlocked,
		Current,
		Cleared
	}

	[SerializeField]
	private TextMeshProUGUI ProgressText;

	[SerializeField]
	private List<ActButton> TempleChallengeBtnlist;

	[SerializeField]
	private List<RawImage> TempleChallengeImglist;

	[SerializeField]
	private List<GameObject> LockedGrouplist;

	[SerializeField]
	private List<TextMeshProUGUI> LockedTextlist;

	[SerializeField]
	private List<GameObject> LockedIconlist;

	[SerializeField]
	private List<GameObject> CompleteIconlist;

	[SerializeField]
	private RawImage BG;

	[SerializeField]
	private GameObject SuiPian;

	[SerializeField]
	private GameObject Btn_group;

	[SerializeField]
	private List<Texture> ImageGroup;

	[SerializeField]
	private Texture UnCompleteBG;

	[SerializeField]
	private Texture CompleteBG;

	[SerializeField]
	private List<RedDotItem> redDotList;

	[SerializeField]
	private TimeAndDesItem TimeAndDesItem;

	[SerializeField]
	private List<GameObject> GamepadTipList;

	[SerializeField]
	private List<GameObject> GamepadSelectList;

	[SerializeField]
	private GamePadTipsComp GamePadTipsComp;

	[SerializeField]
	private CommonScrollBagComponent _commonScrollBagComponent;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public List<GameObject> MainSelectPropmts;

	private ActivityTempleChallengeViewData m_data;

	private int CurrentIndex = -1;

	public const int LocalizeId_ActivityTempleChallenge_UnlockedDay = 1815;

	public const int LocalizeId_ActivityTempleChallenge_Progress = 1816;

	public const int LocalizeId_ActivityTempleChallenge_AllClear = 1817;

	private Dictionary<int, ActivityCenterNavigation> _navigationDic = new Dictionary<int, ActivityCenterNavigation>();

	private int _curSelectGamepadIndex = -1;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private ActivityCenterData _activityCenterData;

	private readonly StringBuilder _progressTextBuilder = new StringBuilder(64);

	private ActivityTempleChallengeControlType ControlType
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

	private void RefreshProgressText(string localizedText, bool completed, int clearNumbers)
	{
		_progressTextBuilder.Clear();
		_progressTextBuilder.Append("<color=#FFFFFF>").Append(localizedText);
		if (!completed)
		{
			_progressTextBuilder.Append(" </color> <color=#F8D189>").Append(clearNumbers).Append("</color><color=#FFFFFF>/5");
		}
		_progressTextBuilder.Append("</color>");
		ProgressText.SetText(_progressTextBuilder);
	}

	protected override void Init()
	{
		_navigationDic.Clear();
		_navigationDic.Add(0, new ActivityCenterNavigation
		{
			Left = -1,
			Right = 4,
			Up = 1,
			Down = 4
		});
		_navigationDic.Add(1, new ActivityCenterNavigation
		{
			Left = 0,
			Right = 2,
			Up = -1,
			Down = 4
		});
		_navigationDic.Add(2, new ActivityCenterNavigation
		{
			Left = 1,
			Right = -1,
			Up = -1,
			Down = 3
		});
		_navigationDic.Add(3, new ActivityCenterNavigation
		{
			Left = 4,
			Right = -1,
			Up = 2,
			Down = -1
		});
		_navigationDic.Add(4, new ActivityCenterNavigation
		{
			Left = 0,
			Right = 3,
			Up = 1,
			Down = -1
		});
		InitGameTipsDic();
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Abyss_Challenge/Open");
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(ActivityTempleChallengeModel.ActivityId);
		InitPanel();
	}

	private void InitGameTipsDic()
	{
		actionDic.Clear();
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect",
			localizeKey = 2164,
			localizeTable = "Common"
		});
	}

	protected override void UnInit()
	{
		_navigationDic.Clear();
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
		for (int i = 0; i < GamepadTipList.Count; i++)
		{
			SetItemGamepadSelect(i, value: false);
		}
		_curSelectGamepadIndex = -1;
	}

	public override void OnPushStack()
	{
		base.OnPushStack();
		foreach (ActButton item in TempleChallengeBtnlist)
		{
			item.gameObject.SetActive(value: false);
		}
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		foreach (ActButton item in TempleChallengeBtnlist)
		{
			item.gameObject.SetActive(value: true);
		}
	}

	private void InitPanel()
	{
		for (int i = 0; i < TempleChallengeBtnlist.Count; i++)
		{
			int index = i;
			_ = Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).IsClear;
			TempleChallengeBtnlist[index].gameObject.SetActive(value: true);
			TempleChallengeBtnlist[index].Interactable(active: true);
			TempleChallengeBtnlist[index].SetBtnClick(() =>
			{
				OpenTempleChallenge(index);
			}, "event:/UI/Interface/Plan/Select");
			TempleChallengeBtnlist[index].OnEnter.RemoveAllListeners();
			TempleChallengeBtnlist[index].OnEnter.AddListener(() =>
			{
				OnChallengeBtnEnter(index);
			});
		}
		TimeAndDesItem.Init(_activityCenterData, -1L);
		RefreshPanel();
	}

	private void OnChallengeBtnEnter(int index)
	{
		if (Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).UnLocked && !Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).IsClear)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Abyss_Challenge/Click");
		}
	}

	private void RefreshRedDot()
	{
		for (int i = 0; i < redDotList.Count; i++)
		{
			RedDotItem redDotItem = redDotList[i];
			redDotItem.redDotType = RedDotType.Dot;
			ActivityTempleChallengeModel.ActivitTempleChallengeModelPhaseInfo activitTempleChallengeInfo = Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(i);
			if (activitTempleChallengeInfo != null && activitTempleChallengeInfo.ActivityChallengeGroupData.challengeId.Length != 0)
			{
				int num = activitTempleChallengeInfo.ActivityChallengeGroupData.challengeId[0];
				redDotItem.fullPath = (RedDotPathDefine.Activity_Temple + $"|{num}").Split("|").ToList();
				redDotItem.BindTrieNode();
				redDotItem.UpdateDisplay();
			}
		}
	}

	private void SetRedpointState(int challengeId)
	{
		if (Model<ActivityTempleChallengeModel>.Interface.GetActivityChallengeRedpointState(challengeId))
		{
			G.localPlayer.redPoints.ActivityChallenges[challengeId] = false;
			RedPoints redPoints = new RedPoints();
			redPoints.ActivityChallenges.Add(challengeId, value: false);
			G.service.RefreshRedDot(redPoints, (bool value) =>
			{
				Model<ActivityTempleChallengeModel>.Interface.RefreshRedDot();
				RefreshRedDot();
			});
		}
	}

	private void RefreshPanel()
	{
		Model<ActivityTempleChallengeModel>.Interface.RefreshActivityData();
		Model<ActivityTempleChallengeModel>.Interface.RefreshDailyTempleChallengePhaseInfos();
		TimeAndDesItem.Init(_activityCenterData, -1L);
		int num = 0;
		for (int i = 0; i < TempleChallengeImglist.Count; i++)
		{
			if (Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(i).UnLocked)
			{
				if (Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(i).IsClear)
				{
					num++;
					SetPraseCleared(i);
				}
				else
				{
					SetPraseUnlocked(i);
				}
			}
			else
			{
				SetPraselocked(i);
			}
		}
		if (num >= 5)
		{
			SuiPian.SetActive(value: false);
			Btn_group.SetActive(value: false);
			BG.texture = CompleteBG;
			string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1817);
			RefreshProgressText(localizeString, completed: true, num);
		}
		else
		{
			SuiPian.SetActive(value: true);
			Btn_group.SetActive(value: true);
			BG.texture = UnCompleteBG;
			string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1816);
			RefreshProgressText(localizeString2, completed: false, num);
		}
		RefreshRewardsPreview();
		Model<ActivityTempleChallengeModel>.Interface.RefreshRedDot();
		RefreshRedDot();
	}

	public void OpenTempleChallenge(int index)
	{
		if (Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).UnLocked)
		{
			Model<ActivityCenterModel>.Interface.OpenActivityID = Model<ActivityTempleChallengeModel>.Interface._activityData.id;
			ActivityTempleChallengeModel.ActivitTempleChallengeModelPhaseInfo activitTempleChallengeInfo = Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index);
			if (activitTempleChallengeInfo != null && activitTempleChallengeInfo.ActivityChallengeGroupData.challengeId.Length != 0)
			{
				SetRedpointState(activitTempleChallengeInfo.ActivityChallengeGroupData.challengeId[0]);
			}
			RaidBtn(index);
		}
	}

	public void OnClickActivityDetailButtonHandle()
	{
		ActivityData activityData = Model<ActivityTempleChallengeModel>.Interface._activityData;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			descTextId = activityData.activityDesc,
			iconId = 3001,
			titleTextId = activityData.activityName
		});
	}

	private void RefreshRewardsPreview()
	{
		_commonScrollBagComponent.Station = ActivityCenterView.Station;
		_commonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		_commonScrollBagComponent.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		_commonScrollBagComponent.ItemSource = GetRewardPreView();
	}

	private List<ItemUnifierProxy> GetRewardPreView()
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int i = 0; i < _activityCenterData.StaticActivityData.activityChallengGroup.Length; i++)
		{
			int key = RuntimeConfigs.data.activityChallengeGroups[_activityCenterData.StaticActivityData.activityChallengGroup[i]].challengeId[0];
			int key2 = RuntimeConfigs.data.activityChallengeDatas[key].challengeJump[0];
			int key3 = RuntimeConfigs.data.raidEntranceDatas[key2].raidId[0];
			foreach (ItemKv item in RuntimeConfigs.data.raids[key3].firstReward)
			{
				Collection data = CoreUtils.GetData(item.count, RuntimeConfigs.data.collections);
				if (data == null)
				{
					continue;
				}
				foreach (ItemKv item2 in data.certain)
				{
					if (dictionary.ContainsKey(item2.id))
					{
						dictionary[item2.id] += item2.count;
					}
					else
					{
						dictionary.Add(item2.id, item2.count);
					}
				}
			}
		}
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (KeyValuePair<int, int> item3 in dictionary)
		{
			list.Add(ItemUnifierProxy.ItemUnifierPool.Get(new Item
			{
				Id = item3.Key,
				Count = item3.Value
			}));
		}
		list.Sort(SortUtility.SortItemUnifierProxy2);
		return list;
	}

	private async void RaidBtn(int index)
	{
		ActivityChallengeData data = CoreUtils.GetData(Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).ActivityChallengeGroupData.challengeId[0], RuntimeConfigs.data.activityChallengeDatas);
		if (data != null)
		{
			RuntimeConfigs.data.raidEntranceDatas.TryGetValue(data.challengeJump.FirstOrDefault(), out var value);
			if (value != null)
			{
				int id = value.id;
				_ = value.raidId[0];
				ActivityTempleChallengeModel.ActivitTempleChallengeModelPhaseInfo activitTempleChallengeInfo = Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index);
				_ = activitTempleChallengeInfo.IsClear;
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
				{
					RaidEntranceId = id
				});
				ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
				evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
				evt.status = 2;
				evt.challengeGroupId = activitTempleChallengeInfo.ActivityChallengeGroupData.id;
				evt.challengeId = activitTempleChallengeInfo.ActivityChallengeGroupData.challengeId.FirstOrDefault();
				evt.isPopup = false;
				EventTrackSolver.Instance.Dispatch(evt);
			}
		}
	}

	private void SetPraselocked(int index)
	{
		if (index >= 0 && index < LockedGrouplist.Count)
		{
			LockedGrouplist[index].SetActive(value: true);
		}
		if (index >= 0 && index < LockedIconlist.Count)
		{
			LockedIconlist[index].SetActive(value: true);
		}
		if (index >= 0 && index < LockedTextlist.Count)
		{
			int daysLeft = Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).DaysLeft;
			string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1815);
			LockedTextlist[index].text = daysLeft + localizeString;
		}
		if (index >= 0 && index < CompleteIconlist.Count)
		{
			CompleteIconlist[index].SetActive(value: false);
		}
		int imgIndex = ConvetToPicId(index, Btn_state.locked);
		SetImageState(imgIndex, TempleChallengeImglist[index]);
	}

	private void SetPraseUnlocked(int index)
	{
		if (index >= 0 && index < LockedGrouplist.Count)
		{
			LockedGrouplist[index].SetActive(value: false);
		}
		if (index >= 0 && index < LockedIconlist.Count)
		{
			LockedIconlist[index].SetActive(value: false);
		}
		if (index >= 0 && index < CompleteIconlist.Count)
		{
			CompleteIconlist[index].SetActive(value: false);
		}
		int imgIndex = ConvetToPicId(index, Btn_state.Unlocked);
		SetImageState(imgIndex, TempleChallengeImglist[index]);
	}

	private void SetPraseCleared(int index)
	{
		if (index >= 0 && index < LockedGrouplist.Count)
		{
			LockedGrouplist[index].SetActive(value: false);
		}
		if (index >= 0 && index < LockedIconlist.Count)
		{
			LockedIconlist[index].SetActive(value: false);
		}
		if (index >= 0 && index < CompleteIconlist.Count)
		{
			CompleteIconlist[index].SetActive(value: true);
		}
		int imgIndex = ConvetToPicId(index, Btn_state.Cleared);
		SetImageState(imgIndex, TempleChallengeImglist[index]);
	}

	private int ConvetToPicId(int tens, Btn_state units)
	{
		return (int)((tens + 1) * 10 + units);
	}

	private void SetImageState(int ImgIndex, RawImage RawImage)
	{
		int num = ImgIndex / 10;
		int num2 = ImgIndex % 10;
		int index = (num - 1) * 4 + (num2 - 1);
		Texture texture = ImageGroup[index];
		RawImage.texture = texture;
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			for (int i = 0; i < GamepadTipList.Count; i++)
			{
				SetItemGamepadSelect(i, value: false);
			}
			_curSelectGamepadIndex = -1;
		}
		else
		{
			_curSelectGamepadIndex = 0;
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
			RefreshGamepadComp();
			ChangeControlType(ActivityTempleChallengeControlType.Main);
		}
	}

	private void RefreshGamepadComp()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			_tipsActions.Clear();
			GamePadTipsComp.ClearAllPrompts();
			if (ControlType == ActivityTempleChallengeControlType.Main)
			{
				_tipsActions.Add(actionDic["UI/Back"]);
			}
			else if (ControlType == ActivityTempleChallengeControlType.Reward)
			{
				_tipsActions.Add(actionDic["UI/Confirm"]);
				_tipsActions.Add(actionDic["UI/Back"]);
			}
			GamePadTipsComp.RegisterInputActions(_tipsActions);
		}
	}

	public void Left()
	{
		if (_navigationDic.ContainsKey(_curSelectGamepadIndex) && _navigationDic[_curSelectGamepadIndex].Left != -1)
		{
			SetItemGamepadSelect(_curSelectGamepadIndex, value: false);
			_curSelectGamepadIndex = _navigationDic[_curSelectGamepadIndex].Left;
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
		}
	}

	public void Right()
	{
		if (_navigationDic.ContainsKey(_curSelectGamepadIndex) && _navigationDic[_curSelectGamepadIndex].Right != -1)
		{
			SetItemGamepadSelect(_curSelectGamepadIndex, value: false);
			_curSelectGamepadIndex = _navigationDic[_curSelectGamepadIndex].Right;
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
		}
	}

	public void Up()
	{
		if (_navigationDic.ContainsKey(_curSelectGamepadIndex) && _navigationDic[_curSelectGamepadIndex].Up != -1)
		{
			SetItemGamepadSelect(_curSelectGamepadIndex, value: false);
			_curSelectGamepadIndex = _navigationDic[_curSelectGamepadIndex].Up;
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
		}
	}

	public void Down()
	{
		if (_navigationDic.ContainsKey(_curSelectGamepadIndex) && _navigationDic[_curSelectGamepadIndex].Down != -1)
		{
			SetItemGamepadSelect(_curSelectGamepadIndex, value: false);
			_curSelectGamepadIndex = _navigationDic[_curSelectGamepadIndex].Down;
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
		}
	}

	private void SetItemGamepadSelect(int index, bool value)
	{
		if (!value)
		{
			GamepadSelectList[index].SetActive(value: false);
			GamepadTipList[index].SetActive(value: false);
			return;
		}
		GamepadSelectList[index].SetActive(value: true);
		if (Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(index).UnLocked && !Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(_curSelectGamepadIndex).IsClear)
		{
			GamepadTipList[index].SetActive(value: true);
		}
	}

	public void RightStickPress()
	{
		OnClickActivityDetailButtonHandle();
	}

	public void ButtonSouth()
	{
		if (ControlType == ActivityTempleChallengeControlType.Reward)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
		else if (_curSelectGamepadIndex != -1 && Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(_curSelectGamepadIndex).UnLocked && !Model<ActivityTempleChallengeModel>.Interface.GetActivitTempleChallengeInfo(_curSelectGamepadIndex).IsClear)
		{
			OpenTempleChallenge(_curSelectGamepadIndex);
		}
	}

	public void ButtonEast()
	{
		if (ControlType == ActivityTempleChallengeControlType.Reward)
		{
			ChangeControlType(ActivityTempleChallengeControlType.Main);
		}
		else
		{
			ActivityCenterView.Exit();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
	}

	public void ChangeControlType(ActivityTempleChallengeControlType controlType)
	{
		ControlType = controlType;
		RefreshGamepadComp();
		switch (controlType)
		{
		case ActivityTempleChallengeControlType.Main:
			ViewControlLayer.UnFocus();
			SetItemGamepadSelect(_curSelectGamepadIndex, value: true);
			break;
		case ActivityTempleChallengeControlType.Reward:
			ViewControlLayer.Focus();
			SetItemGamepadSelect(_curSelectGamepadIndex, value: false);
			break;
		}
		for (int i = 0; i < MainSelectPropmts.Count; i++)
		{
			MainSelectPropmts[i].SetActive(controlType == ActivityTempleChallengeControlType.Main);
		}
	}
}
