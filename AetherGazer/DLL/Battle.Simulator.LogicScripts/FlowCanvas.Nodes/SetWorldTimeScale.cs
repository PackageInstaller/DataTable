using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置世界时间缩放", 0)]
[Category("Logic/Control")]
[Description("设置世界时间缩放(0 - 100)")]
public class SetWorldTimeScale : CallableActionNode<int>
{
	public override void Invoke(int scale)
	{
		if (!CommonProcessor.IsMultiplePlayerGameMode(base.parentNode.mSimContext) && ClientSimulator.Instance.SimTimeScale != scale)
		{
			ClientSimulator.Instance.SimTimeScale = scale;
		}
	}
}
