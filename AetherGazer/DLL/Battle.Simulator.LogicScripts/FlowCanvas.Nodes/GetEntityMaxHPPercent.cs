using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体最大血量的百分比", 0)]
[Category("Logic/Attribute")]
[Description("获取实体最大血量的百分比,比如最大血量的10%")]
public class GetEntityMaxHPPercent : PureFunctionNode<int, int, int>
{
	public override int Invoke(int entityID, int percent)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return 0;
		}
		return (int)(entityWithEntityID.entityBlackboard.var.mMaxHP * percent / 100);
	}
}
