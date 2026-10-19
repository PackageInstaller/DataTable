using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ActivityAbyss : ActivityCenterBaseUIView<ActivityAbyssController>
{
	public TimeAndDesItem TimeAndDesItem;

	public List<GameObject> Mountains;

	public List<ActivityAbyssItem> ActivityAbyssItems;

	public TextMeshProUGUI CurProgress;

	public ActButton GotoButton;

	public ActButton EmptyButton;

	public BetterAnimation betterAnimation;

	public GamePadTipsComp GamePadTipsComp;

	private ActivitAbyssInfo _activitAbyssInfo;

	private int _lastSelectIndex;

	private int _curSelectIndex;

	private Dictionary<int, ActivityCenterNavigation> _navigationDic = new Dictionary<int, ActivityCenterNavigation>();

	private int _curGamepadSelectIndex = -1;

	private ActivityAbyssSubController _subController;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private ActivityCenterData _activityCenterData;

	protected override void Init()
	{
		OnClickEmptyButtonHandle();
		RefreshUI();
		betterAnimation.GetSequence("Show").Play();
		for (int i = 0; i < ActivityAbyssItems.Count; i++)
		{
			ActivityAbyssItems[i].PlayAnimation();
		}
		_navigationDic.Clear();
		_navigationDic.Add(0, new ActivityCenterNavigation
		{
			Left = -1,
			Right = 1,
			Up = 5,
			Down = 1
		});
		_navigationDic.Add(1, new ActivityCenterNavigation
		{
			Left = 0,
			Right = 2,
			Up = 5,
			Down = -1
		});
		_navigationDic.Add(2, new ActivityCenterNavigation
		{
			Left = 1,
			Right = 3,
			Up = 4,
			Down = -1
		});
		_navigationDic.Add(3, new ActivityCenterNavigation
		{
			Left = 4,
			Right = -1,
			Up = -1,
			Down = 2
		});
		_navigationDic.Add(4, new ActivityCenterNavigation
		{
			Left = 5,
			Right = 3,
			Up = -1,
			Down = 2
		});
		_navigationDic.Add(5, new ActivityCenterNavigation
		{
			Left = 0,
			Right = 4,
			Up = -1,
			Down = 1
		});
		InitGameTipsDic();
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Abyss/Open");
	}

	private void InitGameTipsDic()
	{
		actionDic.Clear();
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect",
			localizeKey = 2164,
			localizeTable = "Common"
		});
		actionDic.Add("UI/SelectItemCell", new GamePadTipsAction
		{
			inputAction = "UI/SelectItemCell",
			localizeKey = 893,
			localizeTable = "Common"
		});
	}

	protected override void UnInit()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	public void RefreshUI()
	{
		GotoButton.SetBtnClick(OnClickGotoButtonHandle, "event:/UI/Interface/Activity/Abyss/Enter");
		EmptyButton.SetBtnClick(OnClickEmptyButtonHandle);
		_activitAbyssInfo = Model<ActivityCenterModel>.Interface.GetActivitAbyssInfo();
		if (_activitAbyssInfo == null)
		{
			return;
		}
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activitAbyssInfo.ActivityId);
		TimeAndDesItem.Init(_activityCenterData, -1L);
		ActivityData activityData = RuntimeConfigs.data.activityDatas[_activitAbyssInfo.ActivityId];
		for (int i = 0; i < ActivityAbyssItems.Count; i++)
		{
			if (i < activityData.activityChallengGroup.Length)
			{
				ActivityAbyssItems[i].RefreshUI(activityData.activityChallengGroup[i], i, OnClickItemButtonHandle, ActivityCenterView.Station);
			}
			else
			{
				i--;
			}
		}
		CurProgress.text = GetAbyssProgress().ToString();
	}

	private void OnClickItemButtonHandle(int index)
	{
		SetItemSelect(index);
	}

	private async void OnClickGotoButtonHandle()
	{
		if (_activitAbyssInfo != null)
		{
			Model<ActivityCenterModel>.Interface.OpenActivityID = _activitAbyssInfo.ActivityId;
		}
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = _activitAbyssInfo.ActivityId;
		evt.status = 2;
		evt.challengeGroupId = 0;
		evt.challengeId = 0;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ABYSSLIST);
	}

	private void OnClickEmptyButtonHandle()
	{
		if (_curSelectIndex != -1)
		{
			ActivityAbyssItems[_curSelectIndex].SetSelect(value: false);
			Mountains[_curSelectIndex].SetActive(value: false);
			_curSelectIndex = -1;
			_lastSelectIndex = _curSelectIndex;
		}
	}

	private void SetItemSelect(int index)
	{
		if (index == _curSelectIndex)
		{
			ActivityAbyssItems[_curSelectIndex].SetSelect(value: false);
			Mountains[_curSelectIndex].SetActive(value: false);
			_curSelectIndex = -1;
			_lastSelectIndex = _curSelectIndex;
			RefreshGamepadComp();
			return;
		}
		_lastSelectIndex = _curSelectIndex;
		_curSelectIndex = index;
		ActivityAbyssItems[_curSelectIndex].SetSelect(value: true);
		Mountains[_curSelectIndex].SetActive(value: true);
		if (_lastSelectIndex >= 0)
		{
			ActivityAbyssItems[_lastSelectIndex].SetSelect(value: false);
			Mountains[_lastSelectIndex].SetActive(value: false);
		}
		RefreshGamepadComp();
	}

	private int GetAbyssProgress()
	{
		int num = 0;
		foreach (AbyssStage abyssStage in Model<AbyssModel>.Interface.AbyssStages)
		{
			if (abyssStage.CompletedNum > 0)
			{
				num++;
			}
		}
		return num;
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		for (int i = 0; i < ActivityAbyssItems.Count; i++)
		{
			ActivityAbyssItems[i].SetSelect(value: false);
			ActivityAbyssItems[i].SelectItem(active: false);
			Mountains[i].SetActive(value: false);
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			_curGamepadSelectIndex = -1;
			_curSelectIndex = -1;
			_lastSelectIndex = -1;
		}
		else
		{
			_curGamepadSelectIndex = 0;
			OnGamepadSelect(_curGamepadSelectIndex);
			_subController = ActivityAbyssSubController.Main;
			RefreshGamepadComp();
		}
	}

	private void RefreshGamepadComp()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			_tipsActions.Clear();
			GamePadTipsComp.ClearAllPrompts();
			_tipsActions.Add(actionDic["UI/Confirm"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			if (_subController == ActivityAbyssSubController.Main && _curSelectIndex != -1)
			{
				_tipsActions.Add(actionDic["UI/SelectItemCell"]);
			}
			GamePadTipsComp.RegisterInputActions(_tipsActions);
		}
	}

	public void Left()
	{
		if (_subController == ActivityAbyssSubController.Main)
		{
			if (_navigationDic.ContainsKey(_curGamepadSelectIndex) && _navigationDic[_curGamepadSelectIndex].Left != -1)
			{
				OnGamepadSelect(_navigationDic[_curGamepadSelectIndex].Left);
			}
		}
		else
		{
			ActivityAbyssItems[_curGamepadSelectIndex].Left();
		}
	}

	public void Right()
	{
		if (_subController == ActivityAbyssSubController.Main)
		{
			if (_navigationDic.ContainsKey(_curGamepadSelectIndex) && _navigationDic[_curGamepadSelectIndex].Right != -1)
			{
				OnGamepadSelect(_navigationDic[_curGamepadSelectIndex].Right);
			}
		}
		else
		{
			ActivityAbyssItems[_curGamepadSelectIndex].Right();
		}
	}

	public void Up()
	{
		if (_subController == ActivityAbyssSubController.Main && _navigationDic.ContainsKey(_curGamepadSelectIndex) && _navigationDic[_curGamepadSelectIndex].Up != -1)
		{
			OnGamepadSelect(_navigationDic[_curGamepadSelectIndex].Up);
		}
	}

	public void Down()
	{
		if (_subController == ActivityAbyssSubController.Main && _navigationDic.ContainsKey(_curGamepadSelectIndex) && _navigationDic[_curGamepadSelectIndex].Down != -1)
		{
			OnGamepadSelect(_navigationDic[_curGamepadSelectIndex].Down);
		}
	}

	private void OnGamepadSelect(int index)
	{
		if (_curGamepadSelectIndex != -1)
		{
			ActivityAbyssItems[_curGamepadSelectIndex].SetSelect(value: false);
			Mountains[_curGamepadSelectIndex].SetActive(value: false);
		}
		_curGamepadSelectIndex = index;
		ActivityAbyssItems[_curGamepadSelectIndex].SetGamepadSelect(value: true);
		Mountains[_curGamepadSelectIndex].SetActive(value: true);
		if (_curSelectIndex != -1)
		{
			SetItemSelect(index);
		}
	}

	public void LeftStickPress()
	{
		if (_curSelectIndex != -1 && _subController != ActivityAbyssSubController.Item)
		{
			_subController = ActivityAbyssSubController.Item;
			ActivityAbyssItems[_curGamepadSelectIndex].SelectItem(active: true);
			RefreshGamepadComp();
		}
	}

	public void RightStickPress()
	{
		TimeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	public void ButtonNorth()
	{
		OnClickGotoButtonHandle();
	}

	public void ButtonSouth()
	{
		if (_subController == ActivityAbyssSubController.Main)
		{
			ActivityAbyssItems[_curGamepadSelectIndex].OnClickItemButton();
		}
		else
		{
			ActivityAbyssItems[_curGamepadSelectIndex].OpenItemDetail();
		}
	}

	public void ButtonEast()
	{
		if (_subController == ActivityAbyssSubController.Main)
		{
			ActivityCenterView.Exit();
			return;
		}
		_subController = ActivityAbyssSubController.Main;
		ActivityAbyssItems[_curGamepadSelectIndex].SelectItem(active: false);
		RefreshGamepadComp();
	}
}
