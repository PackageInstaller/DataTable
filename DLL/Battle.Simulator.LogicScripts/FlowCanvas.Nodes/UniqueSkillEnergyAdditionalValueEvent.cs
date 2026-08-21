using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义能量额外添加事件", 0)]
[Category("Common/事件")]
[Description("奥义能量额外加成事件, 当有额外奥义能量添加的时候触发")]
public class UniqueSkillEnergyAdditionalValueEvent : EventNode
{
	private FlowOutput output;

	private int entityID;

	private int delta;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillEnergyAdditionalValueEvent = (Action<int, int>)Delegate.Combine(simInterface.mUniqueSkillEnergyAdditionalValueEvent, new Action<int, int>(OnUniqueSkillEnergyAdditionalValueEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUniqueSkillEnergyAdditionalValueEvent = (Action<int, int>)Delegate.Remove(simInterface.mUniqueSkillEnergyAdditionalValueEvent, new Action<int, int>(OnUniqueSkillEnergyAdditionalValueEventHandler));
	}

	private void OnUniqueSkillEnergyAdditionalValueEventHandler(int entityID, int delta)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		this.entityID = entityID;
		this.delta = delta;
		output.Call(f);
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("变化量", () => delta);
		output = AddFlowOutput("");
	}
}
