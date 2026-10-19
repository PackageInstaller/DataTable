using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActivityMultiDevice : ActivityCenterBaseUIView<ActivityMultiDeviceController>
{
	private const int MobileChallengeIndex = 0;

	private const int PcChallengeIndex = 1;

	private const int GamepadChallengeIndex = 2;

	[SerializeField]
	private TimeAndDesItem _timeAndDesItem;

	[SerializeField]
	private ViewControlRoot _viewControlRoot;

	[SerializeField]
	private ViewControlLayer _itemControlLayer;

	[SerializeField]
	private GamePadTipsComp _gamePadTipsComp;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private List<ActivityMultiDeviceItem> _items = new List<ActivityMultiDeviceItem>(3);

	private int[] _challengeIds;

	private int _activityId;

	private int _groupId;

	private bool _hasEnteredWithGamepad;

	protected override void Init()
	{
		base.Init();
		_activityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activityId);
		if (activityCenterData?.StaticActivityData == null)
		{
			Debug.LogError($"ActivityMultiDevice: activity {_activityId} is unavailable.");
			return;
		}
		_timeAndDesItem?.Init(activityCenterData, -1L);
		int[] activityChallengGroup = activityCenterData.StaticActivityData.activityChallengGroup;
		if (activityChallengGroup == null || activityChallengGroup.Length != 1 || !RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengGroup[0], out var value) || value.challengeId == null || value.challengeId.Length != 3)
		{
			Debug.LogError($"ActivityMultiDevice: activity {_activityId} requires one group with three challenges.");
			return;
		}
		_groupId = value.id;
		_challengeIds = value.challengeId;
		_hasEnteredWithGamepad = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		if (_items == null || _items.Count != _challengeIds.Length || _items.Exists((ActivityMultiDeviceItem item) => item == null))
		{
			Debug.LogError($"ActivityMultiDevice: activity {_activityId} requires three assigned item components.");
			return;
		}
		for (int num = 0; num < _challengeIds.Length; num++)
		{
			_items[num].Init(_activityId, _groupId, _challengeIds[num], ActivityCenterView.Station, IsChallengeClaimable, RefreshItems);
		}
		_gamePadTipsComp?.RegisterInputActions(GamePadTipHelper.BackAction);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/MultiPlatform_Open");
		_betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_gamePadTipsComp?.ClearAllPrompts();
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.ReleaseRewardItems();
		}
		_challengeIds = null;
		_hasEnteredWithGamepad = false;
		_activityId = 0;
		_groupId = 0;
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad && !_hasEnteredWithGamepad)
		{
			_hasEnteredWithGamepad = true;
			RefreshItems();
		}
	}

	private bool IsChallengeClaimable(int challengeId)
	{
		if (_challengeIds == null || _challengeIds.Length != 3)
		{
			return false;
		}
		if (challengeId == _challengeIds[0])
		{
			RuntimePlatform platform = Application.platform;
			return platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer;
		}
		if (challengeId == _challengeIds[1])
		{
			RuntimePlatform platform = Application.platform;
			return platform == RuntimePlatform.WindowsPlayer || platform == RuntimePlatform.WindowsEditor;
		}
		if (challengeId == _challengeIds[2])
		{
			return _hasEnteredWithGamepad;
		}
		return false;
	}

	private void RefreshItems()
	{
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.Refresh();
		}
	}

	public void OnActivate()
	{
		_itemControlLayer?.ReFocus();
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		if (!(_viewControlRoot == null))
		{
			switch (direction)
			{
			case MoveDirection.Left:
				_viewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				_viewControlRoot.SelectRight();
				break;
			case MoveDirection.Up:
				_viewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				_viewControlRoot.SelectDown();
				break;
			}
		}
	}

	public void OpenActivityDetail()
	{
		_timeAndDesItem?.OnClickActivityDetailButtonHandle();
	}

	public void OpenSelectedRewardDetail()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		((currentSelected == null) ? null : (currentSelected.GetComponent<ActivityMultiDeviceItem>() ?? currentSelected.GetComponentInParent<ActivityMultiDeviceItem>()))?.OpenRewardDetail();
	}

	public void Close()
	{
		ActivityCenterView.Exit();
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
