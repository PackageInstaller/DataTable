using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("闪避残影事件", 0)]
[Category("Logic/事件")]
[Description("零时空间触发条件事件, 退出的时候两个时间是没有意义的, tick的时候总时间事没有意义的")]
public class UltimateAvoidFrameEvent : EventNode
{
	private FlowOutput enter;

	private FlowOutput tick;

	private FlowOutput exit;

	private int entityID;

	private int resTime;

	private int duration;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUltimateAvoidFrameEvent = (Action<int, int, int, UltimateAvoidFrameEventType>)Delegate.Combine(simInterface.mUltimateAvoidFrameEvent, new Action<int, int, int, UltimateAvoidFrameEventType>(OnUltimateAvoidFrameEvent));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUltimateAvoidFrameEvent = (Action<int, int, int, UltimateAvoidFrameEventType>)Delegate.Remove(simInterface.mUltimateAvoidFrameEvent, new Action<int, int, int, UltimateAvoidFrameEventType>(OnUltimateAvoidFrameEvent));
	}

	private void OnUltimateAvoidFrameEvent(int entityID, int resTime, int duration, UltimateAvoidFrameEventType state)
	{
		this.entityID = entityID;
		this.resTime = resTime;
		this.duration = duration;
		Flow f = new Flow
		{
			returnData = returnData
		};
		switch (state)
		{
		case UltimateAvoidFrameEventType.Enter:
			enter.Call(f);
			break;
		case UltimateAvoidFrameEventType.Tick:
			tick.Call(f);
			break;
		case UltimateAvoidFrameEventType.Exit:
			exit.Call(f);
			break;
		}
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("剩余时间(毫秒)", () => resTime);
		AddValueOutput("配置时长(毫秒)", () => duration);
		enter = AddFlowOutput("Enter");
		tick = AddFlowOutput("Tick");
		exit = AddFlowOutput("Exit");
	}
}
