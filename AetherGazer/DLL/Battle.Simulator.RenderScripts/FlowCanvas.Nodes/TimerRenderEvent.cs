using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体计时器事件（渲染）", 0)]
[Category("Render/事件")]
[Description("实体计时器事件")]
public class TimerRenderEvent : EventNode
{
	private int entityID;

	private int timerName;

	private int id;

	private bool isTimeout;

	private FlowOutput bind;

	private FlowOutput leave;

	private FlowOutput tick;

	private EntityTimerStruct EntityTimerStruct;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("编号", () => timerName);
		AddValueOutput("唯一ID", () => id);
		AddValueOutput("计时器", () => EntityTimerStruct);
		AddValueOutput("是否超时移除", () => isTimeout);
		bind = AddFlowOutput("添加");
		tick = AddFlowOutput("触发");
		leave = AddFlowOutput("移除");
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityTimerEvent>(OnEntityTimerEventHandler);
	}

	private void OnEntityTimerEventHandler(EntityTimerEvent e)
	{
		entityID = e.entityID;
		timerName = e.timerStruct.name;
		id = e.timerStruct.id;
		EntityTimerStruct = e.timerStruct;
		isTimeout = e.isTimeoutLeft;
		Flow f = new Flow
		{
			returnData = returnData
		};
		switch (e.life)
		{
		case EBuffLife.Bind:
			bind.Call(f);
			break;
		case EBuffLife.Tick:
			tick.Call(f);
			break;
		case EBuffLife.Leave:
			leave.Call(f);
			break;
		}
	}
}
