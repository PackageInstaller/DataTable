using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]强制修改CD时间", 0)]
[Category("Logic/Attribute")]
[Description("直接修改CD当前时间")]
[ExposeAsDefinition]
public class SetAbilityCDWithOutUseCount : CallableActionNode<int, int, int>
{
	public override void Invoke(int target, int abilityID, int cd)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		if (CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			CDProcessor.SetCD(entityWithEntityID, abilityID, cd, abilityCD.UsedCount);
			return;
		}
		CDProcessor.AddCD(entityWithEntityID, abilityID);
		if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
		{
			CDProcessor.SetCD(entityWithEntityID, abilityID, cd, abilityCD.UsedCount);
		}
	}
}
