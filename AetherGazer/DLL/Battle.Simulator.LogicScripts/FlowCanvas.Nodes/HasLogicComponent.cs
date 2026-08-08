using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断逻辑组件是否存在", 0)]
[Category("Logic/Attribute")]
[Description("判断逻辑组件是否存在")]
[ExposeAsDefinition]
public class HasLogicComponent : CallableFunctionNode<bool, int, int>
{
	public override bool Invoke(int id, int componentID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(id)?.HasComponent(componentID) ?? false;
	}
}
