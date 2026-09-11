using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class FryingTemperatureItem : MonoBehaviour
{
	[NonSerialized]
	public FryingGameManager gameManager;

	[NonSerialized]
	public FryingStep config;

	public ControllerExCollection controllerEx;

	private ControllerEx statusController;

	public RectTransform temperatureRangTransform;

	public RectTransform successRangeTransform;

	public Image curTemperatureImg;

	private float curRisingRate;

	public float curTemperature;

	public float minSuccessTemperature { get; private set; }

	public float maxSuccessTemperature { get; private set; }

	public void Start()
	{
		statusController = controllerEx.GetController("status");
		UpdateRange();
	}

	public void InitStatus()
	{
		SetActive(value: true);
		Reset();
	}

	public void UpdateLogic()
	{
		RisingTemperature();
	}

	public void UpdateRisingRate()
	{
		foreach (FryingStep.RateOfTemperatureRising rateOfTemperatureRising in config.rateOfTemperatureRisingList)
		{
			if (rateOfTemperatureRising.successCount == gameManager.curSuccessMarkCount)
			{
				curRisingRate = rateOfTemperatureRising.risingRatePerSecond;
				break;
			}
		}
	}

	private void UpdateRange()
	{
		foreach (FryingStep.RateOfTemperatureRising rateOfTemperatureRising in config.rateOfTemperatureRisingList)
		{
			if (rateOfTemperatureRising.successCount == gameManager.curSuccessMarkCount)
			{
				maxSuccessTemperature = rateOfTemperatureRising.maxSuccessTemperature;
				minSuccessTemperature = rateOfTemperatureRising.minSuccessTemperature;
				float num = maxSuccessTemperature / config.maxTemperature;
				float num2 = minSuccessTemperature / config.maxTemperature;
				float height = temperatureRangTransform.rect.height;
				float num3 = height * num;
				float num4 = height * num2;
				float num5 = num3 - num4;
				Vector2 sizeDelta = successRangeTransform.sizeDelta;
				sizeDelta.y = num5;
				successRangeTransform.sizeDelta = sizeDelta;
				Vector3 localPosition = successRangeTransform.localPosition;
				localPosition.y = num4 + num5 / 2f - height / 2f;
				successRangeTransform.localPosition = localPosition;
				break;
			}
		}
	}

	public void RisingTemperature()
	{
		curTemperature += curRisingRate * Time.deltaTime;
	}

	public void UpdateRender()
	{
		RenderStatus();
		RenderTemperature();
	}

	public void RenderTemperature()
	{
		curTemperatureImg.fillAmount = curTemperature / config.maxTemperature;
	}

	public void RenderStatus()
	{
		statusController.SetSelectedState((curTemperature > maxSuccessTemperature) ? "red" : "normal");
	}

	public void SetActive(bool value)
	{
		base.gameObject.SetActive(value);
	}

	public void Reset()
	{
		curTemperature = 0f;
		UpdateRange();
		UpdateRisingRate();
	}

	public void OnFailMarkAdd()
	{
		Reset();
	}
}
