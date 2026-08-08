using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI向前移动", 0)]
[Category("Logic/AI")]
[Description("AI向前移动，朝着正前方移动, 不会看着目标")]
public class AIMoveByForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度因子");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = false;
				Int3 targetPosition = entityWithEntityID.entityPositon.mForward + entityWithEntityID.entityPositon.mPosition;
				AIProcessor.MoveAIDirection(entityIDInput.value, targetPosition, new VFactor(speedFactorInput.value, 100L));
				f.Call(output);
			}
		});
	}
}
