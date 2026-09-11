using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("变身事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("变身后事件,该事件在变身后触发,上一句就是触发")]
public class TransfigurationEvent : EventNode
{
	private FlowOutput output;

	private int entityID;

	private int oldRoleID;

	private int newRoleID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("旧的实体类型ID", "旧的角色ID", () => oldRoleID);
		AddValueOutput("新的实体类型ID", "新的角色ID", () => newRoleID);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mTransfigurationEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mTransfigurationEvent, new Action<int, int, int>(OnTransfigurationEvent));
	}

	private void OnTransfigurationEvent(int entityID, int oldRoleID, int newRoleID)
	{
		this.entityID = entityID;
		this.oldRoleID = oldRoleID;
		this.newRoleID = newRoleID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
