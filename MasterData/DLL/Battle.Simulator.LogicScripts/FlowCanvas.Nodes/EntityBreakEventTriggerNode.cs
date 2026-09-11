using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("破防事件(触发器)", 0)]
[Category("Logic/事件")]
[Description("破防事件, 角色ID为0表示没有过滤条件")]
public class EntityBreakEventTriggerNode : EventNode
{
	private int triggerID;

	private int entityID;

	private ValueInput<int> roleIDInput;

	private FlowOutput breakOutput;

	private FlowOutput breakEndOutput;

	private FlowOutput cdEndOutput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mEntityBreakTriggerEvent = (Action<int, EntityBreakEvent>)Delegate.Combine(simulatorInferface.mEntityBreakTriggerEvent, new Action<int, EntityBreakEvent>(OnEntityBreakTriggerEventHandler));
	}

	private void OnEntityBreakTriggerEventHandler(int triggerID, EntityBreakEvent eventReceived)
	{
		if (roleIDInput.value != 0)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(eventReceived.entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || roleIDInput.value != entityWithEntityID.entityConfig.mId)
			{
				return;
			}
		}
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null && simEntityByTriggerID.entityTrigger.mEnabled)
		{
			entityID = eventReceived.entityID;
			this.triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (eventReceived.state == BreakState.breakState)
			{
				breakOutput.Call(f);
			}
			if (eventReceived.state == BreakState.breakCDState)
			{
				breakEndOutput.Call(f);
			}
			if (eventReceived.state == BreakState.delay)
			{
				cdEndOutput.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		breakOutput = AddFlowOutput("开始崩溃");
		breakEndOutput = AddFlowOutput("崩溃结束");
		cdEndOutput = AddFlowOutput("cd结束");
		roleIDInput = AddValueInput<int>("实体类型ID");
		AddValueOutput("触发器ID", () => triggerID);
		AddValueOutput("实体ID", () => entityID);
	}
}
