using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除所有buff(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除所有buff")]
public class RemoveEntityAllBuff : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
		{
			for (int num = entityWithEntityID.entityBuff.mBuffID.Count - 1; num >= 0; num--)
			{
				BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, num);
			}
		}
	}
}
