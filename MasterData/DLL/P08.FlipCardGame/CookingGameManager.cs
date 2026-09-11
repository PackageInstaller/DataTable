using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CookingGameManager : MonoBehaviour
{
	[Serializable]
	public class StepTimeData
	{
		public string stepID;

		public int successCount;

		public int failureCount;

		public float timeSpent;
	}

	[Serializable]
	public class GameTimeData
	{
		public float totalTime;

		public List<StepTimeData> steps = new List<StepTimeData>();
	}

	private GameObject curObj;

	public int curIndex;

	private List<GameObject> viewGoList = new List<GameObject>();

	public string stepDataName;

	public bool isBattle;

	public CookingGameUI cookingGameUI;

	public MainStepBase currentStep;

	public string currentStepID;

	public PopStepBase currentPopStep;

	public bool isPlayingPopStep;

	public string nextStepID;

	[SerializeField]
	public Transform gameContainer;

	[SerializeField]
	public Transform popGameContainer;

	[SerializeField]
	private StepConfigData stepConfigData;

	public GameTimeData gameTimeData;

	private DateTime gameStartTime;

	private DateTime currentStepStartTime;

	private DateTime currentPopStepStartTime;

	public List<MainStepConfig> stepSequence = new List<MainStepConfig>();

	public static CookingGameManager Instance { get; private set; }

	public GameTimeData GetGameTimeData()
	{
		return gameTimeData;
	}

	private void ApplyConfig()
	{
		currentStepStartTime = default(DateTime);
		currentPopStepStartTime = gameStartTime;
		if (stepDataName != "")
		{
			stepConfigData = AssetManager.Load<StepConfigData>(CookingGameConst.CONFIG_DATA_PATH + "/" + stepDataName + ".asset");
		}
		if (!(stepConfigData != null))
		{
			return;
		}
		while (gameContainer.childCount > 0)
		{
			UnityEngine.Object.DestroyImmediate(gameContainer.GetChild(0).gameObject);
		}
		while (popGameContainer.childCount > 0)
		{
			UnityEngine.Object.DestroyImmediate(popGameContainer.GetChild(0).gameObject);
		}
		stepSequence = stepConfigData.stepSequence;
		viewGoList.Clear();
		foreach (MainStepConfig item in stepSequence)
		{
			GameObject prefab = stepConfigData.GetPrefab(item.stepID);
			if (prefab != null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(prefab, gameContainer);
				item.obj = prefab;
				gameObject.SetActive(value: false);
				viewGoList.Add(gameObject);
			}
		}
	}

	private void UpdateCurrentStep()
	{
		MainStepConfig mainStepConfig = stepSequence.Find((MainStepConfig item) => item.stepID == currentStepID);
		if (mainStepConfig != null)
		{
			currentStep = mainStepConfig.obj.GetComponent<MainStepBase>();
			currentStep.Init(mainStepConfig);
			currentStep.OnStepStart();
		}
	}

	public void AddStepSuccess(string stepId)
	{
		StepTimeData stepTimeData = gameTimeData.steps.Find((StepTimeData s) => s.stepID == stepId);
		if (stepTimeData != null)
		{
			stepTimeData.successCount++;
		}
	}

	public void AddStepFailure(string stepId)
	{
		StepTimeData stepTimeData = gameTimeData.steps.Find((StepTimeData s) => s.stepID == stepId);
		if (stepTimeData != null)
		{
			stepTimeData.failureCount++;
		}
	}

	public void ShowGuideText(bool flag, string text)
	{
		cookingGameUI.ShowGuideText(flag, text);
	}

	private void Awake()
	{
		Instance = this;
	}

	private void Start()
	{
	}

	private void Update()
	{
		if (currentStepStartTime != default(DateTime) && !isPlayingPopStep)
		{
			StepTimeData stepTimeData = gameTimeData.steps.Find((StepTimeData s) => s.stepID == currentStepID);
			if (stepTimeData != null)
			{
				stepTimeData.timeSpent = (float)(DateTime.UtcNow - currentStepStartTime).TotalSeconds;
			}
		}
		if (currentPopStepStartTime != default(DateTime) && isPlayingPopStep)
		{
			StepTimeData stepTimeData2 = gameTimeData.steps.Find((StepTimeData s) => s.stepID == currentPopStep.config.stepID);
			if (stepTimeData2 != null)
			{
				stepTimeData2.timeSpent = (float)(DateTime.UtcNow - currentPopStepStartTime).TotalSeconds;
			}
		}
		gameTimeData.totalTime = (float)(DateTime.UtcNow - gameStartTime).TotalSeconds;
	}

	public void LoadGame(string name, bool flag)
	{
		stepDataName = name;
		isBattle = flag;
		ApplyConfig();
		ShowGuideText(flag: false, "");
		curIndex = 0;
		currentStepID = stepSequence[curIndex].stepID;
		curObj = viewGoList[curIndex];
		curObj.SetActive(value: true);
		gameTimeData = new GameTimeData();
		gameStartTime = DateTime.UtcNow;
		gameTimeData.steps = stepSequence.Select((MainStepConfig s) => new StepTimeData
		{
			stepID = s.stepID,
			successCount = 0,
			failureCount = 0,
			timeSpent = 0f
		}).ToList();
		UpdateStep();
		isPlayingPopStep = false;
		cookingGameUI.RefreshInfo();
	}

	private void UpdateStep()
	{
		currentStepStartTime = DateTime.UtcNow;
		UpdateCurrentStep();
		cookingGameUI.SetStepInfo(currentStep.Config.stepName, curIndex + 1, stepSequence.Count);
		cookingGameUI.SetStepProgress(currentStep.GetProgress());
	}

	public void NextStep()
	{
		SetStepFinishDesc(currentStep.stepFinishKey);
		MainStepConfig mainStepConfig = stepSequence.Find((MainStepConfig item) => item.stepID == currentStep.Config.nextStepID);
		nextStepID = mainStepConfig?.stepID;
		cookingGameUI.OnStepFinish(mainStepConfig == null);
		ShowGuideText(flag: false, "");
	}

	public void SetStepFinishDesc(string textKey)
	{
		cookingGameUI.SetStepFinishText(textKey);
	}

	public void ShowNextStep()
	{
		if (curObj != null)
		{
			curObj.SetActive(value: false);
		}
		currentStep.OnStepEnd();
		currentStepID = nextStepID;
		curIndex++;
		curObj = viewGoList[curIndex];
		curObj.SetActive(value: true);
		UpdateStep();
	}

	public void UpdateProgress(CookingGameConst.ProgressData progressData)
	{
		cookingGameUI.SetStepProgress(progressData);
	}

	public void PlayStepPanelFinishAni()
	{
		if (!cookingGameUI.smallComplete.activeInHierarchy)
		{
			cookingGameUI.stepAnim.Play("finish", 0, 0f);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold02", useStream: false);
		}
	}

	public string GetDishId()
	{
		return stepDataName;
	}

	public bool IsBattle()
	{
		return isBattle;
	}

	public void FinishCook()
	{
		curIndex = 0;
		curObj.SetActive(value: false);
		curObj = null;
	}

	public void StartPopStep(PopStepConfig config)
	{
		currentPopStepStartTime = DateTime.UtcNow;
		currentPopStep = config.obj.GetComponent<PopStepBase>();
		gameTimeData.steps.Add(new StepTimeData
		{
			stepID = currentPopStep.config.stepID,
			successCount = 0,
			failureCount = 0,
			timeSpent = 0f
		});
		isPlayingPopStep = true;
	}

	public void EndPopStep()
	{
		currentPopStep = null;
		isPlayingPopStep = false;
	}
}
