using UnityEngine;
using UnityEngine.UI;

public class SpecialUICountDown : MonoBehaviour
{
	public Image imageCount;

	public Image imageSlider;

	public int countNumber;

	public float timeMax;

	public bool updateWithUnityTime;

	private int countCurrent;

	private float timeCurrent;

	private bool isCountState = true;

	public void Add()
	{
		if (!(imageCount == null))
		{
			countCurrent++;
			if (countNumber > 0)
			{
				imageCount.fillAmount = Mathf.Clamp01((float)countCurrent / (float)countNumber);
			}
			if (countCurrent >= countNumber)
			{
				isCountState = false;
				timeCurrent = timeMax;
				imageSlider.fillAmount = 1f;
			}
		}
	}

	private void Update()
	{
		if (isCountState)
		{
			if (!imageCount.enabled)
			{
				imageCount.enabled = true;
			}
			if (imageSlider.enabled)
			{
				imageSlider.enabled = false;
			}
		}
		else
		{
			if (imageCount.enabled)
			{
				imageCount.enabled = false;
			}
			if (!imageSlider.enabled)
			{
				imageSlider.enabled = true;
			}
		}
		if (!isCountState && updateWithUnityTime)
		{
			timeCurrent -= Time.deltaTime;
			if (timeMax > 0f)
			{
				imageSlider.fillAmount = Mathf.Clamp01(timeCurrent / timeMax);
			}
			if (timeCurrent <= 0f)
			{
				isCountState = true;
				countCurrent = 0;
				imageCount.fillAmount = 0f;
			}
		}
	}

	public void UpdateTime(float deltaTime)
	{
		timeCurrent -= deltaTime;
		if (timeMax > 0f)
		{
			imageSlider.fillAmount = Mathf.Clamp01(timeCurrent / timeMax);
		}
		if (timeCurrent <= 0f)
		{
			isCountState = true;
			countCurrent = 0;
			imageCount.fillAmount = 0f;
		}
	}

	public void Init(float maxTime, int maxCount, bool state)
	{
		countNumber = maxCount;
		timeMax = maxTime;
		isCountState = state;
		countCurrent = 0;
		timeCurrent = timeMax;
		if (state)
		{
			imageCount.enabled = true;
			imageSlider.enabled = false;
			imageCount.fillAmount = 0f;
		}
		else
		{
			imageCount.enabled = false;
			imageSlider.enabled = true;
			imageSlider.fillAmount = 1f;
		}
	}

	public void UpdateState(float curTime, int curCount, bool state)
	{
		isCountState = state;
		countCurrent = curCount;
		timeCurrent = curTime;
		if (state)
		{
			imageCount.enabled = true;
			imageSlider.enabled = false;
			if (countNumber > 0)
			{
				imageCount.fillAmount = Mathf.Clamp01((float)countCurrent / (float)countNumber);
			}
		}
		else
		{
			imageCount.enabled = false;
			imageSlider.enabled = true;
			if (timeMax > 0f)
			{
				imageSlider.fillAmount = Mathf.Clamp01(timeCurrent / timeMax);
			}
		}
	}
}
