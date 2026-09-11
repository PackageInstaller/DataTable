using UnityEngine;
using UnityEngine.UI;

public class SeasoningStep : MainStepBase
{
	public int totalTimes = 10;

	public float doubleClickTime = 0.5f;

	public float clickCD = 5f;

	public float guideTime = 8f;

	public string guideKey;

	public float imgKeepTime = 2f;

	public GameObject guideGo;

	public Button clickBtn;

	private Animator shakeAnim;

	private GameObject seasonEffect;

	private int clickTimes;

	private float lastClickTime;

	private float operateTimer;

	private bool isFinish;

	private bool isDoubleClicked;

	private float clickCdTime;

	private bool isGuide;

	private int timer = -1;

	private int finishTimer = -1;

	private void Start()
	{
		shakeAnim = clickBtn.GetComponent<Animator>();
		seasonEffect = clickBtn.transform.Find("shake/icon/fx").gameObject;
		clickBtn.onClick.AddListener(delegate
		{
			OnClick();
		});
		GameGuide(flag: true);
	}

	private void Update()
	{
		if (isFinish)
		{
			return;
		}
		operateTimer += Time.deltaTime;
		if (operateTimer >= guideTime)
		{
			GameGuide(flag: true);
			operateTimer = 0f;
		}
		if (isDoubleClicked)
		{
			clickCdTime += Time.deltaTime;
			if (clickCdTime >= clickCD)
			{
				isDoubleClicked = false;
				clickCdTime = 0f;
			}
		}
	}

	private void OnClick()
	{
		if (isDoubleClicked)
		{
			return;
		}
		operateTimer = 0f;
		if (lastClickTime == 0f)
		{
			lastClickTime = Time.time;
			return;
		}
		float time = Time.time;
		if (time - lastClickTime < doubleClickTime)
		{
			clickTimes++;
			isDoubleClicked = true;
			if (isGuide)
			{
				GameGuide(flag: false);
			}
			if (shakeAnim != null)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sprinkle01", useStream: false);
				shakeAnim.Play("Shake", 0, 0f);
				seasonEffect.SetActive(value: true);
				timer = FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					FuncTimerManager.inst.RemoveFuncTimer(timer);
					timer = -1;
					seasonEffect.SetActive(value: false);
				}, 1.6f, 1);
			}
			if (clickTimes >= totalTimes)
			{
				isFinish = true;
				CookingGameManager.Instance.AddStepSuccess(config.stepID);
				CookingGameManager.Instance.PlayStepPanelFinishAni();
				CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, 1, 1));
				finishTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					FuncTimerManager.inst.RemoveFuncTimer(timer);
					finishTimer = -1;
					StepFinish();
				}, imgKeepTime, 1);
			}
		}
		lastClickTime = time;
	}

	private void GameGuide(bool flag)
	{
		isGuide = flag;
		guideGo.SetActive(flag);
		CookingGameManager.Instance.ShowGuideText(flag, guideKey);
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, 0, 1);
	}
}
