using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI获取目标", 0)]
[Category("Logic/AI")]
[Description("AI尝试获取目标, 玩家方AI获取目标, 如果是敌人的话, 就选最近的")]
public class AITryGetTarget : FlowControlNode
{
	public bool IsEnemyOtherTarget(SimEntity entity, SimEntity enemy)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget) == enemy && entityWithEntityID.creationIndex != entity.creationIndex)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsEnemyEntityTarget(SimEntity entity, SimEntity enemy)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget) == enemy && entityWithEntityID.creationIndex == entity.creationIndex)
			{
				return true;
			}
		}
		return false;
	}

	private bool ChooseTarget(SimEntity entity)
	{
		int entityID = 0;
		if (RoleCampProcessor.IsPlayer(entity.entityCamp.mRoleTypeCamp))
		{
			int num = 0;
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2210, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2211, out var baseValue2, out plusValue, out tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2212, out var baseValue3, out plusValue, out tempPlusValue);
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					VFactor vFactor = new VFactor
					{
						nom = entityWithEntityID.entityBlackboard.var.mMaxHP - entityWithEntityID.entityBlackboard.var.mHP,
						den = entityWithEntityID.entityBlackboard.var.mMaxHP
					};
					vFactor = 100 * (vFactor * baseValue + 1L);
					if (IsEnemyOtherTarget(entity, entityWithEntityID))
					{
						vFactor *= new VFactor
						{
							nom = 100 - baseValue2,
							den = 100L
						};
					}
					if (IsEnemyEntityTarget(entity, entityWithEntityID))
					{
						vFactor *= new VFactor
						{
							nom = 100 + baseValue3,
							den = 100L
						};
					}
					if (num < vFactor.integer)
					{
						num = vFactor.integer;
						entityID = entityWithEntityID.creationIndex;
					}
				}
			}
		}
		else
		{
			entityID = AIProcessor.TryGetAttackTarget(entity.creationIndex);
		}
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityID);
		if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mHP > 0)
		{
			AIProcessor.ChangeTarget(entity, simEntityByMultiColliders.creationIndex);
			return true;
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("成功");
		FlowOutput falseOut = AddFlowOutput("失败");
		int targetID = 0;
		AddValueOutput("实体ID", () => entityID.value);
		AddValueOutput("目标ID", () => targetID);
		AddFlowInput("in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (ChooseTarget(entityWithEntityID))
			{
				targetID = entityWithEntityID.entityBlackboard.var.mAimTarget;
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targetID);
				if (simEntityByMultiColliders != null)
				{
					targetID = simEntityByMultiColliders.creationIndex;
				}
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
