using System.Collections.Generic;
using Entitas;

[Sim]
[IgnoreClone]
public class EntityTrigger : IComponent
{
	public int mTriggerID;

	public bool mEnabled;

	public ProtoEntityData mTriggerData;

	public Dictionary<string, SimVariable> mBlackboard;

	public int mActiveFrameCount;
}
