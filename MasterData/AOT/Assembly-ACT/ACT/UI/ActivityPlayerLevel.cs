using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class ActivityPlayerLevel : ActivityCenterBaseUIView<PlayerLevelController>
{
	[SerializeField]
	private Transform _activityDesRoot;

	[SerializeField]
	private Transform[] _activityRewaredRoots;

	[SerializeField]
	private GameObject _rewardItem_cell;

	[SerializeField]
	private BetterAnimation _anim;

	[SerializeField]
	private GamePadTipsComp GamePadTipsComp;

	[SerializeField]
	private TimeAndDesItem _desComponent;

	private OperationalActivityData _data;

	private PlayerlevelRewardItem _rewardItem;

	private bool isInitialized;

	private List<PlayerlevelRewardItem> _rewardItems = new List<PlayerlevelRewardItem>();

	private int _curSelectItemIndex = -1;

	private PlayerLevelSubController subController;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private ActivityCenterData _activityCenterData;

	protected override void Init()
	{
		_anim?.GetSequence("Show").Play();
		Initialize();
		InitGameTipsDic();
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
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
		actionDic.Add("LargeMapView/BackToPlayer", new GamePadTipsAction
		{
			inputAction = "LargeMapView/BackToPlayer",
			localizeKey = 893,
			localizeTable = "Common"
		});
	}

	protected override void UnInit()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	public void Initialize()
	{
		_data = Model<ActivityCenterModel>.Interface.PlayerLevelActivityInfo.ServerActivityData;
		if (_data == null)
		{
			return;
		}
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_data.ActivityId);
		_desComponent.Init(_activityCenterData, -1L);
		if (!isInitialized)
		{
			ActivityData data = CoreUtils.GetData(_data.ActivityId, RuntimeConfigs.data.activityDatas);
			int num = -1;
			_rewardItems.Clear();
			int[] activityChallengGroup = data.activityChallengGroup;
			foreach (int groupDetailId in activityChallengGroup)
			{
				num++;
				_rewardItem = Object.Instantiate(_rewardItem_cell, _activityRewaredRoots[num]).GetComponent<PlayerlevelRewardItem>();
				if (_rewardItem != null)
				{
					_rewardItem.Init(this, groupDetailId, ActivityCenterView.Station);
					_rewardItems.Add(_rewardItem);
				}
			}
			isInitialized = true;
			return;
		}
		List<PlayerlevelRewardItem> rewardItems = _rewardItems;
		if (rewardItems == null || rewardItems.Count <= 0)
		{
			return;
		}
		foreach (PlayerlevelRewardItem rewardItem in _rewardItems)
		{
			rewardItem?.Refresh();
			rewardItem?.PlayAnim(rewardItem.isCanRewaed ? "ActiveShow" : "NormalShow");
		}
	}

	public void OnReceiveItemReward()
	{
		foreach (PlayerlevelRewardItem rewardItem in _rewardItems)
		{
			rewardItem?.Refresh();
		}
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		for (int i = 0; i < _rewardItems.Count; i++)
		{
			_rewardItems[i].SetGamepadSelect(value: false);
			_rewardItems[i].SelectItem(active: false);
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			GamePadTipsComp.ClearAllPrompts();
			return;
		}
		subController = PlayerLevelSubController.Main;
		_curSelectItemIndex = GetGamepadNormalSelectItemIndex();
		_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: true);
		RefreshGamepadComp();
	}

	private void RefreshGamepadComp()
	{
		_tipsActions.Clear();
		GamePadTipsComp.ClearAllPrompts();
		_tipsActions.Add(actionDic["UI/Back"]);
		if (subController == PlayerLevelSubController.Item)
		{
			_tipsActions.Add(actionDic["UI/Confirm"]);
		}
		GamePadTipsComp.RegisterInputActions(_tipsActions);
	}

	private int GetGamepadNormalSelectItemIndex()
	{
		for (int i = 0; i < _rewardItems.Count; i++)
		{
			if (_rewardItems[i].isCanRewaed)
			{
				return i;
			}
		}
		for (int j = 0; j < _rewardItems.Count; j++)
		{
			if (!_rewardItems[j].isUnLock)
			{
				return j;
			}
		}
		return 0;
	}

	public void Left()
	{
		if (_curSelectItemIndex != -1)
		{
			if (subController == PlayerLevelSubController.Main)
			{
				_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: false);
				_curSelectItemIndex = ((_curSelectItemIndex <= 0) ? (_rewardItems.Count - 1) : (_curSelectItemIndex - 1));
				_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: true);
			}
			else
			{
				_rewardItems[_curSelectItemIndex].Left();
			}
		}
	}

	public void Right()
	{
		if (_curSelectItemIndex != -1)
		{
			if (subController == PlayerLevelSubController.Main)
			{
				_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: false);
				_curSelectItemIndex = ((_curSelectItemIndex < _rewardItems.Count - 1) ? (_curSelectItemIndex + 1) : 0);
				_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: true);
			}
			else
			{
				_rewardItems[_curSelectItemIndex].Right();
			}
		}
	}

	public void ButtonSouth()
	{
		if (subController == PlayerLevelSubController.Main)
		{
			if (_rewardItems[_curSelectItemIndex].isCanRewaed)
			{
				_rewardItems[_curSelectItemIndex].ReceiveReward();
			}
		}
		else
		{
			_rewardItems[_curSelectItemIndex].OpenItemDetail();
		}
	}

	public void OnOpenActivityDetail()
	{
		_desComponent.OnClickActivityDetailButtonHandle();
	}

	public void ButtonEast()
	{
		if (subController == PlayerLevelSubController.Main)
		{
			ActivityCenterView.Exit();
			return;
		}
		subController = PlayerLevelSubController.Main;
		_rewardItems[_curSelectItemIndex].SelectItem(active: false);
		_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: true);
		RefreshGamepadComp();
	}

	public void LeftStickPress()
	{
		if (subController != PlayerLevelSubController.Item)
		{
			subController = PlayerLevelSubController.Item;
			_rewardItems[_curSelectItemIndex].SelectItem(active: true);
			_rewardItems[_curSelectItemIndex].SetGamepadSelect(value: false);
			RefreshGamepadComp();
		}
	}
}
