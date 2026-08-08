using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改普攻槽(后三位)", 0)]
[Category("Logic/Abilities")]
[Description("传入后三位\n布尔值为是否重置普攻段数")]
public class ModifyMeleeSlot : CallableActionNode<int, List<int>, bool>
{
	public override void Invoke(int simEntityID, List<int> melees, bool isResetMeleesIndex = true)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			entityWithEntityID.entityBlackboard.var.mMeleesSlots.Clear();
			SimVar eNTITY_CONFIG_ID = entityWithEntityID.ENTITY_CONFIG_ID;
			for (int i = 0; i < melees.Count; i++)
			{
				entityWithEntityID.entityBlackboard.var.mMeleesSlots.Add((int)eNTITY_CONFIG_ID * 1000 + melees[i]);
			}
			if (isResetMeleesIndex)
			{
				entityWithEntityID.entityBlackboard.var.meleeIndex = 0;
			}
		}
	}
}
