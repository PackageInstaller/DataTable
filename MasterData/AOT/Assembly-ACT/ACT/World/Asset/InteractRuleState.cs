using System;

namespace ACT.World.Asset;

[Serializable]
public class InteractRuleState : IDataToBake
{
	public StateWorldUid stateWorldUid;

	public int stateId;
}
