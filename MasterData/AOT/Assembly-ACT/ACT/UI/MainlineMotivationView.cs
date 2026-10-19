using System.Collections.Generic;
using ACT.Core;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class MainlineMotivationView : ActivityCenterBaseUIView<MainlineMotivationController>
{
	private const string ShowAnimationName = "Show";

	private const string HideAnimationName = "Hide";

	[SerializeField]
	private TimeAndDesItem _timeAndDesItem;

	[SerializeField]
	private ActButton _goButton;

	[SerializeField]
	private List<MainlineMotivationItem> _items = new List<MainlineMotivationItem>(4);

	[SerializeField]
	private ViewControlRoot _viewControlRoot;

	[SerializeField]
	private ViewControlLayer _itemControlLayer;

	[SerializeField]
	private GamePadTipsComp _gamePadTipsComp;

	private int _activityId;

	private BetterAnimation _betterAnimation;

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/MainRewards_Open");
		PlayAnimation("Show");
	}

	protected override void OnFocusOut()
	{
		PlayAnimation("Hide");
		base.OnFocusOut();
	}

	private void PlayAnimation(string animationName)
	{
		if ((object)_betterAnimation == null)
		{
			_betterAnimation = GetComponent<BetterAnimation>();
		}
		_betterAnimation?.GetSequence(animationName)?.Play();
	}

	protected override void Init()
	{
		base.Init();
		_activityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		Debug.Log($"MainlineMotivationViewId{_activityId}");
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activityId);
		if (activityCenterData == null || activityCenterData.StaticActivityData == null)
		{
			Debug.LogError($"MainlineMotivation: activity {_activityId} is unavailable.");
			return;
		}
		_timeAndDesItem?.Init(activityCenterData, -1L);
		_goButton?.SetBtnClick(OnGo);
		int[] activityChallengGroup = activityCenterData.StaticActivityData.activityChallengGroup;
		if (activityChallengGroup == null || activityChallengGroup.Length != 1 || !RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengGroup[0], out var value) || value.challengeId == null || value.challengeId.Length != 4 || _items.Count != 4 || _items.Exists((MainlineMotivationItem x) => x == null))
		{
			Debug.LogError($"MainlineMotivation: activity {_activityId} requires one group, four challenges, and four assigned items.");
			return;
		}
		for (int num = 0; num < value.challengeId.Length; num++)
		{
			_items[num].Init(_activityId, value.id, value.challengeId[num], ActivityCenterView.Station, OnRewardReceived);
		}
		RefreshItems();
		RefreshGamepadControlPrompts(MainlineMotivationControllerType.Item);
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		RefreshItems();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_gamePadTipsComp?.ClearAllPrompts();
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.ReleaseRewardItems();
		}
	}

	private void OnGo()
	{
		GoToFirstUncompleted();
	}

	public void GoToFirstUncompleted()
	{
		_items.Find((MainlineMotivationItem x) => x.CanGo)?.GoTo();
	}

	public void OnActivate()
	{
		ChangeControlType(MainlineMotivationControllerType.Item, reFocus: true);
	}

	public void ChangeControlType(MainlineMotivationControllerType controlType, bool reFocus = false)
	{
		ViewControlLayer viewControlLayer = ((controlType == MainlineMotivationControllerType.Item) ? _itemControlLayer : GetCurrentSelectedItem()?.RewardControlLayer);
		if (!(viewControlLayer == null))
		{
			GetController().ControlType = controlType;
			if (reFocus)
			{
				viewControlLayer.ReFocus();
			}
			else
			{
				viewControlLayer.Focus();
			}
			RefreshGamepadControlPrompts(controlType);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (!(_viewControlRoot == null))
		{
			switch (dir)
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

	public void Close()
	{
		ActivityCenterView.Exit();
	}

	public void OnConfirm()
	{
		if (!EventSystemHelper.Available)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	private MainlineMotivationItem GetCurrentSelectedItem()
	{
		if (!EventSystemHelper.Available)
		{
			return null;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			return currentSelected.GetComponent<MainlineMotivationItem>();
		}
		return null;
	}

	private void RefreshGamepadControlPrompts(MainlineMotivationControllerType controlType)
	{
		if (!(_gamePadTipsComp == null))
		{
			if (controlType == MainlineMotivationControllerType.Reward)
			{
				_gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
			}
			else
			{
				_gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction);
			}
		}
	}

	private void OnRewardReceived()
	{
		RefreshItems();
		ChangeControlType(MainlineMotivationControllerType.Item, reFocus: true);
	}

	private void RefreshItems()
	{
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.Refresh();
		}
		if (_goButton != null)
		{
			_goButton.gameObject.SetActive(_items.Exists((MainlineMotivationItem x) => x != null && x.CanGo));
		}
	}
}
