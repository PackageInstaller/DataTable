using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置傀儡思考时间", 0)]
[Category("Logic/Puppet")]
[Description("获取傀儡思考时间")]
public class SetPuppetThinkTime : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int thinkTime)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPuppet)
		{
			entityWithEntityID.entityPuppet.mThinkTime = thinkTime;
		}
	}
}
