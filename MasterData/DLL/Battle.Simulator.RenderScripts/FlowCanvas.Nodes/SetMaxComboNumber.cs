using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置最大连击数(过时)", 0)]
[Category("Logic/UI")]
[Description("设置最大连击数,给3星条件和成就用的")]
public class SetMaxComboNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueInput<int>("当前连击数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			output.Call(f);
		});
	}
}
