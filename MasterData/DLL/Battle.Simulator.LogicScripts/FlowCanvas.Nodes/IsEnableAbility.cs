using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能是否开启", 0)]
[Category("Logic/Abilities")]
[Description("启用或关闭技能")]
public class IsEnableAbility : CallableFunctionNode<bool, int, int>
{
	public override bool Invoke(int simEntityID, int id)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null)
		{
			return AttributeProcessor.IsEnableAbility(entityWithEntityID, id);
		}
		return false;
	}
}
