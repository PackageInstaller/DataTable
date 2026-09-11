using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化怪物事件", 0)]
[Category("Logic/事件")]
[Description("初始化怪物事件, 在创建怪物节点的最后触发")]
public class EnemyInitEvent : EventNode
{
	private int entityID;

	private FlowOutput output;

	private ValueInput<int> initIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		initIDInput = AddValueInput<int>("初始化脚本ID");
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mInitEnemyEvent = (Action<int, int>)Delegate.Combine(simInterface.mInitEnemyEvent, new Action<int, int>(OnEnemyInitEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mInitEnemyEvent = (Action<int, int>)Delegate.Remove(simInterface.mInitEnemyEvent, new Action<int, int>(OnEnemyInitEventHandler));
	}

	private void OnEnemyInitEventHandler(int entityID, int initID)
	{
		if (base.mSimContext.GetEntityWithEntityID(entityID) != null && initID == initIDInput.value)
		{
			this.entityID = entityID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
	}
}
