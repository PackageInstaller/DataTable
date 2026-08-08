using UnityEngine;

public class StirGameManager : MonoBehaviour
{
	private StirStep config;

	public StirProgressItem progressItem;

	public StirDialItem dialItem;

	public StirPotItem potItem;

	private float velocityGuideTime;

	private float curSuccessAnimTime;

	private bool playingLoopAudio;

	public float currentProgress { get; private set; }

	public CookingGameConst.StirGameStatus gameStatus { get; private set; }

	public bool isProgressRising { get; private set; }

	private void Awake()
	{
		config = GetComponent<StirStep>();
		dialItem.Init(this, config);
		potItem.Init(this, config);
		progressItem.Init(this, config);
	}

	private void OnEnable()
	{
		Input.multiTouchEnabled = false;
		InitGame();
	}

	private void OnDisable()
	{
		Input.multiTouchEnabled = true;
		StopLoopAudio();
	}

	private void Update()
	{
		if (CookingGameManager.Instance != null && CookingGameManager.Instance.isPlayingPopStep)
		{
			if (playingLoopAudio)
			{
				StopLoopAudio();
			}
		}
		else if (gameStatus != CookingGameConst.StirGameStatus.END)
		{
			UpdateRender();
			UpdateLogic();
			UpdateStatus();
		}
	}

	public void UpdateRender()
	{
		switch (gameStatus)
		{
		case CookingGameConst.StirGameStatus.PLAYING:
			dialItem.UpdateRender();
			potItem.UpdateRender();
			UpdateProgressRender();
			UpdateGuide();
			break;
		case CookingGameConst.StirGameStatus.SUCCESS:
			UpdateSuccessRender();
			break;
		}
	}

	public void UpdateProgressRender()
	{
		progressItem.UpdateRender();
	}

	public void UpdateSuccessRender()
	{
		if (curSuccessAnimTime == 0f)
		{
			potItem.PlaySuccessAnim();
		}
	}

	public void UpdateLogic()
	{
		switch (gameStatus)
		{
		case CookingGameConst.StirGameStatus.PLAYING:
			potItem.UpdateLogic();
			dialItem.UpdateLogic();
			UpdateProgressLogic();
			break;
		case CookingGameConst.StirGameStatus.SUCCESS:
			curSuccessAnimTime += Time.deltaTime;
			break;
		}
	}

	public void UpdateProgressLogic()
	{
		if (dialItem.IsPointerInQteZone())
		{
			currentProgress += config.numOfProgressRising * Time.deltaTime;
			isProgressRising = true;
		}
		else
		{
			isProgressRising = false;
		}
	}

	public float GetCurPotVelocity()
	{
		return potItem.curVelocity;
	}

	public float GetCurDialVelocity()
	{
		return dialItem.curVelocity;
	}

	public CookingGameConst.StirDialStatus GetDialStatus()
	{
		return dialItem.status;
	}

	public float GetCurProgress()
	{
		return currentProgress;
	}

	public void UpdateStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.StirGameStatus.INIT:
			StartGame();
			break;
		case CookingGameConst.StirGameStatus.PLAYING:
			if (currentProgress >= config.maxNumOfProgression)
			{
				SwitchToSuccessStatus();
			}
			break;
		case CookingGameConst.StirGameStatus.SUCCESS:
			if (curSuccessAnimTime >= config.successAnimDurationTime)
			{
				EndGame();
			}
			break;
		}
	}

	public void StartGame()
	{
		gameStatus = CookingGameConst.StirGameStatus.PLAYING;
		currentProgress = 0f;
		isProgressRising = false;
	}

	public void EndGame()
	{
		gameStatus = CookingGameConst.StirGameStatus.END;
		config.StepFinish();
	}

	public void InitGame()
	{
		gameStatus = CookingGameConst.StirGameStatus.INIT;
		potItem.InitGame();
		dialItem.InitGame();
		progressItem.InitGame();
		InitGuide();
		if (config.needBoilLoopAudio && !playingLoopAudio)
		{
			playingLoopAudio = true;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_boil01_loop", useStream: false);
		}
	}

	public void SwitchToSuccessStatus()
	{
		gameStatus = CookingGameConst.StirGameStatus.SUCCESS;
		curSuccessAnimTime = 0f;
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.PlayStepPanelFinishAni();
		}
		dialItem.SwitchToSuccessStatus();
		potItem.SwitchToSuccessStatus();
		StopLoopAudio();
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
		}
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.UpdateProgress(config.GetProgress());
		}
	}

	private void InitGuide()
	{
		foreach (CookingGameConst.GuideConfig<StirStep.GuideType> guideConfig in config.guideConfigList)
		{
			guideConfig.Reset();
		}
	}

	private void UpdateGuide()
	{
		foreach (CookingGameConst.GuideConfig<StirStep.GuideType> guideConfig in config.guideConfigList)
		{
			switch (guideConfig.guideType)
			{
			case StirStep.GuideType.idle:
				guideConfig.isReady = dialItem.status == CookingGameConst.StirDialStatus.ZERO;
				guideConfig.UpdateGuide();
				break;
			case StirStep.GuideType.velocity:
			{
				bool isReady = false;
				if (dialItem.status != CookingGameConst.StirDialStatus.ZERO && dialItem.status == CookingGameConst.StirDialStatus.LESS)
				{
					guideConfig.UpdateTime(Time.deltaTime);
					isReady = guideConfig.TimeReady();
				}
				guideConfig.isReady = isReady;
				guideConfig.UpdateGuide();
				break;
			}
			case StirStep.GuideType.overload:
			{
				bool isReady = false;
				if (dialItem.status != CookingGameConst.StirDialStatus.ZERO && dialItem.status == CookingGameConst.StirDialStatus.MORE)
				{
					guideConfig.UpdateTime(Time.deltaTime);
					isReady = guideConfig.TimeReady();
				}
				guideConfig.isReady = isReady;
				guideConfig.UpdateGuide();
				break;
			}
			}
		}
	}

	private void StopLoopAudio()
	{
		if (playingLoopAudio)
		{
			playingLoopAudio = false;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_boil01_loop_action_stop", useStream: false);
			potItem.StopLoopAudio();
		}
	}
}
