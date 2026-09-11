using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断是否是硬直状态", 0)]
[Category("Logic/Attribute")]
[Description("判断是否是硬直状态.....")]
[ExposeAsDefinition]
public class IsAIHitRecovering : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(entityID)?.hasEntityHitRecover ?? false;
	}
}
