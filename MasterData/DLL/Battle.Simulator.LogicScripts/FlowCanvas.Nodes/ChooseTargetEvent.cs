using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("手动切换锁定目标的事件", 0)]
[Category("Logic/事件")]
[Description("手动切换锁定目标的事件")]
public class ChooseTargetEvent : EventNode
{
	private int _entityIDOld;

	private int _entityIDNew;

	private FlowOutput _output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mChooseTargetEvent = (Action<int, int>)Delegate.Combine(simInterface.mChooseTargetEvent, new Action<int, int>(OnChooseTargetEvent));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mChooseTargetEvent = (Action<int, int>)Delegate.Remove(simInterface.mChooseTargetEvent, new Action<int, int>(OnChooseTargetEvent));
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("");
		AddValueOutput("原目标实体ID", () => _entityIDOld);
		AddValueOutput("新目标实体ID", () => _entityIDNew);
	}

	private void OnChooseTargetEvent(int lastEntityID, int currentEntityID)
	{
		_entityIDOld = lastEntityID;
		_entityIDNew = currentEntityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}
}
