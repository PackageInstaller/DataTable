using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("目标是否有效", 0)]
[Category("Logic/AI")]
[Description("目标是否有效")]
public class IsEntityTargetValid : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int res = 0;
		AddValueOutput("目标ID", () => res);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mHP > 0)
				{
					res = simEntityByMultiColliders.creationIndex;
					trueOut.Call(f);
					return;
				}
			}
			falseOut.Call(f);
		});
	}
}
