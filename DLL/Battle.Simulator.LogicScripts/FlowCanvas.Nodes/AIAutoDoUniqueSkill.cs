using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AI自动释放奥义", 0)]
[Category("Logic/AI")]
[Description("0.完全没带芯片，不会自动释放奥义，规则同线上\n1.单人奥义：AI携带芯片，自动释放奥义\n2.连携奥义：AI携带芯片+AI携带芯片，自动释放奥义\n3.连携奥义：AI携带芯片+AI不携带芯片，自动释放奥义\n4.连携奥义：主控+AI，不自动释放奥义")]
public class AIAutoDoUniqueSkill : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> chipIDInput = AddValueInput<int>("芯片ID", "chipID");
		ValueInput<int> actionID = AddValueInput<int>("指令集ID");
		ValueInput<int> maxInput = AddValueInput<int>("最大芯片数量").SetDefaultAndSerializedValue(20);
		FlowOutput trueOutput = AddFlowOutput("true", "trueOut");
		FlowOutput falseOutput = AddFlowOutput("false", "falseOut");
		FlowOutput errorOutput = AddFlowOutput("error", "errorOut");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("芯片ID", () => chipIDInput.value);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			int value = maxInput.value;
			int value2 = chipIDInput.value;
			_ = actionID.value;
			bool flag = false;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int num = CommonProcessor.GetWorldState().mLocalPlayerID;
			if (num == 0)
			{
				Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
				RemoteMember value3 = null;
				if (mRoomMembers.TryGetValue(MemberPosition.First, out value3))
				{
					num = value3.mEntityID;
				}
			}
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(num);
			if (entityWithEntityID == null || entityWithEntityID2 == null)
			{
				Debug.LogError("图：" + base.graph.name + "里《AI自动释放奥义》节点的实体或本地实体为空");
				errorOutput.Call(f);
			}
			else
			{
				for (int i = 0; i < value; i++)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2130 + i, out var baseValue, out var _, out var _);
					if (baseValue == 0L)
					{
						break;
					}
					if (value2 == baseValue)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					falseOutput.Call(f);
				}
				else if (value2 != 0)
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(value2, out var _))
					{
						Debug.LogError("图：" + base.graph.name + "里《AI自动释放奥义》节点的芯片ID在ai_chip表里查询不到");
						errorOutput.Call(f);
					}
					else if (CommonProcessor.IsSinglePlayerGameMode(base.mSimContext))
					{
						if (!entityWithEntityID.hasEntityUniqueSkillEnergy || !ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out var config2) || entityWithEntityID.entityUniqueSkillEnergy.mValue < entityWithEntityID.entityUniqueSkillEnergy.mMaxValue || !AttributeProcessor.IsEnableAbility(entityWithEntityID, config2.AbilityId.get_Item(0)) || (CDProcessor.GetCD(entityWithEntityID, config2.AbilityId.get_Item(0), out var abilityCD) && abilityCD.CD > 0))
						{
							falseOutput.Call(f);
						}
						else
						{
							SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
							if (!entityWithEntityID.hasEntityBlackboard || simWorldState.m_CooperateUniqueSkillID == 0 || !ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out var config3) || simWorldState.m_cooperateUniqueSkillIsActive <= 0)
							{
								if (AIProcessor.AIHasAttackTarget(entityIDInput.value))
								{
									trueOutput.Call(f);
								}
								else
								{
									falseOutput.Call(f);
								}
							}
							else if (config3.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
							{
								if (!entityWithEntityID2.hasEntityBlackboard)
								{
									trueOutput.Call(f);
								}
								else if (config3.CooperateRoleIds.Contains(entityWithEntityID2.entityConfig.mId))
								{
									falseOutput.Call(f);
								}
								else
								{
									trueOutput.Call(f);
								}
							}
							else if (AIProcessor.AIHasAttackTarget(entityIDInput.value))
							{
								trueOutput.Call(f);
							}
							else
							{
								falseOutput.Call(f);
							}
						}
					}
					else
					{
						CommonProcessor.IsMultiplePlayerGameMode(base.mSimContext);
						falseOutput.Call(f);
					}
				}
			}
		});
	}

	private void AIInteruptActionWithCmd(int commandSetID, SimEntity ai)
	{
		if (ai.entityAIThink.mCurrentCommand != null && (ai.entityAIThink.mCurrentCommand.mID == commandSetID || commandSetID == 0) && ai.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Running)
		{
			ai.entityAIThink.mCurrentCommand.mForceInterruptSelf = true;
			ai.entityAIThink.mCurrentCommand.mStatus = AIProcessor.AICommandStatus.Failed;
		}
		ai.entityAIThink.mReevalute = true;
	}
}
