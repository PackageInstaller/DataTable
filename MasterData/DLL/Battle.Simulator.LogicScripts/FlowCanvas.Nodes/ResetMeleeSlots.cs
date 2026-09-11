using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除普攻槽（已过时）", 0)]
[Category("Logic/Abilities")]
[Description("将普攻槽中所有值置零")]
public class ResetMeleeSlots : CallableActionNode<int>
{
	public override void Invoke(int simEntityID)
	{
	}
}
