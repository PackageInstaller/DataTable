public class AssemblyGame : MainStepBase
{
	public AssemblyContainer dragCon;

	private bool isFinish;

	private int round;

	private void Start()
	{
		dragCon = GetComponentInChildren<AssemblyContainer>();
	}

	private void Update()
	{
		update_round();
		dofinishFood();
	}

	private void update_round()
	{
		if (dragCon.GetProcess() - 1 >= round)
		{
			round = dragCon.GetProcess() - 1;
			CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, round, dragCon.GetMaxProcess()));
		}
	}

	private void dofinishFood()
	{
		if (dragCon.GetIsCover() && !isFinish)
		{
			isFinish = true;
			StepFinish();
		}
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, dragCon.GetProcess(), dragCon.GetMaxProcess());
	}
}
