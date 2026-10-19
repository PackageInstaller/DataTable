using System;

namespace ACT.World.Asset;

[Serializable]
public class LinkagesObjects : IDataToBake
{
	public StateWorldUid Object;

	public bool initSet;

	public bool excludeState;

	public int[] excludeStateId;

	public bool startInform;

	public int setStartState;

	public bool finishInform;

	public int setEndState;
}
