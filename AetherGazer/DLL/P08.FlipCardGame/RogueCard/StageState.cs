namespace RogueCard;

public abstract class StageState : StateWithSubstates
{
	protected StageType stageType;

	public StageState(StageType type)
	{
		stageType = type;
	}

	public override void Enter()
	{
		base.Enter();
		RogueCardGameMain.Instance.EnterStageState();
	}

	public override void Exit()
	{
		RogueCardGameMain.Instance.ExitStageState();
		base.Exit();
	}

	public abstract bool CheckStageVictory();

	public abstract bool CheckStageFinish();

	public abstract bool CheckStageFailure();

	public override int GetIndex()
	{
		if (GetCurrentSubState() != null)
		{
			return GetCurrentSubState().GetIndex();
		}
		return 3;
	}
}
