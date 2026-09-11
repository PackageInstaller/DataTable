using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]获取技能可使用次数", 0)]
[Category("Logic/Attribute")]
[Description("获取技能当前可用次数")]
public class GetAbilityUseCount : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int target, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		bool cD = CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD);
		CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out var _, out var maxUseCount);
		if (!entityWithEntityID.hasEntityCD)
		{
			return 0;
		}
		if (maxUseCount == 0)
		{
			if (cD)
			{
				return 0;
			}
			return 1;
		}
		if (cD)
		{
			return IntMath.Max(0, maxUseCount - abilityCD.UsedCount);
		}
		return IntMath.Max(0, maxUseCount);
	}
}
