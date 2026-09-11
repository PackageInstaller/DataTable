namespace RogueCard;

public class SettleState : IState
{
	public void Enter()
	{
		RogueCardGameMain.Instance.FinishStage();
	}

	public void Exit()
	{
	}

	public void Update()
	{
	}

	public int GetIndex()
	{
		return 11;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
