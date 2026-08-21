using Config;
using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("应用队友奥义位置", 0)]
[Category("Logic/PosAndRot")]
[Description("应用队友奥义位置, 如果不是ai的话, 这个节点什么都不干")]
public class TeammateUniqueSkillPos : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int> angleInput = AddValueInput<Int>("角度");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityAIThink)
			{
				output.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget);
				int area;
				if (entityWithEntityID2 == null)
				{
					output.Call(f);
				}
				else if (!PathUtilities.IsOnGraph(entityWithEntityID2.entityShape.mShape.WorldPos, out area))
				{
					output.Call(f);
				}
				else
				{
					SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(CommonProcessor.GetWorldState().mLocalPlayerID);
					if (entityWithEntityID3 == null)
					{
						output.Call(f);
					}
					else
					{
						UniqueSkill config = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId);
						if (config == null || config.AiDistance <= 0)
						{
							output.Call(f);
						}
						else
						{
							bool num = CommonProcessor.GetWorldState().mRoomMembers[MemberPosition.Second].mEntityID == entityWithEntityID.entityID.mID;
							Int obj = angleInput.value;
							if (!num)
							{
								obj = 0 - obj;
							}
							Int3 vector = entityWithEntityID3.entityPositon.mPosition - entityWithEntityID2.entityShape.mShape.WorldPos;
							vector = IntMath.VectorOfAngle(IntMath.AngleOfVector(vector) - obj);
							vector.NormalizeTo(config.AiDistance);
							Int3 end = entityWithEntityID2.entityShape.mShape.WorldPos + vector;
							end = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID2.entityShape.mShape.WorldPos, end);
							entityWithEntityID.entityPositon.mPosition = end;
							if (end != entityWithEntityID2.entityShape.mShape.WorldPos)
							{
								entityWithEntityID.entityPositon.mForward = (end - entityWithEntityID2.entityShape.mShape.WorldPos).NormalizeTo(1000);
								entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
							}
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
