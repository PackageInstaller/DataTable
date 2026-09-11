using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("宿主技能结束事件", 0)]
[Category("Logic/事件")]
[Description("宿主技能结束事件")]
public class PuppetHostAbilityOverEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int mEntityID;

	private int mParentID;

	private int mAbilityID;

	private int mOldAbilityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPuppetHostAbilityOverEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mPuppetHostAbilityOverEvent, new Action<int, int, int, int>(PuppetUpdateEvent));
	}

	public void PuppetUpdateEvent(int hostID, int entityID, int ability, int oldAbility)
	{
		mEntityID = entityID;
		mParentID = hostID;
		mAbilityID = ability;
		mOldAbilityID = oldAbility;
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
		AddValueOutput("宿主结束技能ID:", () => mOldAbilityID);
	}
}
