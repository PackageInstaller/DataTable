using System;
using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class OvenStep : MainStepBase
{
	public bool isOven = true;

	public float increaseSpeed = 0.1f;

	public float decreaseSpeed = 0.1f;

	public float minTime = 2f;

	public float maxTime = 4f;

	public float clickCD = 0.5f;

	public int clickCount = 3;

	public float clickAdd = 0.1f;

	public Button heatBtn;

	public Button coldBtn;

	public Animator ovenAnim;

	private GameObject woodAnimGo;

	private GameObject iceAnimGo;

	private Transform woodParent;

	private Transform iceParent;

	private List<Animator> woodAnimList = new List<Animator>();

	private List<Animator> iceAnimList = new List<Animator>();

	private RectTransform sliderLight;

	private Image normalSlider;

	private Image heatSlider;

	private Image coldSlider;

	private ControllerEx temperatureController;

	private ControllerEx sliderController;

	private ControllerEx heatController;

	private ControllerEx coldController;

	private bool isGameStart;

	private float triggerInvokeTime;

	private float triggerTime;

	private bool isClicked;

	private float clickTime;

	private int nowClickCount;

	private float totalProgress;

	private bool isIncrease = true;

	private bool isOverheat;

	private bool isFinish;

	private int timer = -1;

	private Dictionary<string, List<string>> atmosphereAudioDict = new Dictionary<string, List<string>>
	{
		["oven"] = new List<string> { "minigame_activity_4_3_cook_oven", "minigame_activity_4_3_cook_oven_action_stop" },
		["pot"] = new List<string> { "minigame_activity_4_3_cook_boil02_loop", "minigame_activity_4_3_cook_boil02_loop_action_stop" }
	};

	private List<string> nowAtmosphereAudioList;

	private Dictionary<string, List<string>> startEndAudioDict = new Dictionary<string, List<string>>
	{
		["oven"] = new List<string> { "minigame_activity_4_3_cook_close", "minigame_activity_4_3_cook_open" },
		["pot"] = new List<string> { "minigame_activity_4_3_cook_pot01", "minigame_activity_4_3_cook_pot02" }
	};

	private List<string> nowStartEndAudioList;

	private void Start()
	{
		nowAtmosphereAudioList = (isOven ? atmosphereAudioDict["oven"] : atmosphereAudioDict["pot"]);
		nowStartEndAudioList = (isOven ? startEndAudioDict["oven"] : startEndAudioDict["pot"]);
		woodParent = base.transform.Find("panel/middle_adapt/firewoodBtn/woodList");
		iceParent = base.transform.Find("panel/middle_adapt/waterBtn/iceList");
		woodAnimGo = base.transform.Find("panel/middle_adapt/firewoodBtn/wood_move").gameObject;
		iceAnimGo = base.transform.Find("panel/middle_adapt/waterBtn/ice_move").gameObject;
		sliderLight = base.transform.Find("panel/cookProgress/bg/progressGreen/fx").GetComponent<RectTransform>();
		normalSlider = base.transform.Find("panel/cookProgress/bg/progressGreen/progressGreen").GetComponent<Image>();
		heatSlider = base.transform.Find("panel/cookProgress/bg/progressRed").GetComponent<Image>();
		coldSlider = base.transform.Find("panel/cookProgress/bg/progressBlue").GetComponent<Image>();
		temperatureController = base.gameObject.GetComponent<ControllerExCollection>().GetController("temperature");
		sliderController = base.transform.Find("panel/cookProgress").GetComponent<ControllerExCollection>().GetController("processColor");
		heatController = heatBtn.gameObject.GetComponent<ControllerExCollection>().GetController("status");
		coldController = coldBtn.gameObject.GetComponent<ControllerExCollection>().GetController("status");
		heatBtn.onClick.AddListener(delegate
		{
			OnChangeBtnClick(isOverheat: true);
		});
		coldBtn.onClick.AddListener(delegate
		{
			OnChangeBtnClick(isOverheat: false);
		});
		EnterAnimPlay();
	}

	private void EnterAnimPlay()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAtmosphereAudioList[0], useStream: false);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowStartEndAudioList[0], useStream: false);
		StartCoroutine(PlayAndWaitForCompletion(ovenAnim, "in", delegate
		{
			isGameStart = true;
		}));
	}

	private void ExitAnimPlay()
	{
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
			timer = -1;
			CookingGameManager.Instance.PlayStepPanelFinishAni();
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowStartEndAudioList[1], useStream: false);
			StartCoroutine(PlayAndWaitForCompletion(ovenAnim, "out", delegate
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAtmosphereAudioList[1], useStream: false);
				StepFinish();
			}));
		}, 0.7f, 1);
	}

	private IEnumerator PlayAndWaitForCompletion(Animator anim, string stateName, Action callback)
	{
		anim.Play(stateName, 0, 0f);
		yield return null;
		int layerIndex = 0;
		int targetHash = anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash;
		while (anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash != targetHash)
		{
			yield return null;
		}
		while (anim.GetCurrentAnimatorStateInfo(layerIndex).normalizedTime < 1f)
		{
			yield return null;
		}
		if (anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash == targetHash)
		{
			callback?.Invoke();
		}
	}

	private void Update()
	{
		if (!isGameStart || isFinish || (CookingGameManager.Instance != null && CookingGameManager.Instance.isPlayingPopStep))
		{
			return;
		}
		if (isIncrease)
		{
			triggerInvokeTime = ((triggerInvokeTime != 0f) ? triggerInvokeTime : UnityEngine.Random.Range(minTime, maxTime));
			triggerTime += Time.deltaTime;
			if (triggerTime >= triggerInvokeTime)
			{
				isIncrease = false;
				triggerTime = 0f;
				triggerInvokeTime = 0f;
				OnTriggger();
			}
		}
		ChangeProcess();
		if (isClicked)
		{
			clickTime += Time.deltaTime;
			if (clickTime >= clickCD)
			{
				isClicked = false;
				clickTime = 0f;
			}
		}
		ChangeBtnStatus();
	}

	private void OnChangeBtnClick(bool isOverheat)
	{
		if (isClicked || isIncrease)
		{
			return;
		}
		clickTime = 0f;
		triggerTime = 0f;
		if (!isIncrease && this.isOverheat != isOverheat)
		{
			isClicked = true;
			nowClickCount++;
			totalProgress += clickAdd;
			SetFillAmount(totalProgress);
			GetAnimPlay(isOverheat);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_click", useStream: false);
			if (nowClickCount >= clickCount)
			{
				isIncrease = true;
				nowClickCount = 0;
			}
		}
	}

	private void ChangeProcess()
	{
		totalProgress = (isIncrease ? (totalProgress += increaseSpeed * Time.deltaTime) : (totalProgress -= decreaseSpeed * Time.deltaTime));
		SetFillAmount(totalProgress);
		sliderLight.anchoredPosition = new Vector2(totalProgress * normalSlider.rectTransform.GetWidth(), 0f);
		if (isIncrease)
		{
			temperatureController.SetSelectedState("normal");
			sliderController.SetSelectedState("green");
		}
		else
		{
			temperatureController.SetSelectedState(isOverheat ? "hot" : "cold");
			sliderController.SetSelectedState(isOverheat ? "red" : "blue");
		}
		if (totalProgress >= 1f)
		{
			temperatureController.SetSelectedState("finish");
			sliderController.SetSelectedState("green");
			isGameStart = false;
			isFinish = true;
			CookingGameManager.Instance.UpdateProgress(GetProgress());
			CookingGameManager.Instance.AddStepSuccess(config.stepID);
			ExitAnimPlay();
		}
		else if (totalProgress <= 0f)
		{
			Restart();
		}
	}

	private void ChangeBtnStatus()
	{
		if (isIncrease)
		{
			heatController.SetSelectedState("normal");
			coldController.SetSelectedState("normal");
		}
		else if (isOverheat)
		{
			coldController.SetSelectedState("showAni");
		}
		else
		{
			heatController.SetSelectedState("showAni");
		}
	}

	private void OnTriggger()
	{
		isOverheat = UnityEngine.Random.Range(0f, 1f) >= 0.5f;
		string cueName = (isOverheat ? "minigame_activity_4_3_cook_hot" : "minigame_activity_4_3_cook_cold");
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", cueName, useStream: false);
	}

	private void GetAnimPlay(bool isWood)
	{
		Animator anim = null;
		List<Animator> list = (isWood ? woodAnimList : iceAnimList);
		string stateName = (isWood ? "wood_move" : "ice_move");
		foreach (Animator item in list)
		{
			if (!item.gameObject.activeSelf)
			{
				anim = item;
				break;
			}
		}
		if (anim == null)
		{
			GameObject gameObject = (isWood ? UnityEngine.Object.Instantiate(woodAnimGo, woodParent) : UnityEngine.Object.Instantiate(iceAnimGo, iceParent));
			gameObject.transform.SetAnchoredPosition(Vector2.zero);
			anim = gameObject.GetComponent<Animator>();
			list.Add(anim);
		}
		if ((bool)anim)
		{
			anim.gameObject.SetActive(value: true);
			StartCoroutine(PlayAndWaitForCompletion(anim, stateName, delegate
			{
				anim.gameObject.SetActive(value: false);
			}));
		}
	}

	private void Restart()
	{
		triggerInvokeTime = 0f;
		triggerTime = 0f;
		isClicked = false;
		nowClickCount = 0;
		clickTime = 0f;
		heatController.SetSelectedState("normal");
		coldController.SetSelectedState("normal");
		totalProgress = 0f;
		isIncrease = true;
		isOverheat = false;
		isFinish = false;
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		int currentProgress = (isFinish ? 1 : 0);
		return new CookingGameConst.ProgressData(config.stepDescription, currentProgress, 1);
	}

	public override float GetPopStepTriggerProgress()
	{
		return totalProgress;
	}

	public void SetFillAmount(float fillAmount)
	{
		normalSlider.fillAmount = fillAmount;
		heatSlider.fillAmount = fillAmount;
		coldSlider.fillAmount = fillAmount;
	}
}
