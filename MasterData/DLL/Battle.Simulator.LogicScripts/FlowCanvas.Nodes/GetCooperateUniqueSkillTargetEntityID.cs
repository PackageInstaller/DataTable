using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到连携奥义释放目标(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("默认使用本地玩家的目标作为目标,如果本地玩家无目标,则取发起者的目标,如果再没有则取发起者最近的目标")]
public class GetCooperateUniqueSkillTargetEntityID : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _LocalPlayerEntityID;

	private int _TargetID;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity simEntity = null;
			_LocalPlayerEntityID = CommonProcessor.GetWorldState().mLocalPlayerID;
			_TargetID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_LocalPlayerEntityID);
			if (entityWithEntityID == null && !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else
			{
				EntityBlackboard entityBlackboard = entityWithEntityID.entityBlackboard;
				if (entityBlackboard.var.hasManualLock)
				{
					_TargetID = entityBlackboard.var.mLastTarget;
					if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
					{
						_TargetID = 0;
					}
				}
				if (_TargetID == 0)
				{
					_TargetID = entityBlackboard.var.mAimTarget;
					if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
					{
						_TargetID = 0;
					}
				}
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
				if (simEntityByMultiColliders != null)
				{
					_TargetID = simEntityByMultiColliders.creationIndex;
					_Out.Call(f);
				}
				else
				{
					entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
					if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
					{
						_Error.Call(f);
					}
					else
					{
						entityBlackboard = entityWithEntityID.entityBlackboard;
						if (entityBlackboard.var.hasManualLock)
						{
							_TargetID = entityBlackboard.var.mLastTarget;
							if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
							{
								_TargetID = 0;
							}
						}
						if (_TargetID == 0)
						{
							_TargetID = entityBlackboard.var.mAimTarget;
							if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
							{
								_TargetID = 0;
							}
						}
						simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
						if (simEntityByMultiColliders != null)
						{
							_TargetID = simEntityByMultiColliders.creationIndex;
							_Out.Call(f);
						}
						else
						{
							_TargetID = AbilitiesProcessor.LockBestTarget(entityWithEntityID);
							simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(_TargetID);
							if (simEntityByMultiColliders != null)
							{
								_TargetID = simEntityByMultiColliders.creationIndex;
							}
							if (!CommonProcessor.TryGetAliveRole(base.mSimContext, _TargetID, out simEntity))
							{
								_TargetID = 0;
							}
							_Out.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("目标实体ID", "targetEntityID", () => _TargetID);
	}
}
