using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[奥义]准备完成事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("如题")]
public class UniqueSkillPreparedEvent : EventNode
{
	private FlowOutput _out;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private int _entityID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillPrepared = (Action<int>)Delegate.Combine(simInterface.mUniqueSkillPrepared, new Action<int>(OnInvoke));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillPrepared = (Action<int>)Delegate.Remove(simInterface.mUniqueSkillPrepared, new Action<int>(OnInvoke));
	}

	private void OnInvoke(int entityID)
	{
		_entityID = entityID;
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_out.Call(f);
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "EntityID", () => _entityID);
	}
}
