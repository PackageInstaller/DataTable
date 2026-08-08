using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Variables")]
public abstract class VariableNode : FlowNode
{
	public abstract void SetVariable(object o);
}
