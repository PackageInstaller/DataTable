using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("从指定阵营里选取目标", 0)]
[Category("Logic/AI")]
[Description("从指定阵营里选取目标")]
public class GetAimTargetFromTargetCamp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("目标阵营");
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targetID);
			RoleType value = campInput.value;
			if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityCamp && simEntityByMultiColliders.entityCamp.mRoleTypeCamp == (uint)value)
			{
				output.Call(f);
			}
			else
			{
				SimEntity[] entities = base.mSimContext.GetEntities();
				Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
				long num = long.MaxValue;
				for (int i = 0; i < entities.Length; i++)
				{
					if (entities[i].hasEntityCamp && entities[i].entityCamp.mRoleTypeCamp == (uint)value && entities[i].hasEntityRemotePlayer)
					{
						SimEntity simEntity = entities[i];
						if (simEntity != null)
						{
							long sqrMagnitudeLong = (simEntity.entityPositon.mPosition - mPosition).sqrMagnitudeLong;
							if (sqrMagnitudeLong <= num && sqrMagnitudeLong != 0L && simEntity.hasEntityBlackboard && simEntity.entityBlackboard.var.mHP > 0)
							{
								targetID = simEntity.creationIndex;
								num = sqrMagnitudeLong;
							}
						}
					}
				}
				AIProcessor.ChangeTarget(entityWithEntityID, targetID);
				output.Call(f);
			}
		});
	}
}
