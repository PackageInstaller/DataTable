using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI是否开启", 0)]
[Category("Logic/AI")]
[Description("AI是否开启, false的话关闭AI, true的话启用AI")]
public class IsAIEnable : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput outputTrue = AddFlowOutput("true");
		FlowOutput outputFalse = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2196, out var baseValue, out var _, out var _);
			if (baseValue > 0)
			{
				outputFalse.Call(f);
			}
			else
			{
				outputTrue.Call(f);
			}
		});
	}
}
