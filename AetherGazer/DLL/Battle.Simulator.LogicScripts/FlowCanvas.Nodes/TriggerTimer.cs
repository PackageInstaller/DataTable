using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("计时器(触发器)", 0)]
[Category("Logic/Control")]
[Description("可以给对应触发器计时的节点,间隔单位时毫秒")]
public class TriggerTimer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		ValueInput<int> timeInput = AddValueInput<int>("间隔");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			int num = CommonProcessor.GetSimEntityByTriggerID(triggerIDInput.value).entityTrigger.mActiveFrameCount * CommonProcessor.GetLogicConstTick();
			int value = timeInput.value;
			value = ((value == 0) ? 1 : value);
			if (num > CommonProcessor.GetLogicConstTick() && num % value < CommonProcessor.GetLogicConstTick())
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddFlowInput("Reset", delegate
		{
			SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerIDInput.value);
			if (simEntityByTriggerID == null)
			{
				Debug.LogError("TriggerTimer cant not find entity, ID:" + triggerIDInput.value);
			}
			simEntityByTriggerID.entityTrigger.mActiveFrameCount = 0;
		});
	}
}
