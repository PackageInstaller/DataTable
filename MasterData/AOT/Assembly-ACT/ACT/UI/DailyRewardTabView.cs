using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class DailyRewardTabView : BaseTabContent
{
	[Header("上侧")]
	[SerializeField]
	public LocalizeStringEvent mainTitle;

	public TMP_Text activePointNumText;

	public Image progressBar;

	public ActiveNode[] activeNodes;

	public ActButton ruleButton;

	[Header("中侧")]
	public DailyTaskItem dailyTaskItemTemplate;

	public Transform dailyTaskListParent;

	[Header("下侧")]
	[SerializeField]
	public CommonTimerComponent timer;

	[Header("奖励预览面板")]
	public DailyRewardPanel rewardPanel;

	[Header("动效")]
	public float delayTime = 0.1f;

	private float _maxActivePointNum = 500f;

	private HandBookMain _mainData;

	private HbContent _subData;

	private MonoHandbookView _view;

	private int ActivePointItemId => GameUtility.ActivePointDailyRewardId();

	private int ActivePointNum
	{
		get
		{
			if (!G.detailUserInfo.Attributes.TryGetValue(RuntimeConfigs.data.game.attrActivePoint, out var value))
			{
				return 0;
			}
			return (int)value;
		}
	}

	public void OnNodeClick(ActiveNode active)
	{
		if (active.canObtain.activeSelf)
		{
			G.service.SendHandbookDailyActivePtClaimReward((bool b, List<Item> items) =>
			{
				if (b)
				{
					GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items));
					UpdateActiveNodes();
					UpdateActiveProgressBar();
					UpdateActivePointNumber();
					Model<HandBookModel>.Interface.RefreshDailyRedDot();
				}
			});
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HandBookDailyReward);
			return;
		}
		DailyMissionReward data = CoreUtils.GetData(active.DailyMissionRewardID, RuntimeConfigs.data.dailyMissionRewards);
		if (data != null)
		{
			rewardPanel.CollectionID = data.rewards;
			RectTransform component = active.GetComponent<RectTransform>();
			Vector3[] array = new Vector3[4];
			component.GetWorldCorners(array);
			rewardPanel.Position = (array[1] + array[2]) / 2f;
			rewardPanel.IsComplete = active.hasObtain.activeSelf;
			_view.ViewControlLayers[HandBookSubController.rewardWindow].SetDefaultSelect(active.GetComponent<ACT.ViewControl.SelectableEx>());
			_view.ChangeToGamePadInputState(HandBookSubController.rewardWindow);
		}
	}

	private void Awake()
	{
		GenTasks();
		BindDelegate();
		ruleButton.SetBtnClick(() =>
		{
			HandBookMain data = CoreUtils.GetData(Tab.TabIdentify, RuntimeConfigs.data.handBookMains);
			CoreUtils.GetData(data.contentLv2ID.First(), RuntimeConfigs.data.hbContents);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				iconId = 1028,
				titleTextId = data.contentLv1name,
				descTextId = _subData.message
			});
		});
		Model<HandBookModel>.Interface.RefreshDailyRedDot();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UpdateActivePoint, OnActivePointUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskInfoChanged;
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UpdateActivePoint, OnActivePointUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskInfoChanged;
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_mainData = CoreUtils.GetData(Tab.TabIdentify, RuntimeConfigs.data.handBookMains);
		_subData = CoreUtils.GetData(_mainData.contentLv2ID.First(), RuntimeConfigs.data.hbContents);
		_maxActivePointNum = ((float?)RuntimeConfigs.data.dailyMissionRewards.LastOrDefault().Value?.creditRequire) ?? 500f;
		UpdateActivePointNumber();
		UpdateActiveNodes();
		UpdateActiveProgressBar();
		UpdateTasks();
		UpdateRuleButtonState();
		Model<HandBookModel>.Interface.RefreshDailyRedDot();
		System.DateTime now = TimeManager.ServerTime.Now;
		System.DateTime dateTime = new System.DateTime(now.Year, now.Month, now.Day, 4, 0, 0).AddDays(1.0);
		CommonTimerComponent commonTimerComponent = timer;
		System.DateTime minValue = System.DateTime.MinValue;
		commonTimerComponent.Time = minValue.Add(dateTime - now);
		timer.IsCountDown = true;
		_view.ChangeToGamePadInputState(HandBookSubController.dairyMain);
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		_view.ChangeToGamePadInputState(_view.GetCurSubControllerType(), needReFocusLayer: true);
	}

	private void UpdateRuleButtonState()
	{
		ruleButton.gameObject.SetActive(_subData.message != 0);
	}

	public void SetView(MonoHandbookView view)
	{
		_view = view;
	}

	public override void PlayOpenAnim()
	{
		base.PlayOpenAnim();
		SortTasks();
		PlayTaskAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		if (rewardPanel.gameObject.activeSelf)
		{
			rewardPanel.ClosePanel();
		}
	}

	private void UpdateActivePointNumber()
	{
		activePointNumText.SetText(ActivePointNum.FastToString());
	}

	private void UpdateActiveNodes()
	{
		for (int i = 0; i < activeNodes.Length; i++)
		{
			activeNodes[i].DailyMissionRewardID = i + 1;
		}
	}

	private void UpdateActiveProgressBar()
	{
		if ((bool)progressBar)
		{
			progressBar.fillAmount = (float)ActivePointNum / _maxActivePointNum;
		}
	}

	private void UpdateTasks()
	{
		int childCount = dailyTaskListParent.childCount;
		for (int i = 0; i < childCount; i++)
		{
			dailyTaskListParent.GetChild(i).GetComponent<DailyTaskItem>().UpdateStyle();
		}
	}

	private void SortTasks()
	{
		DailyTaskItem[] componentsInChildren = dailyTaskListParent.GetComponentsInChildren<DailyTaskItem>();
		Array.Sort(componentsInChildren, (DailyTaskItem b, DailyTaskItem a) => a.DailyTaskState.CompareTo(b.DailyTaskState));
		for (int num = 0; num < componentsInChildren.Length; num++)
		{
			componentsInChildren[num].transform.SetSiblingIndex(num);
		}
	}

	private void PlayTaskAnimation()
	{
		int childCount = dailyTaskListParent.childCount;
		for (int i = 0; i < childCount; i++)
		{
			dailyTaskListParent.GetChild(i).GetComponent<DailyTaskItem>().PlayAnimation((float)i * delayTime);
		}
	}

	private void GenTasks()
	{
		foreach (KeyValuePair<int, DailyMission> dailyMission in RuntimeConfigs.data.dailyMissions)
		{
			DailyTaskItem dailyTaskItem = UnityEngine.Object.Instantiate(dailyTaskItemTemplate, dailyTaskListParent);
			dailyTaskItem.RowID = dailyMission.Value.id;
			dailyTaskItem.gameObject.SetActive(value: true);
		}
	}

	private void BindDelegate()
	{
		ActiveNode[] array = activeNodes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnActiveNodeClick = OnNodeClick;
		}
	}

	private void OnActivePointUpdate(BaseEventContent eventContent)
	{
		UpdateTasks();
		UpdateActiveNodes();
		UpdateActiveProgressBar();
		UpdateActivePointNumber();
	}

	private void OnTaskInfoChanged(int arg1, ACT.Battle.TaskInfo arg2, bool arg3)
	{
		UpdateTasks();
	}
}
