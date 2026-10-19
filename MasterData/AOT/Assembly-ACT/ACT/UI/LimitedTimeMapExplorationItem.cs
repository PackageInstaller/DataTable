using System;
using ACT.Config;
using ACT.Core;
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

public class LimitedTimeMapExplorationItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
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

	private Action _onRewardReceived;

	private Action<LimitedTimeMapExplorationItem> _onSelected;

	private bool _isReceiving;

	public int ChallengeId => _challengeId;

	public void Init(int activityId, int groupId, int challengeId, ImageAssetStation station, Action onRewardReceived, Action<LimitedTimeMapExplorationItem> onSelected)
	{
		_activityId = activityId;
		_groupId = groupId;
		_challengeId = challengeId;
		_station = station;
		_onRewardReceived = onRewardReceived;
		_onSelected = onSelected;
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
			Debug.LogError($"LimitedTimeMapExploration: challenge {_challengeId} is unavailable.");
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
		RefreshGamepadPrompts();
		if (value.challengeReward == null || value.challengeReward.Length == 0 || !RuntimeConfigs.data.collections.TryGetValue(value.challengeReward[0], out var value2) || value2.certain == null || value2.certain.Count == 0)
		{
			Debug.LogError($"LimitedTimeMapExploration: challenge {_challengeId} has no configured reward.");
			return;
		}
		if (_rewardItem == null)
		{
			Debug.LogError($"LimitedTimeMapExploration: challenge {_challengeId} has no assigned reward item.");
			return;
		}
		ItemKv itemKv = value2.certain[0];
		_rewardItem.Station = _station;
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
		_rewardItem.SetData(item, itemKv.count, (rewardState == RewardState.Received) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		_rewardItem.UpdatePerformance();
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
		_onSelected?.Invoke(this);
		RefreshGamepadPrompts();
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetGamepadPromptsVisible(showConfirm: false, showEnterReward: false);
	}

	private void RefreshReceiveStateImage(RewardState rewardState)
	{
		if (_receiveStateImage != null && !(_receiveStateImage.icon == null))
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

	private void RefreshGamepadPrompts()
	{
		bool flag = EventSystemHelper.Available && EventSystemHelper.CurrentSelected == gameObject;
		bool flag2 = GetRewardState() == RewardState.Completed;
		SetGamepadPromptsVisible(flag & flag2, flag);
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

	private RewardState GetRewardState()
	{
		if (Model<ActivityCenterModel>.Interface.IsActivityMapExploreChallengeReceived(_activityId, _groupId, _challengeId))
		{
			return RewardState.Received;
		}
		if (!Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(_challengeId))
		{
			return RewardState.Uncompleted;
		}
		return RewardState.Completed;
	}

	private void OnReceive()
	{
		if (_isReceiving || GetRewardState() != RewardState.Completed)
		{
			return;
		}
		_isReceiving = true;
		Refresh();
		G.service.SendActivityMapExploreReward(_activityId, _groupId, (ActivityMapExploreRewardAck ack) =>
		{
			_isReceiving = false;
			if (ack == null)
			{
				Refresh();
			}
			else
			{
				GameUtility.OpenPopReward(ack.Items);
				Model<ActivityCenterModel>.Interface.MarkCompletedActivityMapExploreChallengesReceived(_activityId, _groupId);
				_onRewardReceived?.Invoke();
			}
		});
	}
}
