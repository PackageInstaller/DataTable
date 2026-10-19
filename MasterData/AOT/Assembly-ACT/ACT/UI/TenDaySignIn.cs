using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TenDaySignIn : ActivityCenterBaseUIView<TenDaySignInController>
{
	public BetterAnimation betterAnimation;

	public int ItemAnimationPlayInterval;

	public Dictionary<int, GameObject> CharacterBG;

	public TimeAndDesItem m_TimeAndDesItem;

	public List<TenDaySignInItem> m_TenDaySignInItems;

	public GameObject GamepadTipsRoot;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public TextMeshProUGUI PromptLabel;

	private ActivityData _activityData;

	private int activityId => Model<ActivityCenterModel>.Interface.SelectActivityId;

	private ActivityCenterData activityCenterData => Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId);

	protected override void Init()
	{
		if (Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(activityId) == null || activityCenterData == null)
		{
			return;
		}
		m_TimeAndDesItem.Init(activityCenterData, -1L);
		RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value);
		if (value == null)
		{
			return;
		}
		_activityData = value;
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			TenDaySignInItem item = m_TenDaySignInItems[i];
			if (i < value.activityChallengGroup.Length)
			{
				item.gameObject.SetActive(value: true);
				item.RefreshUI(i, activityId, value.activityChallengGroup[i], ActivityCenterView.Station);
				item.SetBtnClick(() =>
				{
					OnClickItem(item);
				});
			}
			else
			{
				item.gameObject.SetActive(value: false);
			}
		}
		RuntimeConfigs.data.activityChallengeGroups.TryGetValue(value.activityChallengGroup[0], out var value2);
		RuntimeConfigs.data.activityChallengeDatas.TryGetValue(value2.challengeId[0], out var value3);
		int num = value3.extraParm[0];
		foreach (KeyValuePair<int, GameObject> item2 in CharacterBG)
		{
			item2.Value.SetActive(item2.Key == num);
		}
		PlayAnimation(num);
	}

	protected override void UnInit()
	{
	}

	private void OnClickItem(TenDaySignInItem item)
	{
		if (item.rewardState == ActivityCenterModel.ActivityRewardState.Normal || item.rewardState == ActivityCenterModel.ActivityRewardState.Received)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = item.itemKv.id,
				Count = item.itemKv.count
			});
		}
		else if (item.rewardState == ActivityCenterModel.ActivityRewardState.Receive)
		{
			G.service.RequestActivitySignInReward(activityId, 0, 0, (ActivitySignInRewardAck activitySignInRewardAck) =>
			{
				OnActivitySignInRewardAck(item, activitySignInRewardAck);
			});
		}
	}

	private void OnActivitySignInRewardAck(TenDaySignInItem tenDaySignInItem, ActivitySignInRewardAck activitySignInRewardAck)
	{
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			TenDaySignInItem tenDaySignInItem2 = m_TenDaySignInItems[i];
			if (i < _activityData.activityChallengGroup.Length)
			{
				tenDaySignInItem2.RefreshUI(i, activityId, _activityData.activityChallengGroup[i], ActivityCenterView.Station);
			}
		}
		GameUtility.OpenPopReward(activitySignInRewardAck.GotItems);
		Model<ActivityCenterModel>.Interface.UpdateTenDaySignInRedDotState();
		_ = tenDaySignInItem.activityChallengeGroup.id;
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.status = 3;
		evt.challengeGroupId = 0;
		evt.challengeId = 0;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private async void PlayAnimation(int characterId)
	{
		switch (characterId)
		{
		case 11301:
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/10Day1301");
			break;
		case 12601:
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/10Day2601");
			break;
		}
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").Play();
		}
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			m_TenDaySignInItems[i].CanvasGroup.alpha = 0f;
		}
		for (int j = 0; j < 5; j++)
		{
			m_TenDaySignInItems[j].PlayItemAnimation(isLeft: true);
			m_TenDaySignInItems[j + 5].PlayItemAnimation(isLeft: false);
			await UniTask.Delay(ItemAnimationPlayInterval);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		if (type != DeviceInputMode.Gamepad)
		{
			return;
		}
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			if (m_TenDaySignInItems[i].rewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				ViewControlLayer.SetDefaultSelect(m_TenDaySignInItems[i].GetComponent<ACT.ViewControl.SelectableEx>());
				break;
			}
		}
		ViewControlLayer.Focus();
		OnSelectItem();
	}

	public void OnActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
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
		OnSelectItem();
	}

	private void OnSelectItem()
	{
		if (EventSystemHelper.CurrentSelected == null)
		{
			return;
		}
		TenDaySignInItem component = EventSystemHelper.CurrentSelected.GetComponent<TenDaySignInItem>();
		if (!(component == null))
		{
			if (component.rewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				PromptLabel.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1473);
			}
			else
			{
				PromptLabel.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774);
			}
		}
	}

	public void OpenActivityDetail()
	{
		m_TimeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	public void OnConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
