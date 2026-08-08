using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取锁定碰撞盒列表", 0)]
[Category("Logic/Attribute")]
[Description("获取锁定碰撞盒列表，从渲染层传过来")]
public class GetAimLockList : FlowNode
{
	private int entityID;

	protected override void RegisterPorts()
	{
		FlowOutput doOut = AddFlowOutput("do");
		FlowOutput doneOut = AddFlowOutput("done");
		AddValueOutput("目标实体ID", () => entityID);
		AddFlowInput("in", delegate(Flow f)
		{
			List<int> mButtonLockList = base.mSimContext.sEntityWorldState.status.mButtonLockList;
			for (int i = 0; i < mButtonLockList.Count; i++)
			{
				entityID = mButtonLockList[i];
				doOut.Call(f);
			}
			doneOut.Call(f);
		});
	}
}
