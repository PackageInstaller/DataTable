using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using TMPro;
using UnityEngine;

namespace Runtime.UI;

public class BattleMainTeamTeachingComponent : MonoBehaviour, IBattleMainComponent
{
	[SerializeField]
	private GameObject timer;

	[SerializeField]
	private GameObject teamTeachingObj;

	[SerializeField]
	private TextMeshProUGUI raidName;

	[SerializeField]
	private CommonSubWorldTargetItem[] targetItems;

	[SerializeField]
	private TextMeshProUGUI currentTime;

	private TeamTeachingModel _teamTeachingModel;

	private void ActiveTimer(bool active)
	{
		if (active && _teamTeachingModel != null)
		{
			SetTeamTeachingUI(_teamTeachingModel.CurrentTrainingContent);
		}
		if (timer != null)
		{
			timer.SetActive(active);
		}
		if (active)
		{
			UpdateTimer();
		}
	}

	private void UpdateTimer()
	{
		if (_teamTeachingModel != null)
		{
			int teamTeachingTotalTime = _teamTeachingModel.GetTeamTeachingTotalTime();
			int num = teamTeachingTotalTime / 60;
			int num2 = teamTeachingTotalTime % 60;
			if (currentTime != null)
			{
				currentTime.SetText("{0:00}:{1:00}", num, num2);
			}
		}
	}

	private void UpdateTimerEvt()
	{
		UpdateTimer();
	}

	private void SetTeamTeachingUI(TrainingContents trainingContent)
	{
		bool flag = MonoECS.instance.sceneStatus == SceneStatus.Raid && trainingContent != null;
		teamTeachingObj.SetActive(flag);
		if (!flag)
		{
			return;
		}
		raidName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, trainingContent.contentLv1name);
		IReadOnlyList<int> targetConditionIds = _teamTeachingModel.TargetConditionIds;
		for (int i = 0; i < targetItems.Length; i++)
		{
			bool flag2 = i < targetConditionIds.Count;
			targetItems[i].gameObject.SetActive(flag2);
			if (flag2)
			{
				targetItems[i].UpdateState(targetConditionIds[i], ChallengeTargetTextUtility.GetText(targetConditionIds[i]));
			}
		}
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		UnInitialize();
		_teamTeachingModel = Model<TeamTeachingModel>.Interface;
		if (_teamTeachingModel != null)
		{
			_teamTeachingModel.ActiveTimerAction += ActiveTimer;
			_teamTeachingModel.UpdateTimerAction += UpdateTimerEvt;
			ActiveTimer(_teamTeachingModel.TimerUpdate);
			SetTeamTeachingUI(_teamTeachingModel.CurrentTrainingContent);
		}
	}

	public void UnInitialize()
	{
		if (_teamTeachingModel != null)
		{
			_teamTeachingModel.ActiveTimerAction -= ActiveTimer;
			_teamTeachingModel.UpdateTimerAction -= UpdateTimerEvt;
			_teamTeachingModel = null;
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
