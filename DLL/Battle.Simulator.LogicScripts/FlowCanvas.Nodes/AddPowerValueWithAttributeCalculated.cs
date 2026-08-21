using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加机制值(考虑属性加成)", 0)]
[Category("Logic/Attribute")]
[Description("以实体目前拥有的所有机制值相关的属性，将输入值进行加/减成结算后，加入实体的机制值中\n包括1109-1117属性和1107属性，不包括1108属性\n会在加法计算结束后，广播能量变更事件\n\nFalse：实体不存在、实体没有黑板而导致机制值添加失败时\n消耗机制值勿用本节点")]
public class AddPowerValueWithAttributeCalculated : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		int curValue = 0;
		AddValueOutput("增加之后的能量值", () => curValue);
		int oldValue = 0;
		AddValueOutput("变化值", () => curValue - oldValue);
		ValueInput<int> baseValueInput = AddValueInput<int>("增量基础值");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				falseOut.Call(f);
			}
			else
			{
				int value = baseValueInput.value;
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
				AttributeProcessor.CalcConsumeByAttribute(value, entityWithEntityID.entityBlackboard.var.mAttributeID, (EnergyType)config.EnergyType, out var energyChangeValue, out var fractionalPart);
				switch ((EnergyType)config.EnergyType)
				{
				case EnergyType.None:
					falseOut.Call(f);
					return;
				case EnergyType.Mark:
				{
					long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, 1107, AttributeCalcType.Add);
					if (DRandom.Random(1000u) < finalAttributeByAttributeID)
					{
						energyChangeValue++;
					}
					break;
				}
				}
				bool num = AttributeProcessor.TryAddPowerValue(entityWithEntityID, energyChangeValue * 1000 + fractionalPart, out curValue, out oldValue);
				AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
				if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID, curValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
				if (num)
				{
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
