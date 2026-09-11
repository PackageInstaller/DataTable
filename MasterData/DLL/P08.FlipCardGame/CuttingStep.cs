public class CuttingStep : MainStepBase
{
	public int requiredCuts = 3;

	public float perfectRange = 0.1f;

	private int currentCuts;

	public override bool IsStepCompleted()
	{
		return currentCuts >= requiredCuts;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, 0, 1);
	}

	private void Update()
	{
		_ = isActive;
	}
}
