using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI靠近攻击(后3位)", 0)]
[Category("Logic/AI")]
[Description("AI靠近攻击, 如果范围填0的话, 会取第一个hit的距离的70%")]
public class AIApproachAttackWithShortAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> rangeInput = AddValueInput<int>("范围").SetDefaultAndSerializedValue(0);
		ValueInput<int> buttonIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<bool> forceInput = AddValueInput<bool>("强制执行");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityPositon)
			{
				f.Call(falseOut);
			}
			else
			{
				int abilityID = entityWithEntityID.entityConfig.mId * 1000 + buttonIDInput.value;
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (entityWithEntityID2 == null || !entityWithEntityID2.hasEntityPositon)
				{
					f.Call(falseOut);
				}
				else
				{
					int num = rangeInput.value;
					if (num == 0)
					{
						num = (int)((float)CommonNodeFunction.GetTargetAbilityFirstHitRange(abilityID) * 0.7f);
					}
					if (!AIProcessor.IsTargetInRange(entityWithEntityID, num))
					{
						Int3 targetPosition = AIProcessor.GetTargetPosition(entityWithEntityID);
						AIProcessor.MoveAIDirection(entityWithEntityID.creationIndex, targetPosition, new VFactor(speedFactorInput.value, 100L));
						f.Call(falseOut);
					}
					else
					{
						AIProcessor.StopAIMovement(entityIDInput.value);
						Int3 targetPostion = entityWithEntityID.entityPositon.mPosition + entityWithEntityID.entityPositon.mForward;
						AIProcessor.AIStartAttack(entityWithEntityID.creationIndex, targetPostion, abilityID, forceInput.value);
						f.Call(trueOut);
					}
				}
			}
		});
	}
}
