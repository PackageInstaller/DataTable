using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送事件(渲染)", 0)]
[Category("Render/Trigger")]
[Description("发送事件给对应的触发器")]
public class SendEventWithStringParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetTriggerIDInput = AddValueInput<int>("目标");
		ValueInput<string> eventNameInput = AddValueInput<string>("事件名");
		ValueInput<string> eventValueInput = AddValueInput<string>("参数");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			MapTriggerManager mapTriggerManager = (NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager();
			if (mapTriggerManager.onTriggerSendEvent != null)
			{
				mapTriggerManager.onTriggerSendEvent(targetTriggerIDInput.value, eventNameInput.value, eventValueInput.value);
			}
			output.Call(f);
		});
	}
}
