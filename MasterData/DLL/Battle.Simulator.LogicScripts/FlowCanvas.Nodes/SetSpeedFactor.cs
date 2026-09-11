using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置速度因子", 0)]
[Category("Logic/Attribute")]
[Description("以指定速度移动AI到目标点 .....")]
[ExposeAsDefinition]
public class SetSpeedFactor : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int speedFactor)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
			entityWithEntityID.entityBlackboard.var.mSpeedFactor = new VFactor(speedFactor, 100L);
		}
	}
}
