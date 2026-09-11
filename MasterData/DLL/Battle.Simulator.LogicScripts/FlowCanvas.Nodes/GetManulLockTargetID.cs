using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取手动锁定的实体ID", 0)]
[Category("Logic/AI")]
[Description("获取手动锁定的实体ID")]
public class GetManulLockTargetID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体Id", () => entityID);
		int res = 0;
		AddValueOutput("结果", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			res = 0;
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				falseOut.Call(f);
			}
			else if (entityWithEntityID.entityBlackboard.var.hasManualLock)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mLastTarget);
				if (simEntityByMultiColliders == null)
				{
					falseOut.Call(f);
				}
				else
				{
					res = simEntityByMultiColliders.creationIndex;
					trueOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
