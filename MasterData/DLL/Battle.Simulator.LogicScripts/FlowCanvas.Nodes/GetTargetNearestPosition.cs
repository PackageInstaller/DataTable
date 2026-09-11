using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到目标最近位置(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("从目标实体上得到距离实体最近碰撞盒的边缘点，距离为 实体中心到目标碰撞盒 - 目标碰撞盒半径")]
public class GetTargetNearestPosition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		Int3 targetPos = Int3.zero;
		long minDistance = 0L;
		ValueInput<int> originEntityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> targetEntityIDInput = AddValueInput<int>("目标实体ID", "targetEntityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			targetPos = Int3.zero;
			minDistance = 0L;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(originEntityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				targetPos = entityWithEntityID.entityPositon.mPosition;
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(targetEntityIDInput.value);
				if (entityWithEntityID2 == null)
				{
					errorOut.Call(f);
				}
				else
				{
					targetPos = entityWithEntityID2.entityPositon.mPosition;
					ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(entityWithEntityID, entityWithEntityID2, entityWithEntityID2.entityCamp.mRoleTypeCamp, out minDistance);
					if (nearestCollisionData == null)
					{
						errorOut.Call(f);
					}
					else
					{
						targetPos = entityWithEntityID.entityPositon.mPosition + (nearestCollisionData.WorldPos - entityWithEntityID.entityPositon.mPosition).NormalizeTo((int)minDistance);
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => originEntityIDInput.value);
		AddValueOutput("目标实体ID", "targetEntityID", () => targetEntityIDInput.value);
		AddValueOutput("位置", "position", () => targetPos);
		AddValueOutput("距离", "distance", () => minDistance);
	}
}
