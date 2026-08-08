using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("宿主技能执行事件", 0)]
[Category("Logic/事件")]
[Description("宿主技能执行事件")]
public class PuppetHostDoAbilityEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int mEntityID;

	private int mParentID;

	private int mAbilityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPuppetHostDoAbilityEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mPuppetHostDoAbilityEvent, new Action<int, int, int>(PuppetUpdateEvent));
	}

	public void PuppetUpdateEvent(int hostID, int entityID, int ability)
	{
		mEntityID = entityID;
		mParentID = hostID;
		mAbilityID = ability;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("实体ID:", () => mEntityID);
		AddValueOutput("宿主ID:", () => mParentID);
		AddValueOutput("宿主执行技能ID:", () => mAbilityID);
	}
}
