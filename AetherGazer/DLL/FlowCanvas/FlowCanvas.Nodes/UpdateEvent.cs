using System.Collections.Generic;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("On Update", 7)]
[Category("Events/Graph")]
[Description("Called per-frame.\nUpdate Interval optionally determines the period in seconds every which update is called. Leave at 0 to call update per-frame as normal.")]
[ExecutionPriority(7)]
public class UpdateEvent : EventNode, IUpdatable
{
	public BBParameter<float> updateInterval = new BBParameter<float>(0f);

	private FlowOutput update;

	private float lastUpdatedTime;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		updateInterval = options.Resolver.GetFormatter<BBParameter<float>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<BBParameter<float>>().Serialize(ref writer, updateInterval, options);
	}

	protected override void RegisterPorts()
	{
		update = AddFlowOutput("Out");
	}

	public override void OnGraphStarted()
	{
		lastUpdatedTime = -1f;
	}

	public void Update()
	{
		if (updateInterval.value <= 0f)
		{
			update.Call(default(Flow));
			return;
		}
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (realtimeSinceStartup > updateInterval.value + lastUpdatedTime)
		{
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			update.Call(f);
			lastUpdatedTime = realtimeSinceStartup;
		}
	}
}
