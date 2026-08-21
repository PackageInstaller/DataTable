using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("冲撞带人", 0)]
[Category("Logic/Abilities")]
[Description("冲撞带人")]
public class ImpactAndCapture : CallableActionNode<int, int>
{
	public override void Invoke(int simEntityID, int hitTargetID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		SimEntity entityWithEntityID2 = base.parentNode.mSimContext.GetEntityWithEntityID(hitTargetID);
		if (entityWithEntityID != null && entityWithEntityID2 != null)
		{
			MovementProcessor.Stop(entityWithEntityID2);
		}
	}
}
