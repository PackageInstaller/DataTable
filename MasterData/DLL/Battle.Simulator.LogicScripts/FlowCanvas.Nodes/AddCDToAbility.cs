using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]给一个技能添加CD(无论是否正在CD中)", 0)]
[Category("Logic/Attribute")]
[Description("直接修改CD当前已使用次数")]
[ExposeAsDefinition]
public class AddCDToAbility : CallableActionNode<int, int>
{
	public override void Invoke(int target, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null)
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.AddCD(entityWithEntityID, abilityID);
		}
	}
}
