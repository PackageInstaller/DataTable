using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("小怪决策", 0)]
[Category("Logic/AI")]
[Description("AI决策现在该干什么,在里面会重置对峙时间(如果不走对峙的话)")]
public class AIDecision2 : FlowNode
{
	private bool FindTargetInViewRange(SimEntity entity, int viewRange)
	{
		bool result = true;
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.Overlap(entity.entityPositon.mPosition, viewRange, list, RoleCampProcessor.GetInterestCamp(entity.entityCamp.mRoleTypeCamp));
		if (list == null || list.Count == 0)
		{
			result = false;
		}
		else
		{
			AbilitiesProcessor.SetAimTargetAndNearestPart(entity, GetTarget(entity));
		}
		FrameListPool<int>.Release(list);
		return result;
	}

	public int GetTarget(SimEntity entity)
	{
		int num = AIProcessor.TryGetAttackTarget(entity.creationIndex);
		return CommonProcessor.GetSimEntityByMultiColliders(num)?.creationIndex ?? num;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> viewRangeInput = AddValueInput<int>("视野范围");
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput dying = AddFlowOutput("HP<0");
		FlowOutput busying = AddFlowOutput("执行技能中");
		FlowOutput hurting = AddFlowOutput("受击中");
		FlowOutput notFoundTarget = AddFlowOutput("没有发现目标");
		FlowOutput findTarget = AddFlowOutput("发现目标那一帧");
		FlowOutput idle = AddFlowOutput("对峙");
		FlowOutput attack = AddFlowOutput("攻击");
		FlowOutput approach = AddFlowOutput("追击");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				Debug.Log("实体或黑板为空");
			}
			else
			{
				_ = entityWithEntityID.entityBlackboard.var.mAttributeID;
				if (entityWithEntityID.entityBlackboard.var.mHP <= 0)
				{
					dying.Call(f);
				}
				else if (AIProcessor.IsAIBusying(value))
				{
					busying.Call(f);
				}
				else if (AIProcessor.IsAIHurting(value))
				{
					hurting.Call(f);
				}
				else
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2208, out var baseValue, out var _, out var _);
					if (CommonProcessor.GetWorldState().whoAttackRoles.TryGetValue((int)baseValue, out var value2))
					{
						value2.Remove(value);
					}
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2208, 0L, 0L, 0L);
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, out var baseValue2, out var _, out var _);
					switch ((EnemyAIStateEnum)baseValue2)
					{
					case EnemyAIStateEnum.NoTarget:
					{
						int num = viewRangeInput.value;
						if (num == 0)
						{
							num = 200000;
						}
						if (FindTargetInViewRange(entityWithEntityID, num))
						{
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
							targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
							SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(targetID);
							if (simEntityByMultiColliders2 != null)
							{
								targetID = simEntityByMultiColliders2.creationIndex;
							}
							findTarget.Call(f);
						}
						else
						{
							notFoundTarget.Call(f);
						}
						break;
					}
					case EnemyAIStateEnum.Facing:
						if (!AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							AIProcessor.ChangeTarget(entityWithEntityID, GetTarget(entityWithEntityID));
						}
						if (AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
							SimEntity simEntityByMultiColliders3 = CommonProcessor.GetSimEntityByMultiColliders(targetID);
							if (simEntityByMultiColliders3 != null)
							{
								targetID = simEntityByMultiColliders3.creationIndex;
							}
							idle.Call(f);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 1L, 0L, 0L);
						}
						break;
					case EnemyAIStateEnum.PrepareAttack:
						if (!AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							AIProcessor.ChangeTarget(entityWithEntityID, GetTarget(entityWithEntityID));
						}
						if (AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
							SimEntity simEntityByMultiColliders4 = CommonProcessor.GetSimEntityByMultiColliders(targetID);
							if (simEntityByMultiColliders4 != null)
							{
								targetID = simEntityByMultiColliders4.creationIndex;
							}
							approach.Call(f);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 2L, 0L, 0L);
						}
						break;
					case EnemyAIStateEnum.Attack:
						if (!AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							AIProcessor.ChangeTarget(entityWithEntityID, GetTarget(entityWithEntityID));
						}
						if (AIProcessor.AICheckTargetValid(value, entityWithEntityID.entityBlackboard.var.mAimTarget))
						{
							targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
							SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targetID);
							if (simEntityByMultiColliders != null)
							{
								targetID = simEntityByMultiColliders.creationIndex;
							}
							attack.Call(f);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 3L, 0L, 0L);
						}
						break;
					}
				}
			}
		});
	}
}
