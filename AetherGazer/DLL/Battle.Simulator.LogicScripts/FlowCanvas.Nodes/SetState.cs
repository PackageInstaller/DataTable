using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置状态", 0)]
[Category("Logic/Attribute")]
[Description("设置变身后的状态,出现的那只怪的位置朝向血量")]
public class SetState : CallableFunctionNode<int, int, Int3, Int3, int>
{
	public override int Invoke(int entityID, Int3 pos, Int3 forward, int hp)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		entityWithEntityID.entityPositon.mForward = forward;
		entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
		entityWithEntityID.entityPositon.mPosition = pos;
		entityWithEntityID.entityBlackboard.var.mHP = hp;
		return entityID;
	}
}
