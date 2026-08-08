using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("比较机制值(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("比较实体机制值是否足够\n考虑消耗减免只对比较怒气、能量、神能这三种机制值消耗时生效，若是实体ID对应的机制值类型为印记则直接比较实体当前机制值和比较值\n找不到实体走Error")]
public class CompareEnergy : FlowControlNode
{
	private int entityID;

	private int realcon;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> compareValueInput = AddValueInput<int>("比较值", "compareValue");
		ValueInput<bool> hasFixedInput = AddValueInput<bool>("是否考虑消耗减免", "hasFixed");
		AddValueOutput("entityID", () => entityID);
		AddValueOutput("实际消耗值", "realConsume", () => realcon);
		FlowOutput equalsOut = AddFlowOutput("相等", "Equal");
		FlowOutput compareOut = AddFlowOutput("比较值大", "compare");
		FlowOutput energyOut = AddFlowOutput("机制值大", "energy");
		FlowOutput noneOut = AddFlowOutput("无机制值类型");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("In", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
				if (config == null)
				{
					errorOut.Call(f);
				}
				else
				{
					int value = compareValueInput.value;
					if (value < 0)
					{
						energyOut.Call(f);
					}
					else
					{
						EnergyType energyType = (EnergyType)config.EnergyType;
						int powerValue = AttributeProcessor.GetPowerValue(entityID);
						switch (energyType)
						{
						case EnergyType.None:
							noneOut.Call(f);
							return;
						case EnergyType.Rage:
						case EnergyType.Power:
						case EnergyType.Unique:
						case EnergyType.Tune:
							if (hasFixedInput.value)
							{
								AttributeProcessor.CalcConsumeByAttribute(-value, entityWithEntityID.entityBlackboard.var.mAttributeID, energyType, out var energyChangeValue, out var _);
								realcon = -energyChangeValue;
							}
							else
							{
								realcon = value;
							}
							break;
						case EnergyType.Mark:
							realcon = value;
							break;
						default:
							Debug.LogError("比较机制值传入实体的机制类型为空");
							errorOut.Call(f);
							return;
						}
						if (realcon == powerValue)
						{
							equalsOut.Call(f);
						}
						else if (realcon > powerValue)
						{
							compareOut.Call(f);
						}
						else
						{
							energyOut.Call(f);
						}
					}
				}
			}
		});
	}
}
