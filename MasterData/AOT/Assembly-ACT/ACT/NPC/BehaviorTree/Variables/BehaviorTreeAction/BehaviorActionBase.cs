using System;
using Bamboo.ECS;

namespace ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;

[Serializable]
public abstract class BehaviorActionBase
{
	public abstract void Execute(Entity owner);
}
