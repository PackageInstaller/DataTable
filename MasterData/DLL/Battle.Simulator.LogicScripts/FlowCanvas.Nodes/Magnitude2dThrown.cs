using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算距离(抛掷物)(逻辑)", 0)]
[Category("Logic/Math")]
[Description("计算两个抛掷物之间的距离，单位mm\n任一抛掷物不存在时，返回-1")]
public class Magnitude2dThrown : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> vInA = AddValueInput<int>("抛掷物A");
		ValueInput<int> vInB = AddValueInput<int>("抛掷物B");
		AddValueOutput("距离", () => (ThrownProcessor.TryGetThrown(base.mSimContext, vInA.value, out var thrownState) && ThrownProcessor.TryGetThrown(base.mSimContext, vInB.value, out var thrownState2)) ? (thrownState.mPosition - thrownState2.mPosition).magnitude2D : (-1));
	}
}
