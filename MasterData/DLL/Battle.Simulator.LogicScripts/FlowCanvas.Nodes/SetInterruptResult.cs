using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置打断结果", 0)]
[Category("Logic/Abilities")]
[Description("修改计算打断出来的打断结果, EntityID为被打断者实体ID")]
public class SetInterruptResult : CallableActionNode<int, bool>
{
	public override void Invoke(int entityID, bool result)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID.entityBlackboard.var.mIsBeInterrupt = result;
		}
	}
}
