using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("受击更新事件", 0)]
[Category("Logic/Abilities")]
[Description("受击执行事件")]
public class LogicHitRecoverEvent : EventNode
{
	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int _entityID;

	private E_HitRecoverStatus _status;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateHitRecover = (Action<int, E_HitRecoverStatus>)Delegate.Combine(simInterface.mUpdateHitRecover, new Action<int, E_HitRecoverStatus>(LogicHitRecoverUpdateHandle));
	}

	private void LogicHitRecoverUpdateHandle(int entityID, E_HitRecoverStatus status)
	{
		_entityID = entityID;
		_status = status;
		Flow flow = default(Flow);
		flow.returnData = returnData;
		flow.Call(output);
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("状态", () => _status);
		output = AddFlowOutput("");
	}
}
