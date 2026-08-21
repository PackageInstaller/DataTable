using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除受击", 0)]
[Category("Logic/Abilities")]
[Description("中断正在执行的ability")]
public class RemoveHitRecover : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError("Can't Find Enttiy " + entityID);
		}
		if (entityWithEntityID.hasEntityHitRecover)
		{
			entityWithEntityID.RemoveEntityHitRecover();
		}
	}
}
