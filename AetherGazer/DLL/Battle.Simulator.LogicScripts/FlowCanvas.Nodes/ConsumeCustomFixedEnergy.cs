using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("消耗机制值(考虑属性减免)", 0)]
[Category("Logic/Abilities")]
[Description("消耗机制值(考虑属性减免), 消耗值是正数\n如果描述为消耗全部的机制值,则去用不走属性的节点;反之描述为消耗xx点,即使xx=最大值,也要用本节点")]
public class ConsumeCustomFixedEnergy : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> valueInput = AddValueInput<int>("消耗值");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				falseOut.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
				if (config == null)
				{
					falseOut.Call(f);
				}
				else
				{
					int num = valueInput.value;
					EnergyType energyType = (EnergyType)config.EnergyType;
					if (energyType == EnergyType.Mark && num > 0)
					{
						long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, 1108, AttributeCalcType.Add);
						if (DRandom.Random(1000u) < finalAttributeByAttributeID)
						{
							num--;
						}
					}
					AttributeProcessor.CalcConsumeByAttribute(-num, entityWithEntityID.entityBlackboard.var.mAttributeID, energyType, out var energyChangeValue, out var _);
					bool num2 = AttributeProcessor.TryAddPowerValue(entityWithEntityID, energyChangeValue * 1000, out var newValue, out var oldValue);
					AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
					if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
					{
						base.mSimContext.GetSimInterface().mOnPowerUpdate(entityWithEntityID.creationIndex, newValue, oldValue, maxValue, maxValue, energyType);
					}
					if (num2)
					{
						trueOut.Call(f);
					}
					else
					{
						falseOut.Call(f);
					}
				}
			}
		});
	}
}
