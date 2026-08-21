using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体目标", 0)]
[Category("Logic/Puppet")]
[Description("设置实体目标")]
public class SetTarget : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int targetID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
			entityWithEntityID.entityBlackboard.var.mAimTarget = targetID;
			entityWithEntityID[EntityVarName.ENTITY_AI_TARGET] = targetID;
		}
	}
}
