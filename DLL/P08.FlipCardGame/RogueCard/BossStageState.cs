namespace RogueCard;

public class BossStageState : StageState
{
	public BossStageState(bool isReadSave = false)
		: base(StageType.Boss)
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
		if (num >= int.MaxValue)
		{
			return true;
		}
		return num >= targetScore;
	}

	public override bool CheckStageFinish()
	{
		return RogueCardGameMain.Instance.IsStageFinish();
	}

	public override bool CheckStageFailure()
	{
		return RogueCardGameMain.Instance.GetLastTurn() <= 0;
	}
}
