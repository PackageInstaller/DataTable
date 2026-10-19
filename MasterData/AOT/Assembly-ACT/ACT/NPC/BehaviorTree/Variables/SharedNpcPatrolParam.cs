using System;
using BehaviorDesigner.Runtime;

namespace ACT.NPC.BehaviorTree.Variables;

[Serializable]
public class SharedNpcPatrolParam : SharedVariable<NpcPatrolParam>
{
	public static implicit operator SharedNpcPatrolParam(NpcPatrolParam value)
	{
		return new SharedNpcPatrolParam
		{
			mValue = value
		};
	}
}
