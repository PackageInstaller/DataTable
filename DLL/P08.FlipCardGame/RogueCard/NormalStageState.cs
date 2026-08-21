namespace RogueCard;

public class NormalStageState : StageState
{
	public NormalStageState(bool isReadSave = false)
		: base(StageType.Normal)
	{
	}

	public override void Enter()
	{
		base.Enter();
		ChangeSubState(new InitStageState(this));
	}

	public override bool CheckStageVictory()
	{
		long targetScore = RogueCardGameMain.Instance.GetTargetScore();
		long num = RogueCardGameMain.Instance.GetCurrentScore();
		if (targetScore >= int.MaxValue)
		{
			return false;
		}
		if (targetScore < int.MaxValue && num >= int.MaxValue)
		{
			return true;
		}
		return num >= targetScore;
	}

	public override bool CheckStageFinish()
	{
		return false;
	}

	public override bool CheckStageFailure()
	{
		return RogueCardGameMain.Instance.GetLastTurn() <= 0;
	}
}
