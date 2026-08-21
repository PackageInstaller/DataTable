using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("假的暂停界面", 0)]
[Category("Render/UI")]
[Description("弹一个假的暂停界面出来")]
public class PauseUIImitation : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			output.Call(f);
		});
	}
}
