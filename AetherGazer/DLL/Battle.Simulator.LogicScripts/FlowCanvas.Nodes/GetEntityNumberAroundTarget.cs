using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("周围的目标数量", 0)]
[Category("Logic/PosAndRot")]
[Description("获取目标周围可以选为目标的实体数量, 不要每一帧都调用")]
public class GetEntityNumberAroundTarget : FlowNode
{
	private HashSet<int> mEntityIDs = new HashSet<int>();

	private List<int> targets = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> rangeInput = AddValueInput<int>("范围");
		int targetNumber = 0;
		AddValueOutput("目标数量", () => targetNumber);
		FlowOutput noEntityOutput = AddFlowOutput("无对象");
		FlowOutput noTargetOutput = AddFlowOutput("无目标");
		FlowOutput output = AddFlowOutput("有目标");
		FlowOutput errorOutput = AddFlowOutput("实体为空");
		AddFlowInput("", delegate(Flow f)
		{
			mEntityIDs.Clear();
			targetNumber = 0;
			targets.Clear();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				SimPhysics.Overlap(entityWithEntityID.entityPositon.mPosition, rangeInput.value, targets, RoleCampProcessor.GetInterestCampWithoutBunkerAndAvoidShadow(entityWithEntityID.entityCamp.mRoleTypeCamp));
				if (targets.Count <= 0)
				{
					noEntityOutput.Call(f);
				}
				else
				{
					for (int i = 0; i < targets.Count; i++)
					{
						SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targets[i]);
						if (AIProcessor.CanLockOfEntity(simEntityByMultiColliders) && !mEntityIDs.Contains(simEntityByMultiColliders.creationIndex))
						{
							mEntityIDs.Add(simEntityByMultiColliders.creationIndex);
							targetNumber++;
						}
					}
					if (targetNumber > 0)
					{
						output.Call(f);
					}
					else
					{
						noTargetOutput.Call(f);
					}
				}
			}
		});
	}
}
