using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取最大CD", 0)]
[Category("Logic/Config")]
[Description("是取的修改CD之后的CD上限值，如果没有修改返回的是配置CD值")]
public class GetMaxCD : PureFunctionNode<int, int, int>
{
	public override int Invoke(int simEntityID, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		int maxCD = 0;
		int maxUseCount = 0;
		abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
		if (entityWithEntityID != null && CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out maxCD, out maxUseCount))
		{
			return maxCD;
		}
		return 1;
	}
}
