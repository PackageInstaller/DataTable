using System;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityMultiDeviceItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
{
	private enum RewardState
	{
		Uncompleted,
		Completed,
		Received
	}

	[SerializeField]
	private TextMeshProUGUI _taskText;

	[SerializeField]
	private ActButton _receiveButton;

	[SerializeField]
	private BImage _receiveStateImage;

	[SerializeField]
	private BetterAnimation _receiveStateAnimation;

	[SerializeField]
	private Sprite _uncompletedReceiveSprite;

	[SerializeField]
	private Sprite _claimableReceiveSprite;

	[SerializeField]
	private Sprite _receivedReceiveSprite;

	[SerializeField]
	private BImage _giftBg;

	[SerializeField]
	private Sprite _normalGiftBgSprite;

	[SerializeField]
	private Sprite _claimableGiftBgSprite;

	[SerializeField]
	private ItemUIComponentBase _rewardItem;

	[SerializeField]
	private GameObject _confirmPrompt;

	[SerializeField]
	private GameObject _enterRewardPrompt;

	private int _activityId;

	private int _groupId;

	private int _challengeId;

	private ImageAssetStation _station;

	private Func<int, bool> _isChallengeClaimable;

	private Action _onRewardReceived;

	private bool _isReceiving;

	public void Init(int activityId, int groupId, int challengeId, ImageAssetStation station, Func<int, bool> isChallengeClaimable, Action onRewardReceived)
	{
		_activityId = activityId;
		_groupId = groupId;
		_challengeId = challengeId;
		_station = station;
		_isChallengeClaimable = isChallengeClaimable;
		_onRewardReceived = onRewardReceived;
		_receiveButton?.SetBtnClick(OnReceive);
		Refresh();
	}

	public void ReleaseRewardItems()
	{
		_rewardItem?.Release();
	}

	public void OpenRewardDetail()
	{
		if (_rewardItem?.ItemUnifier != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = _rewardItem.ItemUnifier.Id,
				Count = (int)_rewardItem.ItemUnifier.Count
			});
		}
	}

	public void Refresh()
	{
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(_challengeId, out var value))
		{
			Debug.LogError($"ActivityMultiDevice: challenge {_challengeId} is unavailable.");
			return;
		}
		if (_taskText != null)
		{
			_taskText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value.challengeText);
		}
		RewardState rewardState = GetRewardState();
		if (_receiveButton != null)
		{
			_receiveButton.interactable = rewardState == RewardState.Completed && !_isReceiving;
		}
		RefreshReceiveStateImage(rewardState);
		RefreshGiftBackground(rewardState);
		RefreshReceiveStateAnimation(rewardState);
		RefreshGamepadPrompts(rewardState);
		RefreshReward(value, rewardState);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (GetRewardState() == RewardState.Completed)
		{
			OnReceive();
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		RefreshGamepadPrompts(GetRewardState());
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetGamepadPromptsVisible(showConfirm: false, showEnterReward: false);
	}

	private RewardState GetRewardState()
	{
		if (Model<ActivityCenterModel>.Interface.IsActivityMultiDeviceChallengeReceived(_activityId, _groupId, _challengeId))
		{
			return RewardState.Received;
		}
		Func<int, bool> isChallengeClaimable = _isChallengeClaimable;
		if (isChallengeClaimable == null || !isChallengeClaimable(_challengeId))
		{
			return RewardState.Uncompleted;
		}
		return RewardState.Completed;
	}

	private void RefreshReceiveStateImage(RewardState rewardState)
	{
		if (!(_receiveStateImage?.icon == null))
		{
			Image icon = _receiveStateImage.icon;
			icon.sprite = rewardState switch
			{
				RewardState.Uncompleted => _uncompletedReceiveSprite, 
				RewardState.Completed => _claimableReceiveSprite, 
				RewardState.Received => _receivedReceiveSprite, 
				_ => null, 
			};
		}
	}

	private void RefreshGiftBackground(RewardState rewardState)
	{
		if (_giftBg != null && !(_giftBg.icon == null))
		{
			_giftBg.icon.sprite = ((rewardState == RewardState.Completed) ? _claimableGiftBgSprite : _normalGiftBgSprite);
		}
	}

	private void RefreshReceiveStateAnimation(RewardState rewardState)
	{
		if (!(_receiveStateAnimation == null))
		{
			if (rewardState == RewardState.Completed)
			{
				_receiveStateAnimation.GetSequence("Loop_2")?.SetLoops(-1).Play();
			}
			else
			{
				_receiveStateAnimation.StopAnimation();
			}
		}
	}

	private void RefreshReward(ActivityChallengeData challengeData, RewardState rewardState)
	{
		if (challengeData.challengeReward == null || challengeData.challengeReward.Length == 0 || !RuntimeConfigs.data.collections.TryGetValue(challengeData.challengeReward[0], out var value) || value.certain == null || value.certain.Count == 0)
		{
			Debug.LogError($"ActivityMultiDevice: challenge {_challengeId} has no configured reward.");
			return;
		}
		if (_rewardItem == null)
		{
			Debug.LogError($"ActivityMultiDevice: challenge {_challengeId} has no assigned reward item.");
			return;
		}
		ItemKv itemKv = value.certain[0];
		_rewardItem.Station = _station;
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
		_rewardItem.SetData(item, itemKv.count, (rewardState == RewardState.Received) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		_rewardItem.UpdatePerformance();
	}

	private void RefreshGamepadPrompts(RewardState rewardState)
	{
		bool flag = EventSystemHelper.Available && EventSystemHelper.CurrentSelected == gameObject;
		SetGamepadPromptsVisible(flag && rewardState == RewardState.Completed, flag);
	}

	private void SetGamepadPromptsVisible(bool showConfirm, bool showEnterReward)
	{
		if (_confirmPrompt != null)
		{
			_confirmPrompt.SetActive(showConfirm);
		}
		if (_enterRewardPrompt != null)
		{
			_enterRewardPrompt.SetActive(showEnterReward);
		}
	}

	private void OnReceive()
	{
		if (_isReceiving || GetRewardState() != RewardState.Completed)
		{
			return;
		}
		_isReceiving = true;
		Refresh();
		int activityId = _activityId;
		int groupId = _groupId;
		int challengeId = _challengeId;
		G.service.SendActivityMultiDeviceReward(activityId, groupId, challengeId, (ActivityMultiDeviceRewardAck ack) =>
		{
			_isReceiving = false;
			if (ack == null)
			{
				Refresh();
			}
			else
			{
				ReportReceiveReward(activityId, groupId, challengeId);
				GameUtility.OpenPopReward(ack.Items);
				_onRewardReceived?.Invoke();
			}
		});
	}

	private static void ReportReceiveReward(int activityId, int groupId, int challengeId)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.challengeGroupId = groupId;
		evt.challengeId = challengeId;
		evt.status = 3;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
