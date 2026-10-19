using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivitySecondMission : MonoBehaviour
{
	public LocalizeStringEvent missionName;

	public TMP_Text missionProgress;

	public TMP_Text missionCompleteProgress;

	public TMP_Text lotteryCount;

	public Image fillImage;

	public MissionDot dotTemplate;

	public Transform dotContent;

	[Header("跳转按钮")]
	public ActButton jumpButton;

	public GameObject inprogress;

	public GameObject complete;

	public GameObject PromptY;

	private int _challengeID;

	private ACT.Battle.TaskInfo _taskInfo;

	private int _challengeCompleteCount;

	private ActivityChallengeData _activityChallengeData;

	private ACT.Config.Mission _missionData;

	private List<GameObject> _dots;

	public int ChallengeGroupID { get; set; }

	public int ChallengeID
	{
		get
		{
			return _challengeID;
		}
		set
		{
			_challengeID = value;
			_activityChallengeData = CoreUtils.GetData(_challengeID, RuntimeConfigs.data.activityChallengeDatas);
			MissionGroup data = CoreUtils.GetData(_activityChallengeData.missionGroupId, RuntimeConfigs.data.missionGroups);
			_missionData = CoreUtils.GetData(data.missionId.FirstOrDefault(), RuntimeConfigs.data.missions);
			ActivityDailyLotteryInfo lotteryInfo = Model<ActivityCenterModel>.Interface.GetLotteryInfo();
			Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(_missionData.id, out _taskInfo);
			lotteryInfo.TaskFinishInfo.TryGetValue(_challengeID, out _challengeCompleteCount);
			UpdateStyle();
		}
	}

	private void Awake()
	{
		jumpButton.SetBtnClick(OnJump);
	}

	private void UpdateStyle()
	{
		string arg = CustomTagParser.ReplacePreconditionText(_missionData, _missionData.number, _missionData.param);
		missionName.OnUpdateString?.Invoke(arg);
		int num = _taskInfo?.progress ?? 0;
		string arg2 = ((num > 0) ? "#F1E050" : "#C2C6B5");
		missionProgress.SetText($"<color={arg2}>{num}</color>/{_missionData.number}");
		string arg3 = ((_challengeCompleteCount > 0) ? "#F1E050" : "#C2C6B5");
		missionCompleteProgress.SetText($"<color={arg3}>{_challengeCompleteCount}</color>/{_activityChallengeData.times}");
		lotteryCount.SetText(_activityChallengeData.lotteryRewards.FirstOrDefault()?.count.FastToString());
		fillImage.fillAmount = 1f * (float)_challengeCompleteCount / (float)_activityChallengeData.times;
		UpdateDots();
		if (_challengeCompleteCount >= _activityChallengeData.times)
		{
			jumpButton.gameObject.SetActive(value: false);
			complete.SetActive(value: true);
			inprogress.SetActive(value: false);
		}
		else if (_activityChallengeData.challengeJump.FirstOrDefault() != 0)
		{
			jumpButton.gameObject.SetActive(value: true);
			complete.SetActive(value: false);
			inprogress.SetActive(value: false);
		}
		else
		{
			jumpButton.gameObject.SetActive(value: false);
			complete.SetActive(value: false);
			inprogress.SetActive(value: true);
		}
	}

	private void UpdateDots()
	{
		if (_dots != null)
		{
			foreach (GameObject dot in _dots)
			{
				Object.Destroy(dot);
			}
			_dots.Clear();
		}
		else
		{
			_dots = ListPool<GameObject>.Get();
		}
		for (int i = 0; i < _activityChallengeData.times; i++)
		{
			MissionDot missionDot = Object.Instantiate(dotTemplate, dotContent);
			missionDot.activeDot.SetActive(i < _challengeCompleteCount);
			missionDot.gameObject.SetActive(value: true);
			_dots.Add(missionDot.gameObject);
		}
	}

	private void OnDestroy()
	{
		if (_dots != null)
		{
			ListPool<GameObject>.Release(_dots);
			_dots = null;
		}
	}

	public void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		if (_missionData != null && taskId == _missionData.id)
		{
			_taskInfo = taskInfo;
			Model<ActivityCenterModel>.Interface.GetLotteryInfo().TaskFinishInfo.TryGetValue(_challengeID, out _challengeCompleteCount);
			UpdateStyle();
		}
	}

	private void OnJump()
	{
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_activityChallengeData.challengeJump.FirstOrDefault());
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (result.ShowType != JumpResult.JumpShowType.CanJump)
		{
			GameUtility.OpenJumpResultTips(result);
			result.Release();
			return;
		}
		runTimeJumpData.FromSystem = SystemType.Activity;
		Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		result.Release();
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = Model<ActivityCenterModel>.Interface.OpenActivityID;
		evt.status = 2;
		evt.challengeId = ChallengeID;
		evt.challengeGroupId = ChallengeGroupID;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
