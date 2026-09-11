using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改抛掷物目标事件", 0)]
[Category("Logic/事件")]
[Description("当抛掷物处理完目标之后,会触发该事件,用于自定义修改抛掷物目标")]
public class ReceiveThrownUpdateTargetEvent : EventNode
{
	private int m_thrownID;

	private ValueInput<int> m_thrownTimelineIDVar;

	private FlowOutput m_output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_thrownTimelineIDVar = AddValueInput<int>("TimelineID", "timelineIDVar");
		m_output = AddFlowOutput("Out", "output");
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateThrownTarget = (Action<int>)Delegate.Combine(simInterface.mUpdateThrownTarget, new Action<int>(OnNeedUpdateTarget));
	}

	private void OnNeedUpdateTarget(int thrownID)
	{
		if (thrownID != 0)
		{
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(base.mSimContext, thrownID, out thrownState) && thrownState.mAbilityID == m_thrownTimelineIDVar.GetValue())
			{
				m_thrownID = thrownID;
				Flow f = new Flow
				{
					returnData = returnData
				};
				m_output.Call(f);
			}
		}
	}
}
