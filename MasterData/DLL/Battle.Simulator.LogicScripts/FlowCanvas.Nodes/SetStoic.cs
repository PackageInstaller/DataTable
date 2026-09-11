using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置是否霸体", 0)]
[Category("Logic/Attribute")]
[Description("设置是否霸體, 计数型的")]
public class SetStoic : CallableActionNode<int, bool>
{
	public override void Invoke(int entityID, bool isStoic)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
			if (isStoic)
			{
				entityWithEntityID.entityBlackboard.var.mIsStoic++;
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mIsStoic--;
			}
		}
	}
}
