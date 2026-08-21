using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置受击时间缩放", 0)]
[Category("Logic/Control")]
[Description("设置受击时间缩放(0 - 100)")]
public class SetEntityHitRecoverTimeScale : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int scale)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityHitRecover)
		{
			entityWithEntityID.entityHitRecover.mTimeScale = scale;
		}
	}
}
