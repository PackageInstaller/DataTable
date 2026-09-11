using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI选择目标(过时)", 0)]
[Category("Logic/AI")]
[Description("AI根据规则选择目标,参数都是正数")]
public class AIChooseTarget : FlowNode
{
	public bool IsEnemyOtherTarget(SimEntity entity, SimEntity enemy)
	{
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mAimTarget == enemy.creationIndex && entityWithEntityID.creationIndex != entity.creationIndex)
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
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mAimTarget == enemy.creationIndex && entityWithEntityID.creationIndex == entity.creationIndex)
			{
				return true;
			}
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> lowHpRatioInput = AddValueInput<int>("低血量修正系数");
		ValueInput<int> otherTargetRatioInput = AddValueInput<int>("他人目标修正系数");
		ValueInput<int> entityTargetRatioInput = AddValueInput<int>("自己目标修正系数");
		ValueInput<int> entityHurtRatioInput = AddValueInput<int>("对自己伤害修正系数");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			int num = 0;
			int value = lowHpRatioInput.value;
			int value2 = otherTargetRatioInput.value;
			int value3 = entityTargetRatioInput.value;
			_ = entityHurtRatioInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (entityWithEntityID2 != null && !entityWithEntityID2.hasEntityActionDeath)
				{
					VFactor vFactor = new VFactor
					{
						nom = entityWithEntityID2.entityBlackboard.var.mMaxHP - entityWithEntityID2.entityBlackboard.var.mHP,
						den = entityWithEntityID2.entityBlackboard.var.mMaxHP
					};
					vFactor = 100 * (vFactor * value + 1L);
					if (IsEnemyOtherTarget(entityWithEntityID, entityWithEntityID2))
					{
						vFactor *= new VFactor
						{
							nom = 100 - value2,
							den = 100L
						};
					}
					if (IsEnemyEntityTarget(entityWithEntityID, entityWithEntityID2))
					{
						vFactor *= new VFactor
						{
							nom = 100 + value3,
							den = 100L
						};
					}
					if (num < vFactor.integer)
					{
						num = vFactor.integer;
						targetID = entityWithEntityID2.creationIndex;
					}
				}
			}
			AIProcessor.ChangeTarget(entityWithEntityID, targetID);
			output.Call(f);
		});
	}
}
