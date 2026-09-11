using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]强制修改CD时间及已使用次数", 0)]
[Category("Logic/Attribute")]
[Description("直接修改CD当前时间及已使用次数,使用次数1为CD刷新,2为CD走一轮,3两轮类推")]
[ExposeAsDefinition]
public class SetAbilityCD : CallableActionNode<int, int, int, int>
{
	public override void Invoke(int target, int abilityID, int cd, int usedCount)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
		CDProcessor.AddCD(entityWithEntityID, abilityID);
		if (entityWithEntityID != null && CDProcessor.GetCD(entityWithEntityID, abilityID, out var _))
		{
			CDProcessor.SetCD(entityWithEntityID, abilityID, cd, usedCount);
		}
	}
}
