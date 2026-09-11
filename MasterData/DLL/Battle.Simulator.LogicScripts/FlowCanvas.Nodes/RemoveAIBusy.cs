using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("中断正在执行的ability", 0)]
[Category("Logic/Abilities")]
[Description("中断正在执行的ability")]
public class RemoveAIBusy : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.hasEntityActionAbility)
		{
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, 0, forceBroken: true);
		}
	}
}
