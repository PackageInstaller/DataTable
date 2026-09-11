using System;
using System.Collections.Generic;

public class SliceMessilyGameStep : MainStepBase
{
	public enum GuideType
	{
		PROGRESS,
		PROGRESS_COUNT_DOWN
	}

	[NonSerialized]
	private SliceMessilyGameManager gameManager;

	public float maxProgress;

	public float risingProgressPerUnit;

	public float distanceUnit;

	public int countDownTime;

	public bool needHitAnim;

	public float imgKeepTime = 2f;

	public List<CookingGameConst.GuideConfig<GuideType>> guideConfigList = new List<CookingGameConst.GuideConfig<GuideType>>();

	private void Awake()
	{
		gameManager = GetComponent<SliceMessilyGameManager>();
	}

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.curProgress >= maxProgress;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		int currentProgress = (IsStepCompleted() ? 1 : 0);
		return new CookingGameConst.ProgressData(config.stepDescription, currentProgress, 1);
	}

	public override float GetPopStepTriggerProgress()
	{
		return gameManager.curProgress / maxProgress;
	}
}
