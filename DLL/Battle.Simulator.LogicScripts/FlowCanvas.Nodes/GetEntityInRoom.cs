using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理房间内的玩家", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理房间内的玩家, AI也算, 只处理活着的实体啊")]
public class GetEntityInRoom : FlowNode
{
	protected override void RegisterPorts()
	{
		int res = 0;
		AddValueOutput("实体ID", () => res);
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				res = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(res);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					f.Call(doOut);
				}
			}
			f.Call(doneOut);
		});
	}
}
