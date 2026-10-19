using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class ThirtyFiveDaySignIn : ActivityCenterBaseUIView<ThirtyFiveDaySignInController>
{
	[Header("Components")]
	public TimeAndDesItem m_TimeAndDesItem;

	public RectTransform m_Grid;

	public ThirtyFiveDaySignInItem m_Template;

	public List<ThirtyFiveDaySignInItem> m_35DaySignInItems;

	public List<ThirtyFiveDaySignInItem> m_BigPrizes;

	public TextMeshProUGUI m_dayCount;

	public PrizeDayTag[] DayTags;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	public GamePadTipsComp gamePadGroup;

	private int DayCount;

	private ActivityData _activityData;

	private int _showAnimationVersion;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	private int activityId => Model<ActivityCenterModel>.Interface.SelectActivityId;

	private ActivityCenterData activityCenterData => Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId);

	protected override void Init()
	{
		int animationVersion = ++_showAnimationVersion;
		OnGamePadInit();
		ReBindBtnPrompt();
		ActivitSignInInfo activitySignInInfo = Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(activityId);
		if (activitySignInInfo == null || activityCenterData == null)
		{
			return;
		}
		long starTime = activitySignInInfo.ActivityBaseInfo.PeriodStartTime * 1000;
		long loopActivityEndTime = Model<ActivityCenterModel>.Interface.GetLoopActivityEndTime(starTime, activityCenterData.StaticActivityData.loopType);
		m_TimeAndDesItem.Init(activityCenterData, loopActivityEndTime);
		RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value);
		if (value == null)
		{
			return;
		}
		_activityData = value;
		if (m_35DaySignInItems.Count < 1)
		{
			for (int i = 0; i < 35; i++)
			{
				ThirtyFiveDaySignInItem item = Object.Instantiate(m_Template, m_Grid);
				m_35DaySignInItems.Add(item);
			}
			m_35DaySignInItems.AddRange(m_BigPrizes);
		}
		foreach (ThirtyFiveDaySignInItem item3 in m_35DaySignInItems.Take(35))
		{
			item3.ResetAnimation();
		}
		for (int j = 0; j < m_35DaySignInItems.Count; j++)
		{
			ThirtyFiveDaySignInItem item2 = m_35DaySignInItems[j];
			if (j < value.activityChallengGroup.Length)
			{
				item2.gameObject.SetActive(value: true);
				item2.RefreshUI(j, activityId, value.activityChallengGroup[j]);
				ActivityCenterModel.ActivityRewardState rewardState = item2.rewardState;
				if (j >= 35)
				{
					DayTags[j - 35].SetStatus(rewardState);
				}
				item2.SetBtnClick(() =>
				{
					OnClickItem(item2);
				});
			}
			else
			{
				item2.gameObject.SetActive(value: false);
			}
		}
		Show(animationVersion).Forget();
		RefreshDayCount();
		GetController().SelectDefaultReward();
		GetComponent<BetterAnimation>().GetSequence("Show").Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_showAnimationVersion++;
	}

	private async UniTask Show(int animationVersion)
	{
		await UniTask.WaitForSeconds(0.25f);
		if (!IsShowAnimationValid(animationVersion))
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/35Day_Open");
		foreach (ThirtyFiveDaySignInItem item in m_35DaySignInItems.Take(35))
		{
			await UniTask.WaitForSeconds(0.005f);
			if (!IsShowAnimationValid(animationVersion))
			{
				return;
			}
			item.PlayAnimation();
		}
	}

	private bool IsShowAnimationValid(int animationVersion)
	{
		if (animationVersion == _showAnimationVersion)
		{
			return isActiveAndEnabled;
		}
		return false;
	}

	public void OpenActivityDetail()
	{
		m_TimeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	private void OnClickItem(ThirtyFiveDaySignInItem item)
	{
		if (item.rewardState == ActivityCenterModel.ActivityRewardState.Receive)
		{
			G.service.RequestActivitySignInReward(activityId, 0, 0, (ActivitySignInRewardAck activitySignInRewardAck) =>
			{
				OnActivitySignInRewardAck(item, activitySignInRewardAck);
			});
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = item.itemKv.id,
				Count = item.itemKv.count
			});
		}
	}

	private void OnActivitySignInRewardAck(ThirtyFiveDaySignInItem signInItem, ActivitySignInRewardAck activitySignInRewardAck)
	{
		for (int i = 0; i < m_35DaySignInItems.Count; i++)
		{
			ThirtyFiveDaySignInItem thirtyFiveDaySignInItem = m_35DaySignInItems[i];
			if (i < _activityData.activityChallengGroup.Length)
			{
				thirtyFiveDaySignInItem.gameObject.SetActive(value: true);
				thirtyFiveDaySignInItem.RefreshUI(i, activityId, _activityData.activityChallengGroup[i]);
				ActivityCenterModel.ActivityRewardState rewardState = thirtyFiveDaySignInItem.rewardState;
				if (i >= 35)
				{
					DayTags[i - 35].SetStatus(rewardState);
				}
			}
		}
		GameUtility.OpenPopReward(activitySignInRewardAck.GotItems);
		RefreshDayCount();
		ReportActivityEvent(0, 0, 3);
	}

	private void RefreshDayCount()
	{
		DayCount = m_35DaySignInItems.Take(35).Count((ThirtyFiveDaySignInItem item) => item.gameObject.activeSelf && item.rewardState != ActivityCenterModel.ActivityRewardState.Normal);
		m_dayCount.text = DayCount.ToString();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	private void ReportActivityEvent(int challengeId, int challengeGroupId, int status)
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
		evt.status = status;
		evt.challengeId = challengeId;
		evt.challengeGroupId = challengeGroupId;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
