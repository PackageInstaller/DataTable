using System;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CountDownComponent : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI _minuteText;

	[SerializeField]
	private TextMeshProUGUI _semicolonText;

	[SerializeField]
	private TextMeshProUGUI _secondText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const int soundSec = 11;

	private bool timerShowDone;

	public void StartCountDown(int remainingTime)
	{
		timerShowDone = false;
		int min = Convert.ToInt32(remainingTime) / 60;
		int sec = Convert.ToInt32(remainingTime) % 60;
		_minuteText.SetText("{0:00}", min);
		_secondText.SetText("{0:00}", sec);
		_minuteText.color = Color.white;
		_secondText.color = Color.white;
		_semicolonText.color = Color.white;
		_betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder act) =>
		{
			if (min == 0 && sec <= 12)
			{
				_betterAnimation.GetSequence("CountDownLoop").SetLoops(-1).Play();
			}
			timerShowDone = true;
		}).Play();
	}

	public void UpdateCountDown(int remainingTime)
	{
		int num = Convert.ToInt32(remainingTime) / 60;
		int num2 = Convert.ToInt32(remainingTime) % 60;
		_minuteText.SetText("{0:00}", num);
		_secondText.SetText("{0:00}", num2);
		if (num == 0 && num2 == 10 && timerShowDone)
		{
			_betterAnimation.GetSequence("CountDownLoop").SetLoops(-1).Play();
		}
		if (num == 0 && num2 < 11)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/SFX/Interact/CountDown");
		}
		if (remainingTime <= 0)
		{
			StopCountDown();
		}
	}

	public void StopCountDown()
	{
		_betterAnimation.GetSequence("Hide").Play();
	}
}
