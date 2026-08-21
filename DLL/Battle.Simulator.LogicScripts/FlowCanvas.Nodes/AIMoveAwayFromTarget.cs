using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI远离目标移动", 0)]
[Category("Logic/AI")]
[Description("AI向目标移动，移动时会看着目标")]
public class AIMoveAwayFromTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度百分比");
		ValueInput<bool> lookatInput = AddValueInput<bool>("是否看着目标");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityPositon)
				{
					Int3 @int = (entityWithEntityID.entityPositon.mPosition - simEntityByMultiColliders.entityPositon.mPosition).NormalizeTo(1000);
					Int3 targetPosition = entityWithEntityID.entityPositon.mPosition + @int;
					entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = lookatInput.value;
					AIProcessor.MoveAIDirection(entityWithEntityID.creationIndex, targetPosition, new VFactor(speedFactorInput.value, 100L));
				}
			}
			f.Call(output);
		});
	}
}
