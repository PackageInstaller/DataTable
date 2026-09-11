using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("尝试获取锁定目标(自动查找)(逻辑)", 0)]
[Category("Logic/AI")]
[Description("获取获取自动锁定的目标,无目标则自动查找")]
public class TryGetTargetID : FlowControlNode
{
	private int _TargetID;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("锁定对像", "LockID", () => _TargetID);
		FlowOutput hasTargetOutput = AddFlowOutput("有目标", "hasTarget");
		FlowOutput nonTargetOutput = AddFlowOutput("无目标", "nonTarget");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(roleIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				m_error.Call(f);
			}
			else
			{
				SimEntity simEntity = null;
				_TargetID = 0;
				_TargetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
				if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
				{
					_TargetID = AbilitiesProcessor.LockBestTarget(entityWithEntityID);
				}
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
				if (simEntityByMultiColliders != null)
				{
					_TargetID = simEntityByMultiColliders.creationIndex;
					hasTargetOutput.Call(f);
				}
				else
				{
					nonTargetOutput.Call(f);
				}
			}
		});
	}
}
