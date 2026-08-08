using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取宿主的所有傀儡实体ID列表", 0)]
[Category("Logic/Puppet")]
[Description("获取宿主的所有傀儡实体ID列表")]
public class GetAllPuppetID : PureFunctionNode<List<int>, int>
{
	public override List<int> Invoke(int hostID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(hostID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPuppetHost)
		{
			return entityWithEntityID.entityPuppetHost.mPuppets;
		}
		return null;
	}
}
