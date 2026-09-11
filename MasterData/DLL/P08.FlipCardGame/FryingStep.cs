using System;
using System.Collections.Generic;
using UnityEngine;

public class FryingStep : MainStepBase
{
	[Serializable]
	public struct RateOfTemperatureRising
	{
		public float minSuccessTemperature;

		public float maxSuccessTemperature;

		public int successCount;

		public float risingRatePerSecond;
	}

	[Serializable]
	public struct transitionOfcookedFood
	{
		public Vector3 localPosition;

		public Vector3 localScale;
	}

	[Serializable]
	public struct FoodStatus
	{
		public CookingGameConst.FryingFoodItemStatus status;

		public Sprite frontSprite;

		public Sprite backSprite;
	}

	public enum GuideType
	{
		DRAG_RAW_FOOD,
		FLIP_FOOD,
		DRAG_COOKED_FOOD
	}

	[NonSerialized]
	public FryingGameManager gameManager;

	public Vector3 foodScale = Vector3.one;

	public float maxTemperature;

	[SerializeField]
	public List<RateOfTemperatureRising> rateOfTemperatureRisingList = new List<RateOfTemperatureRising>();

	public int markCountForSuccess;

	public int markCountForFail;

	public int markCountOfThreePercentStatus;

	public int markCountOfFivePercentStatus;

	public int foodCount;

	public float imgKeepTime = 2f;

	public List<FoodStatus> foodStatusList = new List<FoodStatus>();

	public List<CookingGameConst.GuideConfig<GuideType>> guideConfigList = new List<CookingGameConst.GuideConfig<GuideType>>();

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.curSuccessFoodCount >= foodCount;
	}

	public override void OnStepStart()
	{
		base.OnStepStart();
		gameManager = GetComponent<FryingGameManager>();
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		if (gameManager == null)
		{
			gameManager = GetComponent<FryingGameManager>();
		}
		return new CookingGameConst.ProgressData(config.stepDescription, gameManager.curSuccessFoodCount, foodCount);
	}
}
