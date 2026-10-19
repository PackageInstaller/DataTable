using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SlapTendaySigninView : BaseUIView<SlapTendaySigninViewInputController>, IFacePushReusableView
{
	private const int DefaultItemAnimationPlayInterval = 30;

	public ActButton BtnClose;

	public int ItemAnimationPlayInterval;

	public Dictionary<int, GameObject> CharacterBG;

	public TimeAndDesItem m_TimeAndDesItem;

	public List<TenDaySignInItem> m_TenDaySignInItems;

	public GameObject GamepadTipsRoot;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public TextMeshProUGUI PromptLabel;

	private SlapTendaySigninViewData m_data;

	private int _activityId;

	private int _animationVersion;

	private bool _rewardRequesting;

	private bool _playedOpenAnimation;

	private bool _facePushShown;

	private ActivityData _activityData;

	private int _characterId;

	private readonly FacePushViewLifecycle _facePushLifecycle = new FacePushViewLifecycle();

	public override UniTask PreInit()
	{
		m_data = (uiViewData as SlapTendaySigninViewData) ?? new SlapTendaySigninViewData();
		_facePushLifecycle.Bind(m_data);
		_rewardRequesting = false;
		_facePushShown = false;
		EnsureSerializedReferences();
		if (BtnClose != null)
		{
			BtnClose.SetBtnClick(CloseFacePush);
		}
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		_playedOpenAnimation = false;
		_activityId = ResolveActivityId();
		if (_activityId <= 0 || !RefreshPanel())
		{
			_facePushLifecycle.NotifyOpenFailed((_activityId <= 0) ? "签到活动id无效" : "签到界面数据无效");
			Close();
			return;
		}
		_facePushShown = _facePushLifecycle.NotifyShown();
		if (!useAnimation)
		{
			PlayOpenContentAnimation();
		}
		if (_facePushShown)
		{
			ReportFacePushEvent(0, 1);
			ReportActivityEvent(_activityId, 0, 0, 1);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PlayOpenContentAnimation();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		CancelOpenContentAnimation();
		_facePushLifecycle.NotifyCloseTransitionStarted();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		else
		{
			CloseEffectFinishNew();
		}
	}

	protected override void UnInit()
	{
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
		base.UnInit();
		CancelOpenContentAnimation();
		_rewardRequesting = false;
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		_facePushLifecycle.NotifyOnCloseComplete();
	}

	public bool TryRefreshFacePush(object viewData)
	{
		if (!(viewData is SlapTendaySigninViewData slapTendaySigninViewData))
		{
			return false;
		}
		SlapTendaySigninViewData data = m_data;
		int activityId = _activityId;
		m_data = slapTendaySigninViewData;
		SetUIViewData(slapTendaySigninViewData);
		_activityId = ResolveActivityId();
		if (_activityId <= 0 || !RefreshPanel())
		{
			m_data = data;
			SetUIViewData(data);
			_activityId = activityId;
			RefreshPanel();
			return false;
		}
		_facePushLifecycle.Bind(m_data);
		_rewardRequesting = false;
		CancelOpenContentAnimation();
		_playedOpenAnimation = false;
		_facePushShown = _facePushLifecycle.NotifyShown();
		PlayOpenContentAnimation();
		if (_facePushShown)
		{
			ReportFacePushEvent(0, 1);
			ReportActivityEvent(_activityId, 0, 0, 1);
		}
		return true;
	}

	public void CloseFacePush()
	{
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
		if (!_facePushLifecycle.HasSession || !Model<FacePushModel>.HasInstance() || Model<FacePushModel>.Interface.Scheduler == null || !Model<FacePushModel>.Interface.Scheduler.TryRefreshCurrentFacePushWithSameUI(UI_TYPE.UI_SLAPTENDAYSIGNIN))
		{
			Close();
		}
	}

	private bool RefreshPanel()
	{
		ActivitSignInInfo activitySignInInfo = Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(_activityId);
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(_activityId);
		if (activitySignInInfo == null || activityCenterData == null)
		{
			return false;
		}
		m_TimeAndDesItem?.Init(activityCenterData, -1L);
		if (!RuntimeConfigs.data.activityDatas.TryGetValue(_activityId, out var value) || value == null || value.activityChallengGroup == null)
		{
			return false;
		}
		_activityData = value;
		RefreshItems(value);
		RefreshCharacterBackground(value);
		return true;
	}

	private void RefreshItems(ActivityData activityData)
	{
		if (m_TenDaySignInItems == null)
		{
			return;
		}
		int num = activityData.activityChallengGroup.Length;
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			TenDaySignInItem item = m_TenDaySignInItems[i];
			if (item == null)
			{
				continue;
			}
			if (i < num)
			{
				item.gameObject.SetActive(value: true);
				item.RefreshUI(i, _activityId, activityData.activityChallengGroup[i], Station);
				item.SetBtnClick(() =>
				{
					OnClickItem(item);
				});
			}
			else
			{
				item.gameObject.SetActive(value: false);
			}
		}
	}

	private void RefreshCharacterBackground(ActivityData activityData)
	{
		if (CharacterBG == null || CharacterBG.Count <= 0 || activityData.activityChallengGroup == null || activityData.activityChallengGroup.Length == 0 || !RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityData.activityChallengGroup[0], out var value) || value == null || value.challengeId == null || value.challengeId.Length == 0 || !RuntimeConfigs.data.activityChallengeDatas.TryGetValue(value.challengeId[0], out var value2) || value2 == null || value2.extraParm == null || value2.extraParm.Length == 0)
		{
			return;
		}
		int num = (_characterId = value2.extraParm[0]);
		foreach (KeyValuePair<int, GameObject> item in CharacterBG)
		{
			GameObject value3 = item.Value;
			if (!(value3 == null))
			{
				bool flag = item.Key == num;
				value3.SetActive(flag);
				if (flag)
				{
					(value3.GetComponent<BetterAnimation>()?.GetSequence("Show"))?.Goto(0f).Play();
				}
			}
		}
	}

	private int ResolveActivityId()
	{
		if (IsActivityReady(m_data.activityId))
		{
			return m_data.activityId;
		}
		int defaultActivityId = GetDefaultActivityId();
		if (HasReceivableReward(defaultActivityId))
		{
			return defaultActivityId;
		}
		if (IsActivityReady(defaultActivityId))
		{
			return defaultActivityId;
		}
		return 0;
	}

	private int GetDefaultActivityId()
	{
		if (!Model<ActivityCenterModel>.HasInstance())
		{
			return 0;
		}
		return Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.TenDay);
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

	private bool HasReceivableReward(int activityId)
	{
		if (!IsActivityReady(activityId) || !RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value) || value?.activityChallengGroup == null)
		{
			return false;
		}
		for (int i = 0; i < value.activityChallengGroup.Length; i++)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(value.activityChallengGroup[i], out var value2) && Model<ActivityCenterModel>.Interface.GetSignInGroupRewardState(activityId, value2) == ActivityCenterModel.ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	private void OnClickItem(TenDaySignInItem item)
	{
		if (!(item == null))
		{
			if (item.rewardState == ActivityCenterModel.ActivityRewardState.Normal)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
				{
					Id = item.itemKv.id,
					Count = item.itemKv.count
				});
			}
			else if (item.rewardState == ActivityCenterModel.ActivityRewardState.Receive && !_facePushLifecycle.TryExecuteButtonAction(null, null, null, () =>
			{
				ClaimReward(item);
			}))
			{
				ClaimReward(item);
			}
		}
	}

	private void ClaimReward(TenDaySignInItem item)
	{
		if (!(item == null) && !_rewardRequesting)
		{
			_rewardRequesting = true;
			int activityId = _activityId;
			int challengeGroupId = item.activityChallengeGroup.id;
			int challengeId = item.activityChallengeGroup.challengeId[0];
			FacePushSession facePushSession = m_data.FacePushSession;
			G.service.RequestActivitySignInReward(activityId, 0, 0, (ActivitySignInRewardAck activitySignInRewardAck) =>
			{
				OnActivitySignInRewardAck(item, activityId, challengeGroupId, challengeId, facePushSession, activitySignInRewardAck);
			});
			ReportFacePushEvent(0, 6);
		}
	}

	private void OnActivitySignInRewardAck(TenDaySignInItem tenDaySignInItem, int activityId, int challengeGroupId, int challengeId, FacePushSession facePushSession, ActivitySignInRewardAck activitySignInRewardAck)
	{
		bool flag = !IsDestroyed && m_data.FacePushSession == facePushSession && _activityId == activityId;
		if (flag)
		{
			_rewardRequesting = false;
		}
		if (tenDaySignInItem == null || activitySignInRewardAck == null)
		{
			return;
		}
		if (flag)
		{
			for (int i = 0; i < m_TenDaySignInItems.Count; i++)
			{
				TenDaySignInItem tenDaySignInItem2 = m_TenDaySignInItems[i];
				if (i < _activityData.activityChallengGroup.Length)
				{
					tenDaySignInItem2.RefreshUI(i, activityId, _activityData.activityChallengGroup[i], Station);
				}
			}
		}
		GameUtility.OpenPopReward(activitySignInRewardAck.GotItems);
		Model<ActivityCenterModel>.Interface.UpdateTenDaySignInRedDotState();
		ReportActivityEvent(activityId, 0, 0, 3);
	}

	private void PlayOpenContentAnimation()
	{
		if (!_playedOpenAnimation)
		{
			_playedOpenAnimation = true;
			PlayAnimationAsync().Forget();
			switch (_characterId)
			{
			case 11301:
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/10Day1301");
				break;
			case 12601:
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/10Day2601");
				break;
			}
		}
	}

	private async UniTaskVoid PlayAnimationAsync()
	{
		int animationVersion = ++_animationVersion;
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Show");
		if (animationBuilder != null)
		{
			animationBuilder.Goto(0f).OnComplete((AnimationBuilder _) =>
			{
				CompleteOpenContentAnimation(animationVersion);
			}).Play();
		}
		else
		{
			CompleteOpenContentAnimation(animationVersion);
		}
		if (m_TenDaySignInItems == null)
		{
			return;
		}
		for (int num = 0; num < m_TenDaySignInItems.Count; num++)
		{
			TenDaySignInItem tenDaySignInItem = m_TenDaySignInItems[num];
			if (tenDaySignInItem?.CanvasGroup != null)
			{
				tenDaySignInItem.CanvasGroup.alpha = 0f;
			}
		}
		int delay = ((ItemAnimationPlayInterval > 0) ? ItemAnimationPlayInterval : 30);
		int leftCount = Mathf.Min(5, m_TenDaySignInItems.Count);
		for (int i = 0; i < leftCount; i++)
		{
			if (animationVersion != _animationVersion)
			{
				break;
			}
			if (IsDestroyed)
			{
				break;
			}
			PlayItemAnimation(i, isLeft: true);
			PlayItemAnimation(i + 5, isLeft: false);
			await UniTask.Delay(delay);
		}
	}

	private void CompleteOpenContentAnimation(int animationVersion)
	{
		if (animationVersion == _animationVersion && !IsDestroyed)
		{
			OpenEffectFinishNew();
		}
	}

	private void CancelOpenContentAnimation()
	{
		_animationVersion++;
		betterAnimation?.StopAnimation();
		if (m_TenDaySignInItems != null)
		{
			for (int i = 0; i < m_TenDaySignInItems.Count; i++)
			{
				m_TenDaySignInItems[i]?.betterAnimation?.StopAnimation();
			}
		}
	}

	private void PlayItemAnimation(int index, bool isLeft)
	{
		if (m_TenDaySignInItems != null && index >= 0 && index < m_TenDaySignInItems.Count && !(m_TenDaySignInItems[index] == null) && m_TenDaySignInItems[index].gameObject.activeSelf)
		{
			m_TenDaySignInItems[index].PlayItemAnimation(isLeft);
		}
	}

	public void OnActivate()
	{
		if (MonoECS.instance != null)
		{
			OnInputDeviceChange(MonoECS.instance.InputMode);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (!(ViewControlRoot == null))
		{
			switch (dir)
			{
			case MoveDirection.Left:
				ViewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				ViewControlRoot.SelectRight();
				break;
			case MoveDirection.Up:
				ViewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				ViewControlRoot.SelectDown();
				break;
			}
			OnSelectItem();
		}
	}

	public void OpenActivityDetail()
	{
		m_TimeAndDesItem?.OnClickActivityDetailButtonHandle();
	}

	public void OnConfirm()
	{
		if (EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		}
		if (type != DeviceInputMode.Gamepad)
		{
			return;
		}
		for (int i = 0; i < m_TenDaySignInItems.Count; i++)
		{
			if (m_TenDaySignInItems[i].rewardState == ActivityCenterModel.ActivityRewardState.Receive)
			{
				ViewControlLayer.SetDefaultSelect(m_TenDaySignInItems[i].GetComponent<ACT.ViewControl.SelectableEx>());
				break;
			}
		}
		ViewControlLayer?.ReFocus();
		OnSelectItem();
	}

	private void OnSelectItem()
	{
		if (!(PromptLabel == null) && EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected == null))
		{
			TenDaySignInItem component = EventSystemHelper.CurrentSelected.GetComponent<TenDaySignInItem>();
			if (!(component == null))
			{
				PromptLabel.text = ((component.rewardState == ActivityCenterModel.ActivityRewardState.Receive) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1473) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774));
			}
		}
	}

	private void EnsureSerializedReferences()
	{
		if (betterAnimation == null)
		{
			betterAnimation = GetComponent<BetterAnimation>();
		}
		if (BtnClose == null)
		{
			ActButton[] componentsInChildren = GetComponentsInChildren<ActButton>(includeInactive: true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				if (componentsInChildren[i] != null && componentsInChildren[i].name == "btn_close_popup")
				{
					BtnClose = componentsInChildren[i];
					break;
				}
			}
		}
		if (m_TimeAndDesItem == null)
		{
			m_TimeAndDesItem = GetComponentInChildren<TimeAndDesItem>(includeInactive: true);
		}
		if (m_TenDaySignInItems == null)
		{
			m_TenDaySignInItems = new List<TenDaySignInItem>(10);
		}
		if (m_TenDaySignInItems.Count == 0)
		{
			GetComponentsInChildren(includeInactive: true, m_TenDaySignInItems);
		}
		if (ViewControlRoot == null)
		{
			ViewControlRoot = GetComponentInChildren<ViewControlRoot>(includeInactive: true);
		}
		if (ViewControlLayer == null)
		{
			ViewControlLayer = GetComponentInChildren<ViewControlLayer>(includeInactive: true);
		}
	}

	private void ReportFacePushEvent(int durationTime, int status)
	{
		PopupEvent evt = EventTrackSolver.Instance.GetEvt<PopupEvent>();
		evt.adId = m_data.FacePushSession.Config.id;
		evt.eventDuration = durationTime;
		evt.type = 3;
		evt.status = status;
		evt.subShopId = 0;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void ReportActivityEvent(int activityId, int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = activityId;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = true;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
