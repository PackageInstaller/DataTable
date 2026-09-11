using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置胜利(过时)", 0)]
[Category("Logic/Control")]
[Description("设置胜利")]
public class SetVictory : CallableActionNode<int, bool>
{
	public override void Invoke(int abilityID, bool isVictory)
	{
	}
}
