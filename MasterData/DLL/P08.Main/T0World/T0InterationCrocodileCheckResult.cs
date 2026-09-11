using System;

namespace T0World;

[Serializable]
public class T0InterationCrocodileCheckResult : T0InterationBaseData
{
	public T0CrocodileGameStateEnum checkGameState = T0CrocodileGameStateEnum.win;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private bool CheckIsMeet()
	{
		return T0CrocodileGame.crocodileGame.context.gameState == checkGameState;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (CheckIsMeet())
		{
			base.IsFinish = true;
		}
	}
}
