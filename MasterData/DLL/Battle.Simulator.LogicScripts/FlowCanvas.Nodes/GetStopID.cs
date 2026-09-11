using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取刹车动作ID", 0)]
[Category("Logic/Puppet")]
[Description("根据距离计算傀儡的速度因子")]
public class GetStopID : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		return (entityWithEntityID.entityConfig.mConfig as RoleConfig).MovementStop;
	}
}
