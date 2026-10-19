using System;

namespace ACT.World.Asset;

[Serializable]
public class EndNodeLinkStateObj : IDataToBake
{
	public StateWorldUid targetInteractSwid;

	public int unInteractState;

	public int stateId;
}
