using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]强制修改技能使用次数", 0)]
[Category("Logic/Attribute")]
[Description("直接修改CD当前已使用次数,使用次数1为CD刷新,2为CD走一轮,3两轮类推")]
[ExposeAsDefinition]
public class SetAbilityCDWithOutTime : CallableActionNode<int, int, int>
{
	public override void Invoke(int target, int abilityID, int usedCount)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		if (CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			CDProcessor.SetCD(entityWithEntityID, abilityID, abilityCD.CD, usedCount);
			return;
		}
		CDProcessor.AddCD(entityWithEntityID, abilityID);
		if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
		{
			CDProcessor.SetCD(entityWithEntityID, abilityID, abilityCD.CD, usedCount);
		}
	}
}
