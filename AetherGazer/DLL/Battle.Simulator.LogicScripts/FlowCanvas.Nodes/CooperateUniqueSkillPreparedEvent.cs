using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]准备完成事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("如题")]
public class CooperateUniqueSkillPreparedEvent : EventNode
{
	private FlowOutput _out;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCooperateUniqueSkillPrepared = (Action)Delegate.Combine(simInterface.mCooperateUniqueSkillPrepared, new Action(OnInvoke));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCooperateUniqueSkillPrepared = (Action)Delegate.Remove(simInterface.mCooperateUniqueSkillPrepared, new Action(OnInvoke));
	}

	private void OnInvoke()
	{
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_out.Call(f);
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("Out", "output");
	}
}
