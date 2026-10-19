using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class MainlineMotivationItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
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
	private List<ItemUIComponentBase> _rewardItems = new List<ItemUIComponentBase>();

	[SerializeField]
	private ViewControlLayer _rewardControlLayer;

	[SerializeField]
	private GameObject _confirmPrompt;

	[SerializeField]
	private GameObject _enterRewardPrompt;

	private int _activityId;

	private int _groupId;

	private int _challengeId;

	private ImageAssetStation _station;

	private Action _onRewardReceived;

	public bool CanGo => GetRewardState() == RewardState.Uncompleted;

	public ViewControlLayer RewardControlLayer => _rewardControlLayer;

	public void Init(int activityId, int groupId, int challengeId, ImageAssetStation station, Action onRewardReceived)
	{
		_activityId = activityId;
		_groupId = groupId;
		_challengeId = challengeId;
		_station = station;
		_onRewardReceived = onRewardReceived;
		_receiveButton?.SetBtnClick(OnReceive);
		Refresh();
	}

	public void Refresh()
	{
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(_challengeId, out var value))
		{
			Debug.LogError($"MainlineMotivation: challenge {_challengeId} is unavailable.");
			return;
		}
		if (_taskText != null)
		{
			_taskText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value.challengeText);
		}
		RewardState rewardState = GetRewardState();
		if (_receiveButton != null)
		{
			_receiveButton.interactable = rewardState == RewardState.Completed;
		}
		RefreshReceiveStateImage(rewardState);
		RefreshGiftBackground(rewardState);
		RefreshReceiveStateAnimation(rewardState);
		RefreshRewards(value, rewardState);
		RefreshGamepadPrompts();
	}

	public void GoTo()
	{
		GoToAsync().Forget();
	}

	public void ReleaseRewardItems()
	{
		for (int i = 0; i < _rewardItems.Count; i++)
		{
			_rewardItems[i]?.Release();
		}
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
		RefreshGamepadPrompts();
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetGamepadPromptsVisible(showConfirm: false, showEnterReward: false);
	}

	private RewardState GetRewardState()
	{
		if (Model<ActivityCenterModel>.Interface.IsActivityMainStoryChallengeReceived(_activityId, _groupId, _challengeId))
		{
			return RewardState.Received;
		}
		if (!Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(_challengeId))
		{
			return RewardState.Uncompleted;
		}
		return RewardState.Completed;
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

	private void RefreshRewards(ActivityChallengeData challengeData, RewardState rewardState)
	{
		List<Item> list = new List<Item>();
		int[] challengeReward = challengeData.challengeReward;
		foreach (int key in challengeReward)
		{
			if (!RuntimeConfigs.data.collections.TryGetValue(key, out var value))
			{
				continue;
			}
			foreach (ItemKv item3 in value.certain)
			{
				Item item = new Item
				{
					Id = item3.id,
					Count = item3.count
				};
				item.Refresh();
				list.Add(item);
			}
		}
		if (list.Count > _rewardItems.Count)
		{
			Debug.LogError($"MainlineMotivation: challenge {_challengeId} has {list.Count} rewards but only {_rewardItems.Count} reward items are assigned.");
		}
		for (int j = 0; j < _rewardItems.Count; j++)
		{
			ItemUIComponentBase itemUIComponentBase = _rewardItems[j];
			if (!(itemUIComponentBase == null))
			{
				bool flag = j < list.Count;
				itemUIComponentBase.gameObject.SetActive(flag);
				if (flag)
				{
					itemUIComponentBase.Station = _station;
					ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(list[j].Id, list[j].Count);
					itemUIComponentBase.SetData(item2, list[j].Count, (rewardState == RewardState.Received) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
					itemUIComponentBase.UpdatePerformance();
				}
			}
		}
	}

	private void OnReceive()
	{
		int activityId = _activityId;
		int groupId = _groupId;
		int challengeId = _challengeId;
		G.service.SendActivityMainStoryReward(activityId, groupId, (ActivityMainStoryRewardAck ack) =>
		{
			if (ack != null)
			{
				ReportActivityClick(activityId, groupId, challengeId, 3);
				GameUtility.OpenPopReward(ack.Items);
				Model<ActivityCenterModel>.Interface.MarkCompletedActivityMainStoryChallengesReceived(activityId, groupId);
				_onRewardReceived?.Invoke();
			}
		});
	}

	private UniTask GoToAsync()
	{
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(_challengeId, out var value) || value.challengeJump == null || value.challengeJump.Length == 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotGoTo);
			return UniTask.CompletedTask;
		}
		int num = value.challengeJump[0];
		if (num == 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotGoTo);
			return UniTask.CompletedTask;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(num);
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
		{
			GameUtility.OpenJumpResultTips(result);
			result.Release();
			return UniTask.CompletedTask;
		}
		runTimeJumpData.FromSystem = SystemType.Mission;
		Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		ReportActivityClick(_activityId, _groupId, _challengeId, 2);
		result.Release();
		return UniTask.CompletedTask;
	}

	private static void ReportActivityClick(int activityId, int groupId, int challengeId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.challengeGroupId = groupId;
		evt.challengeId = challengeId;
		evt.status = status;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
