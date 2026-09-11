using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]获取CD时间", 0)]
[Category("Logic/Attribute")]
[Description("设置CD时间")]
[ExposeAsDefinition]
public class GetAbilityCD : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int target, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		if (entityWithEntityID.hasEntityCD && CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			return abilityCD.CD;
		}
		return 0;
	}
}
