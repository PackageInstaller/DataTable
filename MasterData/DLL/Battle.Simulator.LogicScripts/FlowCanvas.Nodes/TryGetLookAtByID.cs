using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("尝试获取锁定目标(通过ID)", 0)]
[Category("Logic/AI")]
[Description("尝试获取锁定目标")]
public class TryGetLookAtByID : FlowNode
{
	private int _lockID;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("锁定对像", "LockID", () => _lockID);
		FlowOutput trueOutput = AddFlowOutput("True");
		FlowOutput falseOutput = AddFlowOutput("False");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(roleIDInput.value);
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
			{
				if (entityWithEntityID.entityBlackboard.var.hasManualLock)
				{
					_lockID = entityWithEntityID.entityBlackboard.var.mLastTarget;
				}
				else
				{
					_lockID = entityWithEntityID.entityBlackboard.var.mAimTarget;
				}
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_lockID);
				if (simEntityByMultiColliders != null)
				{
					_lockID = simEntityByMultiColliders.creationIndex;
				}
				if (_lockID == 0 || !CommonProcessor.IsAliveRole(base.mSimContext.GetEntityWithEntityID(_lockID)))
				{
					falseOutput.Call(f);
				}
				else
				{
					trueOutput.Call(f);
				}
			}
			else
			{
				falseOutput.Call(f);
			}
		});
	}
}
