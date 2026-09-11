using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行Ability(精简版)", 0)]
[Category("Logic/AI")]
[Description("指定AI做指定动作,返回传进来的实体ID")]
public class AIDoAbility : CallableFunctionNode<int, int, int, int, bool>
{
	public override int Invoke(int entityID, int abilityID, int startFrame, bool force)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		Int3 targetPostion = entityWithEntityID.entityPositon.mPosition + entityWithEntityID.entityPositon.mForward;
		entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = startFrame;
		AIProcessor.AIStartAttack(entityID, targetPostion, abilityID, force);
		return entityID;
	}
}
