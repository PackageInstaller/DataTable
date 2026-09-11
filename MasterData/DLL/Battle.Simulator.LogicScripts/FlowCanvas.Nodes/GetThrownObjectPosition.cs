using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取抛掷物实体位置", 0)]
[Category("Logic/抛掷物")]
[Description("获取抛掷物实体位置")]
public class GetThrownObjectPosition : CallableFunctionNode<Int3, int>
{
	public override Int3 Invoke(int thrownID)
	{
		ThrownState thrownState = null;
		if (!ThrownProcessor.TryGetThrown(base.parentNode.mSimContext, thrownID, out thrownState))
		{
			return Int3.zero;
		}
		return thrownState.mPosition;
	}
}
