namespace RogueCard;

public class InitWaveState : IState
{
	public void Enter()
	{
		RogueCardGameMain.Instance.InitializeWaveData();
	}

	public void Update()
	{
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 1;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
