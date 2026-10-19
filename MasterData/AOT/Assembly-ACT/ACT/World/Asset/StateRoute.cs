using System;

namespace ACT.World.Asset;

[Serializable]
public class StateRoute : IDataToBake
{
	public int stateId;

	public float delayTime;

	public Route route;
}
