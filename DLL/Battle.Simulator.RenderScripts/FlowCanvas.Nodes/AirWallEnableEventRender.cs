using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("空气墙事件(表现)", 0)]
[Category("Render/事件")]
[Description("在空气墙启用或者禁用时触发")]
public class AirWallEnableEventRender : EventNode
{
	private FlowOutput output;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private int id;

	private Int3 pos;

	private Int3 forward;

	private Int3 playerPos;

	private bool enable;

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("输出");
		AddValueOutput("空气墙ID", () => id);
		AddValueOutput("空气墙位置", () => pos);
		AddValueOutput("空气墙朝向", () => forward);
		AddValueOutput("玩家位置", () => playerPos);
		AddValueOutput("是否启用", () => enable);
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<AirWallEnableEvent>(OnEnableAirWallEventHandler);
	}

	private void OnEnableAirWallEventHandler(AirWallEnableEvent eventReceived)
	{
		id = eventReceived.id;
		pos = eventReceived.pos;
		forward = eventReceived.forward;
		playerPos = eventReceived.playerPos;
		enable = eventReceived.enable;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		output.Call(f);
	}
}
