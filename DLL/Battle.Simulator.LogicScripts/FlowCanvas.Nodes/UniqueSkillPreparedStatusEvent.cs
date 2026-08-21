using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义技准备状态事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("如题")]
public class UniqueSkillPreparedStatusEvent : EventNode
{
	private FlowOutput _out;

	private ValueInput<EntityActionStatus> _listenStatusInput;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private int _entityID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillPreparedStatus = (Action<int, EntityActionStatus>)Delegate.Combine(simInterface.mUniqueSkillPreparedStatus, new Action<int, EntityActionStatus>(OnInvoke));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillPreparedStatus = (Action<int, EntityActionStatus>)Delegate.Remove(simInterface.mUniqueSkillPreparedStatus, new Action<int, EntityActionStatus>(OnInvoke));
	}

	private void OnInvoke(int entityID, EntityActionStatus entityActionStatus)
	{
		if (_listenStatusInput.value == entityActionStatus)
		{
			_entityID = entityID;
			Flow f = new Flow
			{
				returnData = _returnData
			};
			_out.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("Out", "output");
		_listenStatusInput = AddValueInput<EntityActionStatus>("监听状态", "listensStatus");
		AddValueOutput("实体ID", "EntityID", () => _entityID);
	}
}
