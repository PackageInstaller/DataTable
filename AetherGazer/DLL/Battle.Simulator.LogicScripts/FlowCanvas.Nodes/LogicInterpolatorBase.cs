using System;
using System.Collections.Generic;
using MessagePack;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class LogicInterpolatorBase : FlowNode
{
	[NonSerialized]
	[HideInInspector]
	private AnimationCurve animationCurve;

	[HideInInspector]
	public IntCurve intCurve = new IntCurve(new List<Int2>
	{
		new Int2
		{
			x = 0,
			y = 0
		},
		new Int2
		{
			x = 100,
			y = 100
		}
	});

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		if (intCurve == null)
		{
			writer.WriteInt32(0);
			return;
		}
		writer.WriteInt32(intCurve.frame.Count);
		for (int i = 0; i < intCurve.frame.Count; i++)
		{
			writer.WriteInt32(intCurve.frame[i].x);
			writer.WriteInt32(intCurve.frame[i].y);
		}
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		int num = reader.ReadInt32();
		if (intCurve == null)
		{
			intCurve = new IntCurve();
		}
		intCurve.frame.Clear();
		for (int i = 0; i < num; i++)
		{
			Int2 item = new Int2
			{
				x = reader.ReadInt32(),
				y = reader.ReadInt32()
			};
			intCurve.frame.Add(item);
		}
	}

	protected override void RegisterPorts()
	{
	}
}
