using System;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中修改破防值(争议)", 0)]
[Category("Logic/Attribute")]
[Description("命中修改破防值，与伤害判定，存在争议，故先暂时不使用，等待后续讨论出更合适的方案后推进")]
public class HitAddBreakValue2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> attackerIDInput = AddValueInput<int>("攻击者ID", "attackerID");
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者ID", "targetID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID", "abilityID");
		ValueInput<long> damageValueInput = AddValueInput<long>("伤害值", "damageValue");
		ValueInput<int> sameRateInput = AddValueInput<int>("相同属性系数", "sameRate").SetDefaultAndSerializedValue(1000);
		ValueInput<int> differentRateInput = AddValueInput<int>("不同属性系数", "differentRate").SetDefaultAndSerializedValue(800);
		ValueInput<int> baseValueInput = AddValueInput<int>("系数基数", "baseValue").SetDefaultAndSerializedValue(1000);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput notComOut = AddFlowOutput("无破防", "notCom");
		FlowOutput dontBreakOut = AddFlowOutput("不可破防", "dontBreak");
		FlowOutput inBreakOut = AddFlowOutput("破防中", "inBreak");
		FlowOutput inCDOut = AddFlowOutput("破防保护中", "inCD");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(attackerIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
				if (entityWithEntityID2 == null || !entityWithEntityID2.hasEntityBlackboard)
				{
					errorOut.Call(f);
				}
				else if (!entityWithEntityID2.hasEntityPostureValue)
				{
					notComOut.Call(f);
				}
				else if (entityWithEntityID2.entityPostureValue.state == BreakState.breakCDState)
				{
					inCDOut.Call(f);
				}
				else if (entityWithEntityID2.entityPostureValue.state == BreakState.breakState)
				{
					inBreakOut.Call(f);
				}
				else
				{
					entityWithEntityID2.entityPostureValue.curTime = entityWithEntityID2.entityPostureValue.delayTime;
					entityWithEntityID2.entityPostureValue.state = BreakState.delay;
					if (entityWithEntityID2.entityPostureValue.cantBreakFlag != 0)
					{
						dontBreakOut.Call(f);
					}
					else
					{
						long value = damageValueInput.value;
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2223, out var baseValue, out var _, out var _);
						value = value * baseValue / 1000;
						SkillDamageType num = GetSkillDamageType.Invoke(attackerIDInput.value, abilityIDInput.value);
						GetMainDamageType.TryGetBySimEntity(entityWithEntityID2, out var skillDamageType);
						value = ((num == skillDamageType) ? (value * sameRateInput.value / baseValueInput.value) : (value * differentRateInput.value / baseValueInput.value));
						value = Math.Clamp(value, 0L, 2147483647L);
						entityWithEntityID2.entityPostureValue.value -= (int)value;
						output.Call(f);
					}
				}
			}
		});
	}
}
