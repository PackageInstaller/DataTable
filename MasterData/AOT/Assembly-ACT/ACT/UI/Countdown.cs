using ACT.Event;
using ACT.Model;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class Countdown : MonoBehaviour, IBattleMainComponent
{
	public class CountdownTimeData : BaseEventContent
	{
		public float _remaining;
	}

	[Header("大世界挑战相关")]
	public TextMeshProUGUI textTimemin;

	public TextMeshProUGUI textTimesec;

	public BetterAnimation TimebetterAnimation;

	private int soundSec;

	private const int COUNTDOWN_LOOP_THRESHOLD = 10;

	private static readonly string[] s_timeStrings = InitTimeStrings();

	private bool isToggle;

	private CanvasGroup _canvasGroup;

	private bool timerShowDone;

	private bool _isCountDownLoopPlaying;

	private void Awake()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
	}

	private void OnEnable()
	{
		AddEventListener();
	}

	private void OnDisable()
	{
		RemoveEventListener();
	}

	public void AddEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.AddEventListener(ClientEvent.CountdownStart, OnCountdownStart);
		instance.AddEventListener(ClientEvent.CountdownStop, OnCountdownStop);
		instance.AddEventListener(ClientEvent.CountdownUpdate, OnCountdownUpdate);
	}

	public void RemoveEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.RemoveEventListener(ClientEvent.CountdownStart, OnCountdownStart);
		instance.RemoveEventListener(ClientEvent.CountdownStop, OnCountdownStop);
		instance.RemoveEventListener(ClientEvent.CountdownUpdate, OnCountdownUpdate);
	}

	private void SetCanvasGroupAlpha(bool show)
	{
		_canvasGroup.alpha = (show ? 1f : 0f);
		_canvasGroup.interactable = show;
		_canvasGroup.blocksRaycasts = show;
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		SetCanvasGroupAlpha(show: false);
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

	private void OnCountdownStart(BaseEventContent obj)
	{
		CountdownTimeData countdownTimeData = obj as CountdownTimeData;
		timerShowDone = false;
		_isCountDownLoopPlaying = false;
		UpdateTimeDisplay(countdownTimeData._remaining);
		SetCanvasGroupAlpha(show: true);
		TimebetterAnimation.GetSequence("Show").OnComplete((AnimationBuilder act) =>
		{
			float num = Model<BigWorldChallengeProgressModel>.Interface.BigWordTimeDateEventData?._remaining ?? 0f;
			if (num > 0f && Mathf.FloorToInt(num) <= 10 && !_isCountDownLoopPlaying)
			{
				TimebetterAnimation.GetSequence("CountDownLoop").SetLoops(-1).Play();
				_isCountDownLoopPlaying = true;
			}
			soundSec = 11;
			timerShowDone = true;
		}).Play();
	}

	private void OnCountdownStop(BaseEventContent obj)
	{
		_isCountDownLoopPlaying = false;
		TimebetterAnimation.GetSequence("Hide").Play();
	}

	private void OnCountdownUpdate(BaseEventContent obj)
	{
		CountdownTimeData countdownTimeData = obj as CountdownTimeData;
		int num = UpdateTimeDisplay(countdownTimeData._remaining);
		int num2 = num / 60;
		int num3 = num % 60;
		SetCanvasGroupAlpha(show: true);
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
	}
}
