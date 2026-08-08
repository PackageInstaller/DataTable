using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AbilityTick结束事件", 0)]
[Category("Logic/事件")]
[Description("每次技能Tick结束完后会触发")]
public class UpdateAbilityEvent : EventNode
{
	private SimEntity _simEntity;

	private int _abilityID;

	private FlowOutput flowOut;

	private int _time;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityEndLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityEndLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdate));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_simEntity = null;
	}

	protected override void RegisterPorts()
	{
		flowOut = AddFlowOutput("输出");
		AddValueOutput("实体", () => _simEntity);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("时间", () => _time);
	}

	public void LogicAbilityUpdate(int entityID, int abilityID, int start, int step)
	{
		_simEntity = base.mSimContext.GetEntityWithEntityID(entityID);
		_abilityID = abilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		flowOut.Call(f);
		_time = start;
	}
}
