using System;
using System.Text.RegularExpressions;
using UnityEngine;

public class CookingGameConst
{
	public enum GameType
	{
		Cutting = 1,
		Playing,
		Frying,
		Soup,
		Oven,
		Stir,
		PourSauce,
		Seasoning,
		Grind,
		NayFace,
		Ink,
		FireBall,
		Chop,
		Fry,
		InkNormal
	}

	public enum FryingGameStatus
	{
		INIT,
		PREPARE,
		WAIT_TO_DRAG_FOOD,
		COOKING,
		FLIP_FOOD,
		WAIT_TO_DRAG_SUCCESS_FOOD,
		END
	}

	public enum FryingFoodItemStatus
	{
		RAW,
		THREE_PERCENT,
		FIVE_PERCENT,
		TEN_PERCENT,
		CHARRED
	}

	public enum StirGameStatus
	{
		INIT,
		PLAYING,
		SUCCESS,
		END
	}

	public enum StirDialStatus
	{
		ZERO,
		LESS,
		PERFECT,
		MORE
	}

	public enum PourSauceGameStatus
	{
		INIT,
		WAIT_TO_CLICK_SAUCE,
		WAIT_TO_POUR_SAUCE,
		SUCCESS,
		END
	}

	public enum DodgeFireBallGameStatus
	{
		ENTER,
		INIT,
		PLAYING,
		SUCCESS,
		FAIL
	}

	public enum DogeFireBallInputType
	{
		UP,
		DOWN,
		LEFT,
		RIGHT
	}

	public enum DogeFireBallFoodStatus
	{
		NORMAL,
		COMPLETED,
		CHARRED
	}

	public enum DogFireBallTableStatus
	{
		NORMAL,
		BURN,
		WARM
	}

	public enum SliceMessilyGameStatus
	{
		INIT,
		WAIT_TO_CLICK,
		SLICE,
		SUCCESS,
		FAIL,
		END
	}

	public enum RollBeefGameStatus
	{
		INIT,
		WAIT_TO_ROLL,
		SUCCESS,
		END
	}

	[Serializable]
	public struct ProgressData
	{
		public string desc;

		public int currentProgress;

		public int totalProgress;

		public ProgressData(string desc, int currentProgress, int totalProgress)
		{
			if (desc.IsNotNullOrEmpty())
			{
				desc = Regex.Replace(desc, "[\\x00-\\x1F\\x7F]", "");
				string text = ((LuaHelper.CallFunction("GetTips", desc) != null) ? (LuaHelper.CallFunction("GetTips", desc)[0] as string) : null);
				this.desc = ((text != null) ? text : "");
				this.currentProgress = currentProgress;
				this.totalProgress = totalProgress;
			}
			else
			{
				this.desc = "";
				this.currentProgress = currentProgress;
				this.totalProgress = totalProgress;
			}
		}
	}

	[Serializable]
	public class GuideConfig<T>
	{
		public T guideType;

		public float delayTime;

		public GameObject go;

		public string guidTextKey = string.Empty;

		[HideInInspector]
		public float curTime;

		[HideInInspector]
		public bool isReady;

		[HideInInspector]
		public bool isPlaying;

		[HideInInspector]
		public string guidText = string.Empty;

		public void Reset()
		{
			curTime = 0f;
			isReady = false;
			isPlaying = false;
			guidText = string.Empty;
			SetGoActive(value: false);
		}

		public void UpdateTime(float deltaTime)
		{
			if (curTime < delayTime)
			{
				curTime += deltaTime;
			}
		}

		public void ResetTime()
		{
			curTime = 0f;
		}

		public bool TimeReady()
		{
			return curTime >= delayTime;
		}

		public void UpdateGuide()
		{
			if (isReady)
			{
				if (!isPlaying)
				{
					ShowGuide();
				}
			}
			else if (isPlaying)
			{
				HideGuide();
			}
		}

		public void ShowGuide()
		{
			isPlaying = true;
			SetGoActive(value: true);
			if ((bool)CookingGameManager.Instance)
			{
				string text = (guidText.IsNotNullOrEmpty() ? guidText : guidTextKey);
				CookingGameManager.Instance.ShowGuideText(flag: true, text);
			}
		}

		public void HideGuide()
		{
			isPlaying = false;
			SetGoActive(value: false);
			if ((bool)CookingGameManager.Instance)
			{
				CookingGameManager.Instance.ShowGuideText(flag: false, "");
			}
		}

		public void SetGoActive(bool value)
		{
			if (go != null)
			{
				go.SetActive(value);
			}
		}
	}

	public static string CONFIG_DATA_PATH = "CookingGame/configData";

	public static string STEP_PREFAB_PATH = "UIResources/UI_AB/Widget/System/Activity_SummerPub/CookingGame/gameSteps";

	public static string GetPrefabPath(GameType type)
	{
		return type switch
		{
			GameType.Cutting => STEP_PREFAB_PATH + "/stepsTemplate/CuttingGame/CuttingGameplayUI", 
			GameType.Playing => STEP_PREFAB_PATH + "/stepsTemplate/PlatingGame/PlatingGame", 
			GameType.Frying => STEP_PREFAB_PATH + "/stepsTemplate/FryingGame/FryingGame", 
			GameType.Soup => STEP_PREFAB_PATH + "/stepsTemplate/PourSoupGame/PourSoupMarkedUI", 
			GameType.Oven => STEP_PREFAB_PATH + "/stepsTemplate/BakeGame/BakeGameplayUI", 
			GameType.Stir => STEP_PREFAB_PATH + "/stepsTemplate/StirGame/StirGame", 
			GameType.PourSauce => STEP_PREFAB_PATH + "/stepsTemplate/PourSauceGame/PourSauceGame", 
			GameType.Seasoning => STEP_PREFAB_PATH + "/stepsTemplate/SeasoningGame/SeasoningGameplayUI", 
			GameType.Grind => STEP_PREFAB_PATH + "/stepsTemplate/GrindGame/GrindGame", 
			GameType.NayFace => STEP_PREFAB_PATH + "/stepsTemplate/NyaFacePopGame/NyaFacePopGame", 
			GameType.Ink => STEP_PREFAB_PATH + "/stepsTemplate/InkCoverPopGame/InkCoverPopGame", 
			GameType.FireBall => STEP_PREFAB_PATH + "/stepsTemplate/FireBallGame/FireBallGameplayUI", 
			GameType.Chop => STEP_PREFAB_PATH + "/stepsTemplate/ChopGame/ChopGameplayUI", 
			GameType.Fry => STEP_PREFAB_PATH + "/stepsTemplate/FryingGame/FryingGame", 
			GameType.InkNormal => STEP_PREFAB_PATH + "/stepsTemplate/InkCoverNormalGame/InkCoverNormalGame", 
			_ => "", 
		};
	}
}
