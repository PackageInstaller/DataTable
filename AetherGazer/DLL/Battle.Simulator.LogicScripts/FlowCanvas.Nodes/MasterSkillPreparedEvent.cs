using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能准备完成事件", 0)]
[Category("Logic/事件")]
[Description("芯片技能准备完成事件")]
public class MasterSkillPreparedEvent : EventNode
{
	private int entityID;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mEntityMasterSkillPreparedEvent = (Action<int>)Delegate.Combine(simInterface.mEntityMasterSkillPreparedEvent, new Action<int>(EntityMasterSkillPrepared));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mEntityMasterSkillPreparedEvent = (Action<int>)Delegate.Remove(simInterface.mEntityMasterSkillPreparedEvent, new Action<int>(EntityMasterSkillPrepared));
	}

	private void EntityMasterSkillPrepared(int id)
	{
		entityID = id;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
