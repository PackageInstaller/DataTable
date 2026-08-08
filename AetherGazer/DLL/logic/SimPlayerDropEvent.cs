using System;

public class SimPlayerDropEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public readonly NetworkPlayerID PlayerID;

	public SimPlayerDropEvent(NetworkPlayerID playerID)
	{
		PlayerID = playerID;
	}

	public override void OnEnterPool()
	{
		throw new NotImplementedException();
	}

	public override void Release()
	{
		throw new NotImplementedException();
	}
}
