using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能可用性检查", 0)]
[Category("Logic/Attribute")]
[Description("当需要同时满足左边三个条件中输入为True的所有对应条件时，才会输出True，比如技能开关检查和CD检查勾选了True，则这个技能需要在启用状态且不在CD中才会走True\n不会检查奥义值或其他内容")]
public class IsAbilityCanUse : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityID = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<bool> useEnableLogic = AddValueInput<bool>("技能开关检查", "useEnableLogic").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> useEnergyLogic = AddValueInput<bool>("机制值检查", "useEnergyLogic").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> useCDLogic = AddValueInput<bool>("CD检查", "useCDLogic").SetDefaultAndSerializedValue(v: true);
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		AddFlowInput("In", "in", delegate(Flow f)
		{
			int value = abilityID.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || value == 0)
			{
				falseOut.Call(f);
			}
			else
			{
				if (useEnableLogic.value)
				{
					if (entityWithEntityID.entityBlackboard.var.mIsBanMelee > 0 && entityWithEntityID.entityBlackboard.var.mMeleesSlots.Contains(value))
					{
						falseOut.Call(f);
						return;
					}
					if (entityWithEntityID.entityBlackboard.var.mAbilityDisableFlag.TryGetValue(value, out var value2) && value2 != 0)
					{
						falseOut.Call(f);
						return;
					}
					if (entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(value, out var value3) && value3 > 0)
					{
						falseOut.Call(f);
						return;
					}
				}
				if (useEnergyLogic.value)
				{
					int powerValue = AttributeProcessor.GetPowerValue(entityWithEntityID.creationIndex);
					AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, value, out var energyChangeValue, out var _);
					if (powerValue + energyChangeValue < 0)
					{
						falseOut.Call(f);
						return;
					}
				}
				if (useCDLogic.value)
				{
					int abilityID2 = CDProcessor.CheckAbilityIsAvoid(abilityID.value);
					if (CDProcessor.InCD(entityWithEntityID, abilityID2))
					{
						falseOut.Call(f);
						return;
					}
				}
				trueOut.Call(f);
			}
		});
	}
}
