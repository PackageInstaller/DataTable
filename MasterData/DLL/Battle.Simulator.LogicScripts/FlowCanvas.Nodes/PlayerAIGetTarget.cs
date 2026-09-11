using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("玩家AI获取目标", 0)]
[Category("Logic/AI")]
[Description("玩家AI获取目标")]
public class PlayerAIGetTarget : FlowNode
{
	private List<int> targets = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> distanceInput = AddValueInput<int>("半径");
		FlowOutput output = AddFlowOutput("成功");
		FlowOutput tooFarOutput = AddFlowOutput("距离过大");
		FlowOutput noEntityOutput = AddFlowOutput("无对象");
		FlowOutput noTargetOutput = AddFlowOutput("无目标");
		AddFlowInput("", delegate(Flow f)
		{
			targets.Clear();
			int mLocalPlayerID = CommonProcessor.GetWorldState().mLocalPlayerID;
			SimEntity simEntity = base.mSimContext.GetEntityWithEntityID(mLocalPlayerID);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2214, out var baseValue, out var _, out var _);
			if (baseValue > 0 && simEntity == null)
			{
				simEntity = entityWithEntityID;
			}
			if (simEntity != null && entityWithEntityID != null)
			{
				long num = distanceInput.value;
				if ((simEntity.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).sqrMagnitudeLong > num * num)
				{
					tooFarOutput.Call(f);
				}
				else
				{
					SimPhysics.Overlap(simEntity.entityPositon.mPosition, (int)num, targets, RoleCampProcessor.GetInterestCampWithoutBunkerAndAvoidShadow(simEntity.entityCamp.mRoleTypeCamp));
					if (targets.Count <= 0)
					{
						noEntityOutput.Call(f);
					}
					else
					{
						long num2 = long.MaxValue;
						int num3 = int.MinValue;
						int num4 = 0;
						for (int i = 0; i < targets.Count; i++)
						{
							SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targets[i]);
							if (AIProcessor.CanLockOfEntity(simEntityByMultiColliders))
							{
								AttributeProcessor.GetAttributeWithIntName(simEntityByMultiColliders.entityBlackboard.var.mAttributeID, 2172, out var baseValue2, out var _, out var _);
								long sqrMagnitudeLong = (simEntityByMultiColliders.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).sqrMagnitudeLong;
								if (baseValue2 > num3)
								{
									num3 = (int)baseValue2;
									num4 = simEntityByMultiColliders.creationIndex;
									num2 = sqrMagnitudeLong;
								}
								else if (baseValue2 == num3 && sqrMagnitudeLong < num2)
								{
									num4 = simEntityByMultiColliders.creationIndex;
									num2 = sqrMagnitudeLong;
								}
							}
						}
						if (num4 == 0)
						{
							noTargetOutput.Call(f);
						}
						else
						{
							AIProcessor.ChangeTarget(entityWithEntityID, num4);
							output.Call(f);
						}
					}
				}
			}
			else
			{
				noEntityOutput.Call(f);
			}
		});
	}
}
