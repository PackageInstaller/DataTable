using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class NewbieLoginView : BaseUIView<NewbieLoginViewInputController>
{
	public ActButton BtnClose;

	public TimeAndDesItem TimeAndDesItem;

	public List<SevenDaySignInItem> SevenDaySignInItems;

	public GamePadTipsComp GamePadTipsComp;

	private readonly FacePushViewLifecycle _facePushLifecycle = new FacePushViewLifecycle();

	private readonly List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private readonly Dictionary<string, GamePadTipsAction> _actionDic = new Dictionary<string, GamePadTipsAction>();

	private NewbieLoginViewData m_data;

	private ActivitSignInInfo _activitySignInInfo;

	private ActivityCenterData _activityCenterData;

	private Coroutine _openAnimationCoroutine;

	private int _activityId;

	private int _curGamepadSelectItemIndex = -1;

	private bool _playedOpenAnimation;

	private bool _facePushShown;

	public override UniTask PreInit()
	{
		m_data = (uiViewData as NewbieLoginViewData) ?? new NewbieLoginViewData();
		_facePushLifecycle.Bind(m_data);
		_facePushShown = false;
		BtnClose?.SetBtnClick(Close);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivitySignInInfo, UpdateActivitySignInInfo);
		_playedOpenAnimation = false;
		_activityId = ResolveActivityId();
		if (_activityId <= 0 || !RefreshUI())
		{
			_facePushLifecycle.NotifyOpenFailed((_activityId <= 0) ? "新手签到活动id无效" : "新手签到界面数据无效");
			Close();
			return;
		}
		_facePushShown = _facePushLifecycle.NotifyShown();
		InitGameTipsDic();
		OnActivate();
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		}
		if (_facePushShown)
		{
			ReportFacePushEvent(0, 1);
		}
		ReportActivityEvent(0, 0, 1);
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (_openAnimationCoroutine != null)
		{
			StopCoroutine(_openAnimationCoroutine);
			_openAnimationCoroutine = null;
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivitySignInInfo, UpdateActivitySignInInfo);
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
		}
		_tipsActions.Clear();
		_actionDic.Clear();
		_curGamepadSelectItemIndex = -1;
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		_facePushLifecycle.NotifyOnCloseComplete();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		(betterAnimation?.GetSequence("Show"))?.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/7Day");
	}

	public void OnActivate()
	{
		if (MonoECS.instance != null)
		{
			OnControllerStatusChange(MonoECS.instance.InputMode);
		}
	}

	public void OnClickChangeButtonHandle()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SEVENDAYSIGNINFIXED);
	}

	public void Left()
	{
		if (_curGamepadSelectItemIndex > 0 && HasValidItem(_curGamepadSelectItemIndex))
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: false);
			_curGamepadSelectItemIndex--;
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
			RefreshGamepadComp();
		}
	}

	public void Right()
	{
		if (_curGamepadSelectItemIndex >= 0 && SevenDaySignInItems != null && _curGamepadSelectItemIndex < SevenDaySignInItems.Count - 1)
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: false);
			_curGamepadSelectItemIndex++;
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
			RefreshGamepadComp();
		}
	}

	public void ButtonWest()
	{
		if (_activityId > 0 && Model<ActivityCenterModel>.HasInstance() && !Model<ActivityCenterModel>.Interface.GetFixedRewardIsReceive(_activityId))
		{
			OnClickChangeButtonHandle();
		}
	}

	public void ButtonSouth()
	{
		if (HasValidItem(_curGamepadSelectItemIndex) && SevenDaySignInItems[_curGamepadSelectItemIndex].GetRewardState() != 2)
		{
			OnClickRewardItem(SevenDaySignInItems[_curGamepadSelectItemIndex]);
		}
	}

	public void RightStickPress()
	{
		TimeAndDesItem?.OnClickActivityDetailButtonHandle();
	}

	public void LeftStickPress()
	{
		if (HasValidItem(_curGamepadSelectItemIndex))
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].OpenRewardDetail();
		}
	}

	private void UpdateActivitySignInInfo(BaseEventContent baseEventContent)
	{
		RefreshUI();
		OnActivate();
	}

	private int ResolveActivityId()
	{
		if (IsActivityReady(m_data.activityId))
		{
			return m_data.activityId;
		}
		int defaultActivityId = GetDefaultActivityId();
		if (!IsActivityReady(defaultActivityId))
		{
			return 0;
		}
		return defaultActivityId;
	}

	private int GetDefaultActivityId()
	{
		if (!Model<ActivityCenterModel>.HasInstance())
		{
			return 0;
		}
		return Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.SevenDay);
	}

	private bool IsActivityReady(int activityId)
	{
		if (activityId <= 0 || !Model<ActivityCenterModel>.HasInstance() || RuntimeConfigs.data?.activityDatas == null)
		{
			return false;
		}
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId);
		if (activityCenterData != null && activityCenterData.IsVaild() && Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(activityId) != null)
		{
			return RuntimeConfigs.data.activityDatas.ContainsKey(activityId);
		}
		return false;
	}

	private bool RefreshUI()
	{
		if (_activityId <= 0 || !Model<ActivityCenterModel>.HasInstance())
		{
			return false;
		}
		_activitySignInInfo = Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(_activityId);
		if (_activitySignInInfo == null)
		{
			return false;
		}
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activityId);
		if (_activityCenterData == null || _activityCenterData.StaticActivityData == null)
		{
			return false;
		}
		TimeAndDesItem?.Init(_activityCenterData, -1L);
		RefreshItem();
		return true;
	}

	private void RefreshItem()
	{
		if (SevenDaySignInItems == null)
		{
			return;
		}
		for (int i = 0; i < SevenDaySignInItems.Count; i++)
		{
			if (SevenDaySignInItems[i] == null)
			{
				continue;
			}
			SevenDaySignInItems[i].RefreshUI(i, _activityCenterData.StaticActivityData, _activitySignInInfo, m_data.FacePushSession.Config.id);
			SevenDaySignInItem item = SevenDaySignInItems[i];
			if (item.ItemButton != null)
			{
				item.ItemButton.SetBtnClick(() =>
				{
					OnClickRewardItem(item);
				});
			}
		}
	}

	private void OnClickRewardItem(SevenDaySignInItem item)
	{
		if (!(item == null) && !_facePushLifecycle.TryExecuteButtonAction(null, null, null, item.OnClickItemButtonHandle))
		{
			item.OnClickItemButtonHandle();
		}
	}

	private void InitGameTipsDic()
	{
		_actionDic.Clear();
		_actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		_actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		_actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect",
			localizeKey = 2164,
			localizeTable = "Common"
		});
		_actionDic.Add("UI/LeftStackPress", new GamePadTipsAction
		{
			inputAction = "UI/LeftStackPress",
			localizeKey = 893,
			localizeTable = "Common"
		});
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		ClearItemSelectState();
		if (GamePadTipsComp == null)
		{
			return;
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			_curGamepadSelectItemIndex = -1;
			GamePadTipsComp.ClearAllPrompts();
			return;
		}
		_curGamepadSelectItemIndex = GetNormalSelectItemIndex();
		if (HasValidItem(_curGamepadSelectItemIndex))
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
		}
		RefreshGamepadComp();
	}

	private void RefreshGamepadComp()
	{
		if (!(GamePadTipsComp == null))
		{
			_tipsActions.Clear();
			GamePadTipsComp.ClearAllPrompts();
			if (_actionDic.TryGetValue("UI/Confirm", out var value))
			{
				_tipsActions.Add(value);
			}
			if (_actionDic.TryGetValue("UI/Back", out var value2))
			{
				_tipsActions.Add(value2);
			}
			if (_curGamepadSelectItemIndex != 1 && _actionDic.TryGetValue("UI/LeftStackPress", out var value3))
			{
				_tipsActions.Add(value3);
			}
			GamePadTipsComp.RegisterInputActions(_tipsActions);
		}
	}

	private int GetNormalSelectItemIndex()
	{
		if (SevenDaySignInItems == null || SevenDaySignInItems.Count <= 0)
		{
			return -1;
		}
		for (int i = 0; i < SevenDaySignInItems.Count; i++)
		{
			if (SevenDaySignInItems[i] != null && SevenDaySignInItems[i].GetRewardState() == 1)
			{
				return i;
			}
		}
		for (int j = 0; j < SevenDaySignInItems.Count; j++)
		{
			if (SevenDaySignInItems[j] != null && SevenDaySignInItems[j].GetRewardState() == 0)
			{
				return j;
			}
		}
		return 0;
	}

	private bool HasValidItem(int index)
	{
		if (SevenDaySignInItems != null && index >= 0 && index < SevenDaySignInItems.Count)
		{
			return SevenDaySignInItems[index] != null;
		}
		return false;
	}

	private void ClearItemSelectState()
	{
		if (SevenDaySignInItems != null)
		{
			for (int i = 0; i < SevenDaySignInItems.Count; i++)
			{
				SevenDaySignInItems[i]?.SetGamepadSelect(active: false);
			}
		}
	}

	private void ReportFacePushEvent(int durationTime, int status)
	{
		if (m_data?.FacePushSession?.Config != null)
		{
			PopupEvent evt = EventTrackSolver.Instance.GetEvt<PopupEvent>();
			evt.adId = m_data.FacePushSession.Config.id;
			evt.eventDuration = durationTime;
			evt.type = 3;
			evt.status = status;
			evt.subShopId = 0;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	private void ReportActivityEvent(int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = _activityId;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = true;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Hide");
		if (animationBuilder == null)
		{
			CloseEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}
}
