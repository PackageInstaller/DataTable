using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用或关闭技能", 0)]
[Category("Logic/Abilities")]
[Description("启用或关闭技能，计数统计")]
public class EnableAbility : CallableActionNode<int, int, bool>
{
	public override void Invoke(int simEntityID, int id, bool isEnable)
	{
		base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID)?.entityBlackboard.var.EnableAbility(id, isEnable);
	}
}
