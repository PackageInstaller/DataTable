using System;

namespace ACT.World.Asset;

[Serializable]
public class IncludeObject : IDataToBake
{
	public int inCurrentLayerState;

	public int notInCurrentLayerState;

	public int lockLayerState;

	public StateWorldUid linkObject;
}
