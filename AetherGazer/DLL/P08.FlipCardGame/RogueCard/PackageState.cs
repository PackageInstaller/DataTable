namespace RogueCard;

public class PackageState : IState
{
	public void Enter()
	{
		RogueCardGameMain.Instance.EnterPackageState();
	}

	public void Update()
	{
	}

	public void Exit()
	{
		RogueCardGameMain.Instance.ExitPackageState();
	}

	public int GetIndex()
	{
		return 10;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
