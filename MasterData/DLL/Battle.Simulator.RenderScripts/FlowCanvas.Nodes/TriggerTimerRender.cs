using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计时器(触发器)(渲染)", 0)]
[Category("Render/Trigger")]
[Description("可以给对应触发器计时的节点,间隔单位时毫秒")]
public class TriggerTimerRender : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		ValueInput<int> timeInput = AddValueInput<int>("间隔");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			MapTriggerManager mapTriggerManager = (NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager();
			int num = 1000 / BattleSimulatorSystem.sTargetLogicFrameRate;
			int num2 = mapTriggerManager.GetTriggerState(triggerIDInput.value).activeFrameCount * num;
			int value = timeInput.value;
			if (num2 > num && num2 % value < num)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddFlowInput("Reset", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager().GetTriggerState(triggerIDInput.value).activeFrameCount = 0;
			trueOut.Call(f);
		});
	}
}
