using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("1194一技能循环逻辑", 0)]
[Category("Logic/角色定制/1194")]
[Description("1194一技能循环逻辑")]
public class CustomFunction1194_1 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> loopTimesBlackBoardID = AddValueInput<int>("循环次数黑板ID", "loopTimesBlackBoardID");
		ValueInput<int> logicTime = AddValueInput<int>("时间(毫秒)", "logicTime");
		ValueInput<int> loopSkillID = AddValueInput<int>("循环技能ID", "loopSkillID");
		ValueInput<int> loopSkillStartFrame = AddValueInput<int>("循环技能起始帧数", "loopSkillStartFrame");
		ValueInput<int> loopSkillEndFrame = AddValueInput<int>("循环技能结束帧数", "loopSkillEndFrame");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonTypeInput").SetDefaultAndSerializedValue(ButtonType.MELEE);
		ValueInput<int> consumeValue = AddValueInput<int>("每跳消耗机制值", "consumeValue");
		ValueInput<bool> fixValue = AddValueInput<bool>("是否考虑消耗减免", "fixValue").SetDefaultAndSerializedValue(v: true);
		ValueInput<List<int>> consumeFrame = AddValueInput<List<int>>("消耗帧数", "consumeFrame");
		ValueInput<int> finishSkillID = AddValueInput<int>("结束技能ID", "finishSkillID");
		int times = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput tickOut = AddFlowOutput("Tick", "tick");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				int mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
				if (!entityWithEntityID.hasEntityActionAbility)
				{
					errorOut.Call(f);
				}
				else
				{
					int num = logicTime.value / CommonProcessor.GetConfigInterval();
					bool flag = false;
					int abilityID = 0;
					int mNewAbilityStartFrame = 0;
					AttributeProcessor.GetAttributeWithIntName(mAttributeID, loopTimesBlackBoardID.value, out var baseValue, out var _, out var _);
					times = (int)baseValue;
					if (num == 0)
					{
						times++;
						AttributeProcessor.SetAttributeWithIntName(mAttributeID, loopTimesBlackBoardID.value, times, 0L, 0L);
					}
					if (consumeFrame.value.Contains(num) && CompareEnergy(entityWithEntityID, consumeValue.value, fixValue.value))
					{
						int energyChangeValue = -consumeValue.value;
						EnergyType mEnergyType = entityWithEntityID.entityBlackboard.var.mEnergyType;
						if (fixValue.value)
						{
							if (mEnergyType == EnergyType.Mark && energyChangeValue < 0)
							{
								long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(mAttributeID, 1108, AttributeCalcType.Add);
								if (DRandom.Random(1000u) < finalAttributeByAttributeID)
								{
									energyChangeValue++;
								}
							}
							AttributeProcessor.CalcConsumeByAttribute(energyChangeValue, mAttributeID, mEnergyType, out energyChangeValue, out var _);
						}
						AttributeProcessor.TryAddPowerValue(entityWithEntityID, energyChangeValue * 1000, out var newValue, out var oldValue);
						AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
						if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
						{
							base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID.value, newValue, oldValue, maxValue, maxValue, mEnergyType);
						}
						tickOut.Call(f);
					}
					if (num < loopSkillEndFrame.value)
					{
						if (times > 1 && !entityWithEntityID.entityBlackboard.var.IsOnPressDownBtnID((int)buttonTypeInput.GetValue()))
						{
							abilityID = finishSkillID.value;
							mNewAbilityStartFrame = 0;
							flag = true;
						}
					}
					else
					{
						flag = true;
						if (entityWithEntityID.entityBlackboard.var.IsOnPressDownBtnID((int)buttonTypeInput.GetValue()) && CompareEnergy(entityWithEntityID, consumeValue.value, fixValue.value))
						{
							abilityID = loopSkillID.value;
							mNewAbilityStartFrame = loopSkillStartFrame.value;
						}
						else
						{
							abilityID = finishSkillID.value;
							mNewAbilityStartFrame = 0;
						}
					}
					if (flag)
					{
						AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, forceBroken: true);
						entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = mNewAbilityStartFrame;
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityID.value);
		AddValueOutput("循环次数", "times", () => times);
	}

	protected bool CompareEnergy(SimEntity entity, int consumeValue, bool fixValue)
	{
		int num = consumeValue;
		if (fixValue)
		{
			AttributeProcessor.CalcConsumeByAttribute(-consumeValue, entity.entityBlackboard.var.mAttributeID, entity.entityBlackboard.var.mEnergyType, out var energyChangeValue, out var _);
			num = -energyChangeValue;
		}
		return AttributeProcessor.GetPowerValue(entity.entityBlackboard.var.mEntityID) >= num;
	}
}
