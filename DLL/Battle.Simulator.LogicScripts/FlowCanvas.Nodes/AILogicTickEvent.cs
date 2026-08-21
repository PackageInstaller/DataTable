using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI逻辑更新事件", 0)]
[Category("Logic/事件")]
[Description("逻辑tick AI的固定频率")]
public class AILogicTickEvent : EventNode
{
	private FlowOutput AITickOutput;

	private int inputID;

	private int ai_logic_id;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		AITickOutput = AddFlowOutput("输出");
		AddValueOutput("AI实体ID:", () => inputID);
		AddValueOutput("AI逻辑ID:", () => ai_logic_id);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAILogicEvent = (Action<int, int>)Delegate.Combine(simInterface.mUpdateAILogicEvent, new Action<int, int>(LogicAIUpdate));
	}

	public void LogicAIUpdate(int creationIndex, int aiID)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		inputID = creationIndex;
		ai_logic_id = aiID;
		AITickOutput.Call(f);
	}
}
