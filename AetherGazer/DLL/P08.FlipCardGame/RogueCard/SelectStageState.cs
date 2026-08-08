namespace RogueCard;

public class SelectStageState : IState
{
	public SelectStageState(bool isReadSave = false)
	{
	}

	public void Enter()
	{
		RogueCardGameMain.Instance.EnterSelectStageState();
	}

	public void Update()
	{
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 2;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
