using System;

namespace ACT.World.Asset;

[Serializable]
public class InteractWorldRuleState : IDataToBake
{
	public int worldId;

	public int stateWorldUid;

	public int stateId;

	public bool toClean;

	public void Bake(object baker)
	{
	}
}
