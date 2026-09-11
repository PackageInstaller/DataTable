using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("玩家方AI攻击事件", 0)]
[Category("Logic/事件")]
[Description("玩家方AI攻击事件")]
public class PlayerAIAttackEvent : EventNode
{
	private int entityID;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPlayerAIAttackEvent = (Action<int>)Delegate.Combine(simInterface.mPlayerAIAttackEvent, new Action<int>(OnEventhandler));
	}

	private void OnEventhandler(int obj)
	{
		entityID = obj;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
