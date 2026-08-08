using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("触发器更新事件", 0)]
[Category("Logic/事件")]
[Description("每一个激活状态的触发器都以固定的频率触发这个事件")]
public class LogicTriggerUpdateEvent : EventNode
{
	private FlowOutput output;

	private int triggerID;

	public int undateInterval;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		undateInterval = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(undateInterval);
	}

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("输出");
		AddValueOutput("触发器ID", () => triggerID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mLogicTriggerEvent = (Action<int>)Delegate.Combine(simulatorInferface.mLogicTriggerEvent, new Action<int>(OnLogicTriggerEventHandler));
	}

	private void OnLogicTriggerEventHandler(int triggerEntityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(triggerEntityID);
		if (undateInterval == 0 || entityWithEntityID.entityTrigger.mActiveFrameCount % undateInterval == 0)
		{
			triggerID = entityWithEntityID.entityTrigger.mTriggerID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
	}
}
