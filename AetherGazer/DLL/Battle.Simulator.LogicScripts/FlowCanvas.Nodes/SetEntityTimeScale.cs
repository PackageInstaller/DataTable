using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体时间缩放", 0)]
[Category("Logic/Control")]
[Description("设置实体时间缩放(0 - 100)")]
public class SetEntityTimeScale : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int scale)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID.entityBlackboard.var.mEntityTimeScale = scale;
		}
	}
}
