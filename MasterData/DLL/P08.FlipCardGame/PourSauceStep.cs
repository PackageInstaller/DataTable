using System.Collections.Generic;

public class PourSauceStep : MainStepBase
{
	public enum GuideType
	{
		CLICK,
		DRAG
	}

	private PourSauceGameManager gameManager;

	public float thresholdDistance;

	public int totalCount;

	public float normalizeTimeForSuccessAnimCallback = 30f;

	public float imgKeepTime = 2f;

	public List<CookingGameConst.GuideConfig<GuideType>> guideConfigList = new List<CookingGameConst.GuideConfig<GuideType>>();

	public override void OnStepStart()
	{
		base.OnStepStart();
		gameManager = GetComponent<PourSauceGameManager>();
	}

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.curSuccessCount >= totalCount;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		if (gameManager == null)
		{
			gameManager = GetComponent<PourSauceGameManager>();
		}
		return new CookingGameConst.ProgressData(config.stepDescription, gameManager.curSuccessCount, totalCount);
	}
}
