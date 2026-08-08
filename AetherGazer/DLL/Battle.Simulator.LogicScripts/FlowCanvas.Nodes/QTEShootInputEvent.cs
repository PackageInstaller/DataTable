using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("QTE射击输入事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("在获取QTE射击输入的时候触发")]
public class QTEShootInputEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _Out;

	private int _EntityID;

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mButtonShootEvent = (Action<int>)Delegate.Combine(simInterface.mButtonShootEvent, new Action<int>(OnQTEShoot));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mButtonShootEvent = (Action<int>)Delegate.Remove(simInterface.mButtonShootEvent, new Action<int>(OnQTEShoot));
	}

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("输出");
		AddValueOutput("entityID", () => _EntityID);
	}

	private void OnQTEShoot(int entityID)
	{
		_EntityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_Out.Call(f);
	}
}
