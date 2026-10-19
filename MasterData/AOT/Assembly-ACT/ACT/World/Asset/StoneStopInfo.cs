using System;

namespace ACT.World.Asset;

[Serializable]
public class StoneStopInfo : IDataToBake
{
	public Pos position;

	public float waitingTime;

	public float nextPathTime;
}
