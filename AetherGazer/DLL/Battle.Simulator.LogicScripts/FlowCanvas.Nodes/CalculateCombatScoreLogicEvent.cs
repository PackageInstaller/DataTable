using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算战斗评分事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("用以计算评分的回调,避免后续计算规则修改,导致反复更改core")]
public class CalculateCombatScoreLogicEvent : EventNode
{
	private FlowOutput m_out;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int m_entityID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCalculateCombatScoreLogic = (Action<int>)Delegate.Combine(simInterface.mCalculateCombatScoreLogic, new Action<int>(evtHandler));
	}

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
	}

	public void evtHandler(int entityID)
	{
		m_entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_out.Call(f);
	}
}
