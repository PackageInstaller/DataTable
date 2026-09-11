using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减当前技能CD时间及已使用次数", 0)]
[Category("Logic/Attribute")]
[Description("增减当前CD时间及已使用次数,使用次数1为CD刷新,2为CD走一轮,3两轮类推")]
[ExposeAsDefinition]
public class AddAbilityCD : CallableActionNode<int, int, int, int, int>
{
	public override void Invoke(int target, int abilityID, int percent, int increment, int modifyUsedCount)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD))
		{
			abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
			CDProcessor.SetCD(entityWithEntityID, abilityID, IntMath.Divide(abilityCD.CD * percent, 100) + increment, abilityCD.UsedCount + modifyUsedCount);
		}
	}
}
