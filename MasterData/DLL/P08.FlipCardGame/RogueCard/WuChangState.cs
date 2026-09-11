namespace RogueCard;

public class WuChangState : IState
{
	public void Enter()
	{
		RogueCardGameMain.Instance.StartWuChangPhase();
	}

	public void Update()
	{
		if (RogueCardGameMain.Instance.WuChangPhaseCompleted())
		{
			RogueCardGameMain.Instance.ChangeMainState(new ShopState());
		}
	}

	public void Exit()
	{
		RogueCardGameMain.Instance.EndWuChangPhase();
	}

	public int GetIndex()
	{
		return 8;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
