using UnityEngine;

namespace RogueCard;

public class TurnSettleState : IState
{
	private readonly bool isReadSave;

	public bool isAni;

	public TurnSettleState(bool isReadSave = false)
	{
		this.isReadSave = isReadSave;
	}

	public void Enter()
	{
		Debug.Log("进入小关结算阶段");
		isAni = true;
		if (isReadSave)
		{
			RogueCardGameMain.Instance.EnterTurnSettleStateFromSave();
			return;
		}
		RogueCardGameMain.Instance.EnterTurnSettleState(delegate
		{
			isAni = false;
		});
	}

	public void Update()
	{
	}

	public void Exit()
	{
		RogueCardGameMain.Instance.ExitTurnSettleState();
	}

	public int GetIndex()
	{
		return 7;
	}

	public bool GetIsEnterAni()
	{
		return isAni;
	}
}
