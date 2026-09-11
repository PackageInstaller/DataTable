using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减当前技能CD(逻辑)(过时)", 0)]
[Category("Logic/Attribute")]
[Description("增减当前技能CD,注意该节点会增减CD为0的CD,例如国常立三技能使用后会附加0长度的CD,该节点导致 HERO-30748 的BUG")]
[ExposeAsDefinition]
public class ModifyAbilityCDWithOutUseCount : CallableActionNode<int, int, int, int>
{
	public override void Invoke(int target, int abilityID, int percent, int increment)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			int num = IntMath.Divide(abilityCD.CD * percent, 100) + increment;
			if (num > 0)
			{
				CDProcessor.SetCD(entityWithEntityID, abilityID, num, abilityCD.UsedCount);
			}
			else
			{
				CDProcessor.SetCD(entityWithEntityID, abilityID, 0, abilityCD.UsedCount);
			}
		}
	}
}
