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
using ACT.Model.Jump;
using ACT.RichText;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class DailyTaskItem : MonoBehaviour, IComparable<DailyTaskItem>, ISelectHandler, IEventSystemHandler
{
	public LocalizeStringEvent taskName;

	public TMP_Text left;

	public TMP_Text right;

	public TMP_Text addCount;

	public ActButton getButton;

	public ActButton gotoButton;

	public GameObject inProcessGo;

	public GameObject completeButton;

	public GameObject mask;

	public BetterAnimation betterAnimation;

	public GameObject btnPrompt_confirm;

	public Action<DailyTaskItem> OnSelectCallback;

	private int _rowID;

	public DailyTaskState DailyTaskState { get; private set; }

	public int RowID
	{
		get
		{
			return _rowID;
		}
		set
		{
			_rowID = value;
			UpdateStyle();
		}
	}

	private void Awake()
	{
		getButton.SetBtnClick(OnClickGetReward);
		gotoButton.SetBtnClick(OnClickGotoButton);
	}

	public ActButton GetActiveButton()
	{
		if (getButton.gameObject.activeSelf)
		{
			return getButton;
		}
		if (gotoButton.gameObject.activeSelf)
		{
			return gotoButton;
		}
		return null;
	}

	private void OnClickGotoButton()
	{
		DailyMission data = CoreUtils.GetData(RowID, RuntimeConfigs.data.dailyMissions);
		if (data != null)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(data.jumpID);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
			}
			else
			{
				runTimeJumpData.FromSystem = SystemType.DailyMission;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				result.Release();
			}
		}
	}

	private void OnClickGetReward()
	{
		G.service.SendHandbookDailyMissionClaimReward(0, (bool b, List<Item> list) =>
		{
			if (b)
			{
				UpdateStyle();
				Model<HandBookModel>.Interface.RefreshDailyRedDot();
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateActivePoint, null);
			}
		});
	}

	public void UpdateStyle()
	{
		DailyMission data = CoreUtils.GetData(RowID, RuntimeConfigs.data.dailyMissions);
		if (data == null)
		{
			return;
		}
		MissionGroup data2 = CoreUtils.GetData(data.groupID, RuntimeConfigs.data.missionGroups);
		addCount.SetText(data.missionRewards.FastToString());
		if (data2 == null)
		{
			return;
		}
		ACT.Config.Mission data3 = CoreUtils.GetData(data2.missionId.FirstOrDefault(), RuntimeConfigs.data.missions);
		bool flag = Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(data2.missionId.FirstOrDefault(), out var value);
		string arg = CustomTagParser.ReplacePreconditionText(data3, data3.number, data3.param);
		taskName.OnUpdateString?.Invoke(arg);
		if (G.localPlayer.DailyData.HandbookRewardStatus.DailyConditionTaskReward.TryGetValue(_rowID, out var _))
		{
			completeButton.SetActive(value: true);
			getButton.gameObject.SetActive(value: false);
			gotoButton.gameObject.SetActive(value: false);
			inProcessGo.SetActive(value: false);
			mask.SetActive(value: true);
			DailyTaskState = DailyTaskState.HasGot;
			btnPrompt_confirm.SetActive(value: false);
			return;
		}
		if (data3.preconditionId == 18)
		{
			var (text, text2) = CountConditionProcess.CumulativeOnlineDurationProcess(data3.preconditionId, value?.progress ?? 0, data3.number);
			left.text = text;
			right.text = text2;
		}
		else
		{
			left.text = value?.progress.FastToString();
			right.text = data3.number.FastToString();
		}
		if (!flag || value.status == 0)
		{
			if (data.jumpID != 0)
			{
				completeButton.SetActive(value: false);
				getButton.gameObject.SetActive(value: false);
				gotoButton.gameObject.SetActive(value: true);
				inProcessGo.SetActive(value: false);
				DailyTaskState = DailyTaskState.CanJump;
			}
			else
			{
				completeButton.SetActive(value: false);
				getButton.gameObject.SetActive(value: false);
				gotoButton.gameObject.SetActive(value: false);
				inProcessGo.SetActive(value: true);
				DailyTaskState = DailyTaskState.InProgress;
			}
			mask.SetActive(value: false);
		}
		else if (value.status == 1)
		{
			completeButton.SetActive(value: false);
			getButton.gameObject.SetActive(value: true);
			gotoButton.gameObject.SetActive(value: false);
			getButton.interactable = true;
			inProcessGo.SetActive(value: false);
			mask.SetActive(value: false);
			DailyTaskState = DailyTaskState.CanGet;
		}
		btnPrompt_confirm.SetActive(gotoButton.gameObject.activeInHierarchy || getButton.gameObject.activeInHierarchy);
	}

	public void PlayAnimation(float delay = 0f)
	{
		betterAnimation?.GetSequence("Show")?.Goto(0f).SetDelay(delay).Play();
	}

	public void OnSelect(BaseEventData eventData)
	{
		OnSelected();
	}

	public void OnSelected()
	{
		OnSelectCallback?.Invoke(this);
	}

	public int CompareTo(DailyTaskItem other)
	{
		if (!other)
		{
			return 1;
		}
		return DailyTaskState - other.DailyTaskState;
	}
}
