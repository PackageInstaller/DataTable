using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否暴击(pure)(已过时)", 0)]
[Category("Logic/Attribute")]
[Description("判断是否暴击")]
public class IsCritPure : PureFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		return IsCrit.IsCritMethod(base.parentNode.mSimContext.GetEntityWithEntityID(entityID));
	}
}
