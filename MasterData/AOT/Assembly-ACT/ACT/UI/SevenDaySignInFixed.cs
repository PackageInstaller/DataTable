using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SevenDaySignInFixed : BaseUIView<SevendaySignInFixedViewInputController>
{
	public SevenDaySignInFixedItem ItemAsset;

	public RectTransform ListParent1;

	public RectTransform ListParent2;

	public ActButton CloseButton;

	public Button TryButton;

	public Button ConfirmButton;

	public GamePadTipsComp GamePadTipsComp;

	private ActivitSignInInfo _activitySignInInfo;

	private ActivityData _activityData;

	private Dictionary<int, SevenDaySignInFixedItem> _sevenDaySignInFixedItemDic = new Dictionary<int, SevenDaySignInFixedItem>();

	private int _lastSelectCharacterId;

	private int _currentSelectCharacterId;

	private List<int> _topCharacterIds = new List<int>();

	private List<int> _bottomCharacterIds = new List<int>();

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private Dictionary<int, ActivityCenterNavigation> _navigationDic = new Dictionary<int, ActivityCenterNavigation>();

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/RoleCard");
		CloseButton.SetBtnClick(OnClickCloseButtonHandle, "event:/UI/Common/Return_Click");
		TryButton.SetBtnClick(OnClickTryButtonHandle, "event:/UI/Interface/Activity/Tryout");
		ConfirmButton.SetBtnClick(OnClickConfirmButtonHandle, "event:/UI/Interface/Activity/Select");
		TryButton.gameObject.SetActive(value: false);
		ConfirmButton.gameObject.SetActive(value: false);
		_activitySignInInfo = Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.SevenDay));
		if (_activitySignInInfo == null)
		{
			return;
		}
		RuntimeConfigs.data.activityDatas.TryGetValue(_activitySignInInfo.ActivityId, out var value);
		if (value == null)
		{
			return;
		}
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[value.activityChallengGroup[1]];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		int fixedCharacterId = Model<ActivityCenterModel>.Interface.GetFixedCharacterId(Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.SevenDay));
		for (int i = 0; i < 12; i++)
		{
			if (i >= activityChallengeData.extraParm.Length)
			{
				continue;
			}
			RuntimeConfigs.data.actCharacterDatas.TryGetValue(activityChallengeData.extraParm[i], out var value2);
			if (value2 != null)
			{
				SevenDaySignInFixedItem sevenDaySignInFixedItem = Object.Instantiate(ItemAsset, (i < 6) ? ListParent1 : ListParent2);
				_sevenDaySignInFixedItemDic.Add(value2.id, sevenDaySignInFixedItem);
				sevenDaySignInFixedItem.RefreshUI(value2, fixedCharacterId, OnClickItemButtonHandle);
				if (i < 6)
				{
					_topCharacterIds.Add(value2.id);
				}
				else
				{
					_bottomCharacterIds.Add(value2.id);
				}
			}
		}
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		InitGameTipsDic();
		OnControllerStatusChange(MonoECS.instance.InputMode);
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
		actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect",
			localizeKey = 2164,
			localizeTable = "Common"
		});
		_navigationDic.Clear();
		_navigationDic.Add(0, new ActivityCenterNavigation
		{
			Left = -1,
			Right = 1,
			Up = -1,
			Down = -1
		});
		_navigationDic.Add(1, new ActivityCenterNavigation
		{
			Left = 0,
			Right = 2,
			Up = -1,
			Down = 6
		});
		_navigationDic.Add(2, new ActivityCenterNavigation
		{
			Left = 1,
			Right = 3,
			Up = -1,
			Down = 7
		});
		_navigationDic.Add(3, new ActivityCenterNavigation
		{
			Left = 2,
			Right = 4,
			Up = -1,
			Down = 8
		});
		_navigationDic.Add(4, new ActivityCenterNavigation
		{
			Left = 3,
			Right = 5,
			Up = -1,
			Down = 9
		});
		_navigationDic.Add(5, new ActivityCenterNavigation
		{
			Left = 4,
			Right = -1,
			Up = -1,
			Down = 10
		});
		_navigationDic.Add(6, new ActivityCenterNavigation
		{
			Left = -1,
			Right = 7,
			Up = 1,
			Down = -1
		});
		_navigationDic.Add(7, new ActivityCenterNavigation
		{
			Left = 6,
			Right = 8,
			Up = 2,
			Down = -1
		});
		_navigationDic.Add(8, new ActivityCenterNavigation
		{
			Left = 7,
			Right = 9,
			Up = 3,
			Down = -1
		});
		_navigationDic.Add(9, new ActivityCenterNavigation
		{
			Left = 8,
			Right = 10,
			Up = 4,
			Down = -1
		});
		_navigationDic.Add(10, new ActivityCenterNavigation
		{
			Left = 9,
			Right = 11,
			Up = 5,
			Down = -1
		});
		_navigationDic.Add(11, new ActivityCenterNavigation
		{
			Left = 10,
			Right = -1,
			Up = -1,
			Down = -1
		});
	}

	protected override void UnInit()
	{
		base.UnInit();
		int childCount = ListParent1.childCount;
		int childCount2 = ListParent2.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Object.DestroyImmediate(ListParent1.GetChild(0).gameObject);
		}
		for (int j = 0; j < childCount2; j++)
		{
			Object.DestroyImmediate(ListParent2.GetChild(0).gameObject);
		}
		_sevenDaySignInFixedItemDic.Clear();
		_topCharacterIds.Clear();
		_bottomCharacterIds.Clear();
		_lastSelectCharacterId = 0;
		_currentSelectCharacterId = 0;
		StopCoroutine(PlayTopItemAnimation());
		StopCoroutine(PlayBottomItemAnimation());
		_tipsActions.Clear();
		actionDic.Clear();
		_navigationDic.Clear();
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	public void OnClickCloseButtonHandle()
	{
		Close();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CloseSevenDayFixedView, null);
	}

	public void OnClickTryButtonHandle()
	{
		if (_currentSelectCharacterId == 0)
		{
			return;
		}
		foreach (ItemKv item in CoreUtils.GetData(_currentSelectCharacterId, RuntimeConfigs.data.CharacterProbationRaids).typeRaidID)
		{
			if (item.id != 3)
			{
				continue;
			}
			TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(item.count);
			G.service.RaidEnterInfo(item.count, raidTrialTeamUsage, async (bool r) =>
			{
				if (r)
				{
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				}
			});
			break;
		}
	}

	public void OnClickConfirmButtonHandle()
	{
		RuntimeConfigs.data.activityDatas.TryGetValue(_activitySignInInfo.ActivityId, out var value);
		if (value == null)
		{
			return;
		}
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[value.activityChallengGroup[1]];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		int num = 0;
		for (int i = 0; i < activityChallengeData.extraParm.Length; i++)
		{
			if (activityChallengeData.extraParm[i] == _currentSelectCharacterId)
			{
				num = activityChallengeData.challengeReward[i];
				break;
			}
		}
		if (num != 0)
		{
			G.service.RequestActivitySignInChooseReward(_activitySignInInfo.ActivityId, activityChallengeGroup.id, activityChallengeGroup.challengeId[0], num, (ActivitySignInChooseRewardAck activitySignInChooseRewardAck) =>
			{
			});
		}
		TargetedWish evt = EventTrackSolver.Instance.GetEvt<TargetedWish>();
		evt.id = activityChallengeGroup.id;
		evt.type = 1;
		evt.challengeId = activityChallengeData.id;
		evt.targetedId = num;
		evt.status = 1;
		EventTrackSolver.Instance.Dispatch(evt);
		Close();
	}

	private void OnClickItemButtonHandle(int characterId)
	{
		if (characterId != _currentSelectCharacterId)
		{
			_lastSelectCharacterId = _currentSelectCharacterId;
			_currentSelectCharacterId = characterId;
			if (_lastSelectCharacterId > 0)
			{
				_sevenDaySignInFixedItemDic[_lastSelectCharacterId].SetSelect(value: false);
			}
			_sevenDaySignInFixedItemDic[_currentSelectCharacterId].SetSelect(value: true);
			TryButton.gameObject.SetActive(value: true);
			ConfirmButton.gameObject.SetActive(value: true);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play().OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		});
		PlayItemAnimation();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		StopCoroutine(PlayTopItemAnimation());
		StopCoroutine(PlayBottomItemAnimation());
		CloseEffectFinishNew();
	}

	private void PlayItemAnimation()
	{
		foreach (KeyValuePair<int, SevenDaySignInFixedItem> item in _sevenDaySignInFixedItemDic)
		{
			item.Value.CanvasGroup.alpha = 0f;
		}
		StartCoroutine(PlayTopItemAnimation());
		StartCoroutine(PlayBottomItemAnimation());
	}

	private IEnumerator PlayTopItemAnimation()
	{
		for (int i = 0; i < _topCharacterIds.Count; i++)
		{
			_sevenDaySignInFixedItemDic[_topCharacterIds[i]].CanvasGroup.alpha = 1f;
			_sevenDaySignInFixedItemDic[_topCharacterIds[i]].PlayTopOpenAnimation();
			yield return new WaitForSeconds(0.02f);
		}
	}

	private IEnumerator PlayBottomItemAnimation()
	{
		for (int i = 0; i < _bottomCharacterIds.Count; i++)
		{
			_sevenDaySignInFixedItemDic[_bottomCharacterIds[i]].CanvasGroup.alpha = 1f;
			_sevenDaySignInFixedItemDic[_bottomCharacterIds[i]].PlayBottomOpenAnimation();
			yield return new WaitForSeconds(0.02f);
		}
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		_tipsActions.Clear();
		GamePadTipsComp.ClearAllPrompts();
		foreach (KeyValuePair<int, SevenDaySignInFixedItem> item in _sevenDaySignInFixedItemDic)
		{
			item.Value.OnControllerStatusChange(deviceInputMode == DeviceInputMode.Gamepad);
		}
		if (deviceInputMode == DeviceInputMode.Gamepad)
		{
			_tipsActions.Add(actionDic["UI/Back"]);
			GamePadTipsComp.RegisterInputActions(_tipsActions);
			int key = IndexToCharacter(GetCurSelectIndex());
			_sevenDaySignInFixedItemDic[key].OnClickItemButtonHandle();
		}
	}

	public void Left()
	{
		int curSelectIndex = GetCurSelectIndex();
		if (_navigationDic.ContainsKey(curSelectIndex) && _navigationDic[curSelectIndex].Left != -1)
		{
			int key = IndexToCharacter(_navigationDic[curSelectIndex].Left);
			_sevenDaySignInFixedItemDic[key].OnClickItemButtonHandle();
		}
	}

	public void Right()
	{
		int curSelectIndex = GetCurSelectIndex();
		if (_navigationDic.ContainsKey(curSelectIndex) && _navigationDic[curSelectIndex].Right != -1)
		{
			int key = IndexToCharacter(_navigationDic[curSelectIndex].Right);
			_sevenDaySignInFixedItemDic[key].OnClickItemButtonHandle();
		}
	}

	public void Up()
	{
		int curSelectIndex = GetCurSelectIndex();
		if (_navigationDic.ContainsKey(curSelectIndex) && _navigationDic[curSelectIndex].Up != -1)
		{
			int key = IndexToCharacter(_navigationDic[curSelectIndex].Up);
			_sevenDaySignInFixedItemDic[key].OnClickItemButtonHandle();
		}
	}

	public void Down()
	{
		int curSelectIndex = GetCurSelectIndex();
		if (_navigationDic.ContainsKey(curSelectIndex) && _navigationDic[curSelectIndex].Down != -1)
		{
			int key = IndexToCharacter(_navigationDic[curSelectIndex].Down);
			_sevenDaySignInFixedItemDic[key].OnClickItemButtonHandle();
		}
	}

	private int GetCurSelectIndex()
	{
		if (_currentSelectCharacterId <= 0)
		{
			return 0;
		}
		for (int i = 0; i < _topCharacterIds.Count; i++)
		{
			if (_topCharacterIds[i] == _currentSelectCharacterId)
			{
				return i;
			}
		}
		for (int j = 0; j < _bottomCharacterIds.Count; j++)
		{
			if (_bottomCharacterIds[j] == _currentSelectCharacterId)
			{
				return j + _topCharacterIds.Count;
			}
		}
		return 0;
	}

	private int IndexToCharacter(int index)
	{
		if (index < _topCharacterIds.Count)
		{
			return _topCharacterIds[index];
		}
		return _bottomCharacterIds[index - _topCharacterIds.Count];
	}
}
