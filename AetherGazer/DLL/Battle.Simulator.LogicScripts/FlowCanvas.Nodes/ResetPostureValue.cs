using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置霸体值(过时)", 0)]
[Category("Logic/Attribute")]
[Description("重置架势条, 如果没有的话则添加霸体值组件, 如果之前已经有了的话, 最大值就是没有意义的")]
public class ResetPostureValue : FlowNode
{
	protected override void RegisterPorts()
	{
	}
}
