using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断平台", 0)]
[Category("Render/UI")]
[Description("判断平台")]
public class IsPCPlatform : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput outputPC = AddFlowOutput("PC");
		FlowOutput outputMo = AddFlowOutput("移动平台");
		AddFlowInput("", delegate(Flow f)
		{
			if (true)
			{
				outputPC.Call(f);
			}
			else
			{
				outputMo.Call(f);
			}
		});
	}
}
