using System.Collections.Generic;
using Config;
using Google.Protobuf.Collections;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("地图初始化完成事件", 0)]
[Category("Logic/事件")]
[Description("在地图初始化完成时触发")]
public class LogicMapInitEvent : EventNode
{
	private FlowOutput mapInit;

	private int triggerID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		mapInit = AddFlowOutput("输出");
		AddValueOutput("触发器ID", () => triggerID);
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EntityTriggerEvent>(OnMapInitEventHandler);
	}

	private void OnMapInitEventHandler(EntityTriggerEvent triggerEvent)
	{
		if (triggerEvent.mEventType != TriggerEventType.MapInit)
		{
			return;
		}
		RepeatedField<ProtoEntityData> entityDatas = CommonProcessor.GetWorldState().mMapTrigger.EntityDatas;
		for (int i = 0; i < entityDatas.Count; i++)
		{
			if (entityDatas.get_Item(i).Type.Contains(base.graphName))
			{
				triggerID = entityDatas.get_Item(i).Id;
			}
		}
		Flow f = new Flow
		{
			returnData = returnData
		};
		mapInit.Call(f);
	}
}
