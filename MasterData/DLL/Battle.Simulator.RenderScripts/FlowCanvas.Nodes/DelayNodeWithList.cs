using System;
using System.Collections.Generic;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("延迟节点(可多次触发)", 0)]
[Category("Render/Timeline")]
[Description("延迟节点, 反复调用无效, 只适用于只会走一次的逻辑")]
public class DelayNodeWithList : FlowNode, IUpdatable
{
	[NonSerialized]
	private FlowOutput output;

	[NonSerialized]
	private double currentTime;

	[NonSerialized]
	private List<double> listStartTime;

	[NonSerialized]
	private List<int> listValueToPass;

	[NonSerialized]
	private Flow flow;

	[NonSerialized]
	private int res;

	public float delayTime;

	public bool stopUpdateWhenBattlePause = true;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		delayTime = reader.ReadSingle();
		stopUpdateWhenBattlePause = reader.ReadBoolean();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(delayTime);
		writer.Write(stopUpdateWhenBattlePause);
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		currentTime = 0.0;
		if (listStartTime != null)
		{
			listStartTime.Clear();
		}
		if (listValueToPass != null)
		{
			listValueToPass.Clear();
		}
	}

	public void Update()
	{
		if (BattleScene.isPause && stopUpdateWhenBattlePause)
		{
			return;
		}
		currentTime += Time.deltaTime;
		for (int num = listStartTime.Count - 1; num >= 0; num--)
		{
			if (currentTime - listStartTime[num] > (double)delayTime)
			{
				res = listValueToPass[num];
				flow.Call(output);
				listValueToPass.RemoveAt(num);
				listStartTime.RemoveAt(num);
			}
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> valueInput = AddValueInput<int>("传递值");
		AddValueOutput("传递值", () => res);
		output = AddFlowOutput("");
		listStartTime = new List<double>();
		listValueToPass = new List<int>();
		AddFlowInput("", delegate(Flow f)
		{
			flow = f;
			listStartTime.Add(currentTime);
			listValueToPass.Add(valueInput.value);
		});
	}
}
