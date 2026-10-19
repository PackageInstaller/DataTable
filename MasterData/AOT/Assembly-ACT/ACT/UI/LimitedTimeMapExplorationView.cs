using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class LimitedTimeMapExplorationView : ActivityCenterBaseUIView<LimitedTimeMapExplorationController>
{
	private const string ShowAnimationName = "Show";

	private const string HideAnimationName = "Hide";

	[SerializeField]
	private TimeAndDesItem _timeAndDesItem;

	[SerializeField]
	private ActButton _goButton;

	[SerializeField]
	private ViewControlRoot _viewControlRoot;

	[SerializeField]
	private ViewControlLayer _itemControlLayer;

	[SerializeField]
	private GamePadTipsComp _gamePadTipsComp;

	[SerializeField]
	private LocalizeStringEvent _explorationProgressLocalize;

	[SerializeField]
	private int _exploreProgressLocalizeId;

	private readonly List<LimitedTimeMapExplorationItem> _items = new List<LimitedTimeMapExplorationItem>(4);

	private LimitedTimeMapExplorationItem _selectedItem;

	private BetterAnimation _betterAnimation;

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
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
		AnimationBuilder animationBuilder = _betterAnimation?.GetSequence(animationName);
		if (animationBuilder != null)
		{
			if (animationName == "Show")
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/PowerPlantOpen");
			}
			animationBuilder.Play();
		}
	}

	protected override void Init()
	{
		base.Init();
		int selectActivityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(selectActivityId);
		if (activityCenterData?.StaticActivityData == null)
		{
			Debug.LogError($"LimitedTimeMapExploration: activity {selectActivityId} is unavailable.");
			return;
		}
		_timeAndDesItem?.Init(activityCenterData, -1L);
		_goButton?.gameObject.SetActive(value: false);
		_goButton?.SetBtnClick(GoToSelectedChallenge);
		InitMapInfo(selectActivityId, activityCenterData.StaticActivityData);
		int[] activityChallengGroup = activityCenterData.StaticActivityData.activityChallengGroup;
		if (activityChallengGroup == null || activityChallengGroup.Length != 1 || !RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengGroup[0], out var value) || value.challengeId == null || value.challengeId.Length != 4)
		{
			Debug.LogError($"LimitedTimeMapExploration: activity {selectActivityId} requires one group with four challenges.");
			return;
		}
		_items.Clear();
		_items.AddRange(GetComponentsInChildren<LimitedTimeMapExplorationItem>(includeInactive: true));
		_items.Sort((LimitedTimeMapExplorationItem left, LimitedTimeMapExplorationItem right) => left.transform.GetSiblingIndex().CompareTo(right.transform.GetSiblingIndex()));
		if (_items.Count != value.challengeId.Length)
		{
			Debug.LogError($"LimitedTimeMapExploration: activity {selectActivityId} requires four assigned item components but found {_items.Count}.");
			return;
		}
		_selectedItem = _items[0];
		Model<ActivityCenterModel>.Interface.RefreshLimitedTimeMapExplorationRedDotState();
		for (int num = 0; num < value.challengeId.Length; num++)
		{
			_items[num].Init(selectActivityId, value.id, value.challengeId[num], ActivityCenterView.Station, RefreshItems, OnItemSelected);
		}
		RefreshGamepadTips();
	}

	private void RefreshItems()
	{
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.Refresh();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		_gamePadTipsComp?.ClearAllPrompts();
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i]?.ReleaseRewardItems();
		}
		_items.Clear();
		_selectedItem = null;
	}

	private void OnItemSelected(LimitedTimeMapExplorationItem item)
	{
		_selectedItem = item;
	}

	public void GoToSelectedChallenge()
	{
		LimitedTimeMapExplorationItem currentSelectedItem = GetCurrentSelectedItem();
		if (currentSelectedItem == null || !RuntimeConfigs.data.activityChallengeDatas.TryGetValue(currentSelectedItem.ChallengeId, out var value) || value.challengeJump == null || value.challengeJump.Length == 0 || value.challengeJump[0] == 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotGoTo);
			return;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(value.challengeJump[0]);
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
		{
			GameUtility.OpenJumpResultTips(result);
			result.Release();
		}
		else
		{
			runTimeJumpData.FromSystem = SystemType.Activity;
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			result.Release();
		}
	}

	private LimitedTimeMapExplorationItem GetCurrentSelectedItem()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return _selectedItem;
		}
		return currentSelected.GetComponent<LimitedTimeMapExplorationItem>() ?? currentSelected.GetComponentInParent<LimitedTimeMapExplorationItem>() ?? _selectedItem;
	}

	private void InitMapInfo(int activityId, ActivityData activityData)
	{
		if (TryGetTargetMapArea(activityId, activityData, out var mapArea))
		{
			RefreshExploreProgressText(0);
			_goButton.gameObject.SetActive(value: true);
			if (!Model<MapModel>.HasInstance())
			{
				Model<MapModel>.CreateModel();
			}
			G.service.MapAreaExploreQuery(() =>
			{
				RefreshExploreProgress(mapArea);
			});
		}
	}

	private static bool TryGetTargetMapArea(int activityId, ActivityData activityData, out ACT.World.MapArea mapArea)
	{
		mapArea = ACT.World.MapArea.None;
		if (activityData.activitySpecialParam == null || activityData.activitySpecialParam.Length != 1)
		{
			Debug.LogError($"LimitedTimeMapExploration: activity {activityId} requires exactly one map area parameter.");
			return false;
		}
		mapArea = (ACT.World.MapArea)activityData.activitySpecialParam[0];
		if (mapArea == ACT.World.MapArea.None || RuntimeConfigs.data?.mapAreas == null || !RuntimeConfigs.data.mapAreas.ContainsKey((int)mapArea))
		{
			Debug.LogError($"LimitedTimeMapExploration: activity {activityId} has an invalid map area parameter {activityData.activitySpecialParam[0]}.");
			mapArea = ACT.World.MapArea.None;
			return false;
		}
		return true;
	}

	private void RefreshExploreProgress(ACT.World.MapArea mapArea)
	{
		if (!(this == null) && gameObject.activeInHierarchy)
		{
			int progress = Mathf.Clamp(Mathf.FloorToInt(MapUtility.GetAreaExploreRatio(mapArea)), 0, 100);
			RefreshExploreProgressText(progress);
		}
	}

	private void RefreshExploreProgressText(int progress)
	{
		_explorationProgressLocalize.SetTable(LocalizeTable.Common);
		_explorationProgressLocalize.StringReference.TableEntryReference = _exploreProgressLocalizeId;
		_explorationProgressLocalize.GetVariable<int>("0").Value = progress;
	}

	public void OnActivate()
	{
		_itemControlLayer?.ReFocus();
		RefreshGamepadTips();
	}

	private void RefreshGamepadTips()
	{
		_gamePadTipsComp?.RegisterInputActions(GamePadTipHelper.BackAction);
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
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<LimitedTimeMapExplorationItem>()?.OpenRewardDetail();
		}
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
}
