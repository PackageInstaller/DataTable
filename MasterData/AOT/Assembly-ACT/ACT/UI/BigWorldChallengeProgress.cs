using System.Collections.Generic;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.UI;

public class BigWorldChallengeProgress : MonoBehaviour, IBattleMainComponent
{
	[Header("大世界挑战相关")]
	public TextMeshProUGUI textTimemin;

	public TextMeshProUGUI textTimesec;

	public BetterAnimation TimebetterAnimation;

	public LocalizeStringEvent TextprogressTitle;

	public LocalizeStringEvent TextprogressSubTask;

	public BetterAnimation ProgressAnimation;

	private int soundSec;

	private const int COUNTDOWN_LOOP_THRESHOLD = 10;

	private static readonly string[] s_timeStrings = InitTimeStrings();

	private bool isToggle;

	public ActButton _btnStopChallenge;

	private CanvasGroup _canvasGroup;

	private bool timerShowDone;

	private bool _isCountDownLoopPlaying;

	private void Awake()
	{
		_btnStopChallenge.SetBtnClick(ChangeExit);
		_canvasGroup = GetComponent<CanvasGroup>();
	}

	private void OnEnable()
	{
		AddEventListener();
	}

	public void AddEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.AddEventListener(ClientEvent.UI_BigWorldSuccess, OnBigWorldSuccess);
		instance.AddEventListener(ClientEvent.UI_BigWorldFail, OnBigWorldFail);
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWordChangeTimerEventHandler += OnRefreshComponent;
		Model<BigWorldChallengeProgressModel>.Interface.OnRefreshBigWorldProgressTitleEventHandler += OnRefreshTextProgressTitle;
		Model<BigWorldChallengeProgressModel>.Interface.OnRefreshBigWorldProgressEventHandler += OnRefreshTextProgressSubTask;
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWorldProgressTitleEventHandlerEventHandler += OnRefreshBigWorldProgressTitle;
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWorldProgressExit += OnOnBigWorldProgressExit;
	}

	private void OnOnBigWorldProgressExit()
	{
		ChangeExit();
	}

	private void OnDisable()
	{
		RemoveEventListener();
	}

	public void RemoveEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.RemoveEventListener(ClientEvent.UI_BigWorldSuccess, OnBigWorldSuccess);
		instance.RemoveEventListener(ClientEvent.UI_BigWorldFail, OnBigWorldFail);
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWordChangeTimerEventHandler -= OnRefreshComponent;
		Model<BigWorldChallengeProgressModel>.Interface.OnRefreshBigWorldProgressTitleEventHandler -= OnRefreshTextProgressTitle;
		Model<BigWorldChallengeProgressModel>.Interface.OnRefreshBigWorldProgressEventHandler -= OnRefreshTextProgressSubTask;
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWorldProgressTitleEventHandlerEventHandler -= OnRefreshBigWorldProgressTitle;
		Model<BigWorldChallengeProgressModel>.Interface.OnBigWorldProgressExit -= OnOnBigWorldProgressExit;
	}

	private void OnRefreshComponent()
	{
		RefreshBigWordChangeTimer();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		bool isInBigWorld = Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld;
		SetCanvasGroupAlpha(isInBigWorld);
	}

	private void SetCanvasGroupAlpha(bool show)
	{
		_canvasGroup.alpha = (show ? 1f : 0f);
		_canvasGroup.interactable = show;
		_canvasGroup.blocksRaycasts = show;
	}

	public void UnInitialize()
	{
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

	private static string[] InitTimeStrings()
	{
		string[] array = new string[60];
		for (int i = 0; i < 60; i++)
		{
			array[i] = i.ToString("00");
		}
		return array;
	}

	private int UpdateTimeDisplay(float remaining)
	{
		int num = Mathf.Max(Mathf.FloorToInt(remaining), 0);
		int a = num / 60;
		int num2 = num % 60;
		textTimemin.text = s_timeStrings[Mathf.Min(a, 59)];
		textTimesec.text = s_timeStrings[num2];
		return num;
	}

	private void RefreshBigWordChangeTimer()
	{
		BigWordTimeDate bigWordTimeDateEventData = Model<BigWorldChallengeProgressModel>.Interface.BigWordTimeDateEventData;
		if (bigWordTimeDateEventData == null || !Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld)
		{
			return;
		}
		if (bigWordTimeDateEventData._Type == ACT.Event.EventType.start)
		{
			timerShowDone = false;
			_isCountDownLoopPlaying = false;
			UpdateTimeDisplay(bigWordTimeDateEventData._remaining);
			TimebetterAnimation.GetSequence("Show").OnComplete((AnimationBuilder act) =>
			{
				float num4 = Model<BigWorldChallengeProgressModel>.Interface.BigWordTimeDateEventData?._remaining ?? 0f;
				if (num4 > 0f && Mathf.FloorToInt(num4) <= 10 && !_isCountDownLoopPlaying)
				{
					TimebetterAnimation.GetSequence("CountDownLoop").SetLoops(-1).Play();
					_isCountDownLoopPlaying = true;
				}
				soundSec = 11;
				timerShowDone = true;
			}).Play();
		}
		else if (bigWordTimeDateEventData._Type == ACT.Event.EventType.tick)
		{
			int num = UpdateTimeDisplay(bigWordTimeDateEventData._remaining);
			int num2 = num / 60;
			int num3 = num % 60;
			if (num2 == 0 && num3 <= 10 && timerShowDone && !_isCountDownLoopPlaying)
			{
				TimebetterAnimation.GetSequence("CountDownLoop").SetLoops(-1).Play();
				_isCountDownLoopPlaying = true;
			}
			if (num2 == 0 && num3 < soundSec)
			{
				soundSec = num3;
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/CountDown");
			}
			if (bigWordTimeDateEventData._remaining <= 0f)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeOvertime, null);
			}
			else
			{
				Model<BattleMainModel>.Interface.SetTaskTipState(BattleMainModel.TaskTipDisableSourceEnum.BigWorld, value: false);
			}
		}
		else
		{
			TimebetterAnimation.GetSequence("Hide").Play();
		}
	}

	private void OnRefreshTextProgressSubTask()
	{
		BigWordProgressData bigWordProgressEventData_Progress = Model<BigWorldChallengeProgressModel>.Interface.BigWordProgressEventData_Progress;
		if (bigWordProgressEventData_Progress == null)
		{
			return;
		}
		List<string> values = bigWordProgressEventData_Progress.values;
		if (values != null && values.Count > 0)
		{
			ICollection<IVariable> values2 = TextprogressSubTask.StringReference.Values;
			if (values2.Count > 0)
			{
				for (int i = 0; i < values2.Count; i++)
				{
					TextprogressSubTask.StringReference.GetVariable<string>(i.ToString()).Value = bigWordProgressEventData_Progress.values[i];
				}
			}
		}
		else
		{
			TextprogressSubTask.StringReference.GetVariable<string>("0").Value = bigWordProgressEventData_Progress.value;
		}
	}

	private void OnRefreshTextProgressTitle()
	{
		BigWordProgressData bigWordProgressEventData_Title = Model<BigWorldChallengeProgressModel>.Interface.BigWordProgressEventData_Title;
		if (bigWordProgressEventData_Title == null)
		{
			return;
		}
		List<string> values = bigWordProgressEventData_Title.values;
		if (values != null && values.Count > 0)
		{
			ICollection<IVariable> values2 = TextprogressTitle.StringReference.Values;
			if (values2.Count > 0)
			{
				for (int i = 0; i < values2.Count; i++)
				{
					TextprogressTitle.StringReference.GetVariable<string>(i.ToString()).Value = bigWordProgressEventData_Title.values[i];
				}
			}
		}
		else
		{
			TextprogressTitle.StringReference.GetVariable<string>("0").Value = bigWordProgressEventData_Title.value;
		}
	}

	private void OnRefreshBigWorldProgressTitle()
	{
		BigWorldChallengeProgressModel bigWorldChallengeProgressModel = Model<BigWorldChallengeProgressModel>.Interface;
		int num = (bigWorldChallengeProgressModel.useString ? bigWorldChallengeProgressModel.stringList.Count : bigWorldChallengeProgressModel.eventList.Count);
		if (num == 0 || isToggle)
		{
			return;
		}
		isToggle = true;
		Model<BattleMainModel>.Interface.SetTaskTipState(BattleMainModel.TaskTipDisableSourceEnum.BigWorld, value: false);
		SetCanvasGroupAlpha(show: true);
		ProgressAnimation.gameObject.SetActive(value: true);
		ProgressAnimation.GetSequence("Show").Play();
		Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld = true;
		LocalizedString localizedString = (bigWorldChallengeProgressModel.useString ? bigWorldChallengeProgressModel.stringList[0] : bigWorldChallengeProgressModel.eventList[0].StringReference);
		TextprogressSubTask.gameObject.SetActive(num > 1);
		TextprogressTitle.StringReference = localizedString;
		if (localizedString.Values.Count > 0)
		{
			for (int i = 0; i < localizedString.Values.Count; i++)
			{
				TextprogressTitle.StringReference.GetVariable<string>(i.ToString()).Value = localizedString.GetVariable<string>(i.ToString()).Value;
			}
		}
		if (num <= 1)
		{
			return;
		}
		LocalizedString localizedString2 = (bigWorldChallengeProgressModel.useString ? bigWorldChallengeProgressModel.stringList[1] : bigWorldChallengeProgressModel.eventList[1].StringReference);
		TextprogressSubTask.StringReference = localizedString2;
		if (localizedString2.Values.Count > 0)
		{
			for (int j = 0; j < localizedString2.Values.Count; j++)
			{
				TextprogressSubTask.StringReference.GetVariable<string>(j.ToString()).Value = localizedString2.GetVariable<string>(j.ToString()).Value;
			}
		}
	}

	private void OnBigWorldFail(BaseEventContent obj)
	{
		OnChangeFinish();
	}

	private void OnBigWorldSuccess(BaseEventContent obj)
	{
		OnChangeFinish();
	}

	private void OnChangeFinish()
	{
		isToggle = false;
		_isCountDownLoopPlaying = false;
		Model<BigWorldChallengeProgressModel>.Interface.isInBigWorld = false;
		ProgressAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			ProgressAnimation.gameObject.SetActive(value: false);
			Model<BattleMainModel>.Interface.SetTaskTipState(BattleMainModel.TaskTipDisableSourceEnum.BigWorld, value: true);
			Model<BattleMainTaskTipModelV2>.Interface.RefreshMission();
		}).Play();
		TimebetterAnimation.GetSequence("Hide").Play();
	}

	private void ChangeExit()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = OnConfirm,
			needPause = true,
			commonId = 994
		});
	}

	private void OnConfirm()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeExit, null);
	}
}
