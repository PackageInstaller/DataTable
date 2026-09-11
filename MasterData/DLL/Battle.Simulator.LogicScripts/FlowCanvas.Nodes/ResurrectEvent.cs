using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("复活事件", 0)]
[Category("Common/事件")]
[Description("游戏结束事件")]
public class ResurrectEvent : EventNode
{
	private ValueInput<bool> isRenderInput;

	private FlowOutput outputDeath;

	private FlowOutput outputTickDeath;

	private FlowOutput outputResurrect;

	private FlowOutput outputGiveUp;

	private int entityID;

	private long coinNumber;

	private long coinConsume;

	private int resurrectTimes;

	private ResurrectEventState state;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		isRenderInput = AddValueInput<bool>("是否渲染");
		outputDeath = AddFlowOutput("死亡");
		outputTickDeath = AddFlowOutput("死亡之后的tick");
		outputResurrect = AddFlowOutput("重生");
		outputGiveUp = AddFlowOutput("放弃");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("剩余金币数量", () => coinNumber);
		AddValueOutput("每次消耗数量", () => coinConsume);
		AddValueOutput("已经复活的次数", () => resurrectTimes);
	}

	public override void OnGraphStarted()
	{
		if (!isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<SimResurrectEvent>(OnResurrectEvent);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<SimResurrectEvent>(OnResurrectEvent);
		}
	}

	private void OnResurrectEvent(SimResurrectEvent eventReceived)
	{
		Flow flow = new Flow
		{
			returnData = returnData
		};
		entityID = eventReceived.entityID;
		coinNumber = eventReceived.coinNumber;
		coinConsume = eventReceived.coinConsume;
		resurrectTimes = eventReceived.resurrectTimes;
		switch (eventReceived.state)
		{
		case ResurrectEventState.death:
			flow.Call(outputDeath);
			break;
		case ResurrectEventState.giveup:
			flow.Call(outputGiveUp);
			break;
		case ResurrectEventState.resurrect:
			flow.Call(outputResurrect);
			break;
		case ResurrectEventState.tickAfterDeath:
			flow.Call(outputTickDeath);
			break;
		}
	}
}
