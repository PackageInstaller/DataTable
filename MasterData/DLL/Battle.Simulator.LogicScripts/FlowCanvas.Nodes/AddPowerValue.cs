using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加机制值(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("添加能量值, 单纯的设置机制值, 不会触发能量变更事件, 其他的设置节点一般都会")]
public class AddPowerValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> valueInput = AddValueInput<int>("增加值");
		ValueInput<int> maxValueInput = AddValueInput<int>("最大值");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int res = 0;
		AddValueOutput("能量值", () => res);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			int oldValue = 0;
			AttributeProcessor.AddPowerValue(entityIDInput.value, maxValueInput.value, valueInput.value, out res, out oldValue);
			output.Call(f);
		});
	}
}
