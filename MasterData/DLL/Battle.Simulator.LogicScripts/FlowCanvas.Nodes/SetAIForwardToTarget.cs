using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI朝向目标", 0)]
[Category("Logic/PosAndRot")]
[Description("就是把实体朝向改成朝着目标的朝向")]
public class SetAIForwardToTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon && entityWithEntityID.hasEntityBlackboard)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityPositon)
				{
					Int3 mForward = (simEntityByMultiColliders.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
					entityWithEntityID.entityPositon.mForward = mForward;
					entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
				}
			}
			f.Call(output);
		});
	}
}
