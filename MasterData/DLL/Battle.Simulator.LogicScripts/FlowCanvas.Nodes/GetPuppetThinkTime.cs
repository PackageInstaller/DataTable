using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取傀儡思考时间", 0)]
[Category("Logic/Puppet")]
[Description("获取傀儡思考时间")]
public class GetPuppetThinkTime : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPuppet)
		{
			return entityWithEntityID.entityPuppet.mThinkTime;
		}
		return 0;
	}
}
