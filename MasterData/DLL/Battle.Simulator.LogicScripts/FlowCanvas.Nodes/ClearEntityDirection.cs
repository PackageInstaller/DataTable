using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除实体转向角度(跑酷用)", 0)]
[Category("Logic/PosAndRot")]
[Description("清除实体转向角度，将其转向角度设置为实体朝向正前方，即移动只保留速度不保留方向")]
[ExposeAsDefinition]
public class ClearEntityDirection : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			entityWithEntityID.entityActionMoveDirection.mDirection = entityWithEntityID.entityPositon.mForward.NormalizeTo(1000);
		}
	}
}
