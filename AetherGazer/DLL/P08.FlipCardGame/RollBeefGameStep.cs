using System;
using System.Collections.Generic;

public class RollBeefGameStep : MainStepBase
{
	public enum GuideType
	{
		DRAG
	}

	[NonSerialized]
	public RollBeefGameManager gameManager;

	public float thresholdDistance;

	public int totalCount;

	public float normalizeTimeForSuccessAnimCallback = 30f;

	public float imgKeepTime = 1f;

	public List<CookingGameConst.GuideConfig<GuideType>> guideConfigList = new List<CookingGameConst.GuideConfig<GuideType>>();

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.curSuccessCount >= totalCount;
	}

	public override void OnStepStart()
	{
		base.OnStepStart();
		gameManager = GetComponent<RollBeefGameManager>();
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		if (gameManager == null)
		{
			gameManager = GetComponent<RollBeefGameManager>();
		}
		return new CookingGameConst.ProgressData(config.stepDescription, gameManager.curSuccessCount, totalCount);
	}
}
