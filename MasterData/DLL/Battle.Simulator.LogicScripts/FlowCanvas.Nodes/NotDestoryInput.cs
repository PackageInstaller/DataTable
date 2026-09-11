using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("将输入设置为不清除", 0)]
[Category("Logic/Abilities")]
[Description("将输入设置为不清除")]
[ExposeAsDefinition]
public class NotDestoryInput : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionManualInput)
		{
			entityWithEntityID.entityActionManualInput.mCanDestroy = false;
		}
	}
}
