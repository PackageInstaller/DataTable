using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置技能是否可以移动", 0)]
[Category("Logic/Abilities")]
[Description("设置技能移动是否可以移动")]
public class ActiveAbilityMovement : CallableActionNode<int, bool>
{
	public override void Invoke(int simEntityID, bool isEnable)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
		{
			entityWithEntityID.entityActionAbility.mEnableAbilityMovement = isEnable;
		}
	}
}
