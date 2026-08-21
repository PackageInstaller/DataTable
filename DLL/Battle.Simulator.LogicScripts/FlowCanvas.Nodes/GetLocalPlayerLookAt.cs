using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到本地玩家锁定目标(逻辑)", 0)]
[Category("Logic/AI")]
[Description("得到本地玩家的锁定目标,优先尝试获取手动锁定目标,当没有在手动锁定状态时候,则获取自动锁定目标\n若最终得到的目标已死亡，则输出无目标")]
public class GetLocalPlayerLookAt : FlowControlNode
{
	private FlowOutput _Out;

	private FlowOutput _False;

	private int _LocalPlayerEntityID;

	private int _TargetID;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("有目标", "output");
		_False = AddFlowOutput("无目标", "false");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_LocalPlayerEntityID = CommonProcessor.GetWorldState().mLocalPlayerID;
			_TargetID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_LocalPlayerEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				EntityBlackboard entityBlackboard = entityWithEntityID.entityBlackboard;
				if (entityBlackboard.var.hasManualLock)
				{
					_TargetID = entityBlackboard.var.mLastTarget;
				}
				if (_TargetID == 0)
				{
					_TargetID = entityBlackboard.var.mAimTarget;
				}
			}
			if (_TargetID != 0)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mHP > 0)
				{
					_TargetID = simEntityByMultiColliders.creationIndex;
					_Out.Call(f);
					return;
				}
			}
			_False.Call(f);
		});
		AddValueOutput("目标", "targetID", () => _TargetID);
		AddValueOutput("本地玩家实体ID", "entityID", () => _LocalPlayerEntityID);
	}
}
