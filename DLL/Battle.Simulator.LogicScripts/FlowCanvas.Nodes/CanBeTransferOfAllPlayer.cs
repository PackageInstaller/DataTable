using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被传送(全部玩家)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("判断传入的实体是否能被传送")]
public class CanBeTransferOfAllPlayer : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("都可传送", "true");
		FlowOutput falseOut = AddFlowOutput("存在不可传送", "false");
		AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
				{
					flag = CanBeTransfer.Invoke(base.mSimContext, entityWithEntityID);
					if (!flag)
					{
						break;
					}
				}
			}
			if (flag)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
