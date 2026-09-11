using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置受击槽", 0)]
[Category("Logic/Abilities")]
[Description("设置受击槽")]
public class SetHitRecoverSlots : CallableActionNode<int, int, int>
{
	public override void Invoke(int simEntityID, int index, int id)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			int count = entityWithEntityID.entityBlackboard.var.mHitRecoverSlots.Count;
			if (index >= 0 && index < count)
			{
				entityWithEntityID.entityBlackboard.var.mHitRecoverSlots[index] = id;
			}
			else
			{
				Debug.LogError($"【设置受击槽】index={index}越界，slots={count}");
			}
		}
	}
}
