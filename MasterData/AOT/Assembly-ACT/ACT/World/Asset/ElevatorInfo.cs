using System;

namespace ACT.World.Asset;

[Serializable]
public class ElevatorInfo : IDataToBake
{
	public Pos position;

	public float waitingTime;

	public float nextPathTime;
}
