using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("延迟节点", 0)]
[Category("Render/Timeline")]
[Description("延迟节点, 反复调用无效, 只适用于只会走一次的逻辑")]
public class DelayNode : FlowNode, IUpdatable
{
	private FlowOutput output;

	private bool start;

	private float currrentTime;

	private float maxTime;

	private Flow flow;

	public bool stopUpdateWhenBattlePause = true;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		stopUpdateWhenBattlePause = reader.ReadBoolean();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(stopUpdateWhenBattlePause);
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		currrentTime = 0f;
		maxTime = 0f;
		start = false;
	}

	public void Update()
	{
		if ((!BattleScene.isPause || !stopUpdateWhenBattlePause) && start)
		{
			currrentTime += Time.deltaTime;
			if (currrentTime > maxTime)
			{
				flow.Call(output);
				start = false;
			}
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<float> timeInput = AddValueInput<float>("时间(秒)");
		output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (!start)
			{
				flow = f;
				maxTime = timeInput.value;
				currrentTime = 0f;
				start = true;
			}
		});
		FlowOutput out1 = AddFlowOutput("延迟时终止");
		FlowOutput out2 = AddFlowOutput("延迟后终止");
		AddFlowInput("终止", delegate(Flow f)
		{
			if (start)
			{
				start = false;
				f.Call(out1);
			}
			else
			{
				f.Call(out2);
			}
		});
	}
}
