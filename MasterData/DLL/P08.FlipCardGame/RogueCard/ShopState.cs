namespace RogueCard;

public class ShopState : IState
{
	public ShopState(bool isRefresh = true)
	{
		RogueCardGameMain.Instance.InitShopState(isRefresh);
	}

	public void Enter()
	{
		RogueCardGameMain.Instance.EnterShopState();
	}

	public void Update()
	{
		if (RogueCardGameMain.Instance.PlayerExitedShop())
		{
			RogueCardGameMain.Instance.ChangeMainState(new SelectStageState());
		}
	}

	public void Exit()
	{
	}

	public int GetIndex()
	{
		return 9;
	}

	public bool GetIsEnterAni()
	{
		return false;
	}
}
