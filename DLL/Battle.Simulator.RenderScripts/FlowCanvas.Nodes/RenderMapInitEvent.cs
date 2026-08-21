using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("地图初始化完成事件(表现)", 0)]
[Category("Render/事件")]
[Description("在地图初始化完成时触发")]
public class RenderMapInitEvent : EventNode
{
	private FlowOutput mapInit;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		mapInit = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityTriggerEvent>(OnMapInitEventHandler);
	}

	private void OnMapInitEventHandler(EntityTriggerEvent triggerEvent)
	{
		if (triggerEvent.mEventType == TriggerEventType.MapInit)
		{
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mapInit.Call(f);
		}
	}
}
