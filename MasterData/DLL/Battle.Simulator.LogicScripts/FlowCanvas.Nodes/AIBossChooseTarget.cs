using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Boss选择目标", 0)]
[Category("Logic/AI")]
[Description("Boss选择目标")]
public class AIBossChooseTarget : FlowNode
{
	private List<int> targetBeAimNumber = new List<int>();

	private List<int> targetIDs = new List<int>();

	public int GetTarget(SimEntity entity, Int playerFactor)
	{
		targetBeAimNumber.Clear();
		targetIDs.Clear();
		int num = 0;
		Dictionary<int, int>.Enumerator enumerator = entity.entityBoss.value.GetEnumerator();
		while (enumerator.MoveNext())
		{
			num += enumerator.Current.Value;
		}
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		enumerator = entity.entityBoss.value.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int num5 = num - enumerator.Current.Value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Key);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityAIThink && num3 == 0)
			{
				num3 = enumerator.Current.Key;
				num2 = num5;
			}
			else
			{
				num4 += num5;
				targetBeAimNumber.Add(num5);
				targetIDs.Add(enumerator.Current.Key);
			}
		}
		int count = entity.entityBoss.value.Count;
		count = ((count <= 0) ? 1 : count);
		int num6 = 1000 / count;
		num6 = ((num2 + num4 == 0) ? (num6 + playerFactor.i) : ((1000 * num2 + playerFactor.i * (num2 + num4)) / (num2 + num4)));
		int result = 0;
		if (DRandom.Random(1000u) < num6)
		{
			return num3;
		}
		if (num4 > 0)
		{
			uint num7 = DRandom.Random((uint)num4);
			num = 0;
			for (int i = 0; i < targetBeAimNumber.Count; i++)
			{
				num += targetBeAimNumber[i];
				if (num7 < num)
				{
					result = targetIDs[i];
					break;
				}
			}
		}
		else
		{
			int index = (int)DRandom.Random((uint)targetBeAimNumber.Count);
			result = targetIDs[index];
		}
		return result;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		ValueInput<Int> playerFactor = AddValueInput<Int>("玩家被选中的最低几率").SetDefaultAndSerializedValue(500);
		FlowOutput trueOut = AddFlowOutput("目标有效");
		FlowOutput falseOut = AddFlowOutput("目标无效");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityBoss)
			{
				AIProcessor.ChangeTarget(entityWithEntityID, GetTarget(entityWithEntityID, playerFactor.value));
			}
			if (AIProcessor.CanLockOfEntity(CommonProcessor.GetSimEntityByMultiColliders(base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget))))
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
				targetID = simEntityByMultiColliders.creationIndex;
				trueOut.Call(f);
			}
			else
			{
				targetID = AIProcessor.TryGetAttackTarget(entityWithEntityID.creationIndex);
				if (targetID != 0)
				{
					SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(targetID);
					if (simEntityByMultiColliders2 != null)
					{
						targetID = simEntityByMultiColliders2.creationIndex;
						AIProcessor.ChangeTarget(entityWithEntityID, targetID);
					}
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
