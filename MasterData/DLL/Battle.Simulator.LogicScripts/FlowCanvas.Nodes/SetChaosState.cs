using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置混乱状态", 0)]
[Category("Logic/Buff")]
[Description("判断当前帧是否是判定帧")]
public class SetChaosState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<bool> stateInput = AddValueInput<bool>("状态");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int num = 0;
			if (stateInput.value)
			{
				num = 1;
			}
			AttributeProcessor.SetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2181, num, 0L, 0L);
			output.Call(f);
		});
	}
}
