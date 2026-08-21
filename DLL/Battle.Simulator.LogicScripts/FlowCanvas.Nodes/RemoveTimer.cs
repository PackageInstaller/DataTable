using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除实体计时器或内置CD", 0)]
[Category("Logic/Buff")]
[Description("移除实体计时器，内置CD也能移除\n移除时会立刻发出计时器移除事件，同时【是否有内置CD或计时器】节点检测对应编号计时器时会输出False")]
public class RemoveTimer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> nameInput = AddValueInput<int>("计时器编号");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BuffProcessor.RemoveTimer(entityIDInput.value, nameInput.value);
			output.Call(f);
		});
	}
}
