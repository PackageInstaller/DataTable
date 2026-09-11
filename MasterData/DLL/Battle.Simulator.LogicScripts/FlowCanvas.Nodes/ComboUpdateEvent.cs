using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连击计时事件", 0)]
[Category("Logic/事件")]
[Description("连击计时事件,每帧触发, 再这个后面去修改连击计时")]
public class ComboUpdateEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("实体ID", () => entityID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mComboTimeEvent = (Action<int>)Delegate.Combine(simInterface.mComboTimeEvent, new Action<int>(LogicUpdate));
	}

	private void LogicUpdate(int entityID)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		this.entityID = entityID;
		logicTickEventOutput.Call(f);
	}
}
