using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置概率(随时间增加)节点(已过时)", 0)]
[Category("Logic/Control")]
[Description("概率(随时间增加)节点，会随时间增加概率，使用此节点会强制重置概率")]
public class RandomTimerReset : FlowNode
{
	protected override void RegisterPorts()
	{
	}
}
