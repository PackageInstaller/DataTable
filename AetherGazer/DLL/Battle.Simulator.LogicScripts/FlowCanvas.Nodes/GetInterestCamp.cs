using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取感兴趣的阵营层", 0)]
[Category("Logic/Trigger")]
[Description("获取感兴趣的阵营层")]
[ExposeAsDefinition]
public class GetInterestCamp : PureFunctionNode<uint, int>
{
	public override uint Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			InterestConfig config = ConfigHelper.GetInstance().GetConfig<InterestConfig>((int)entityWithEntityID.entityShape.mLayer);
			int num = 0;
			for (int i = 0; i < config.Group.Count; i++)
			{
				num |= (int)config.Group.get_Item(i);
			}
			return (uint)num;
		}
		return 0u;
	}
}
