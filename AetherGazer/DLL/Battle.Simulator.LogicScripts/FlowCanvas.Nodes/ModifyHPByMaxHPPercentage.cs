using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("按最大血量百分比修改伤害值", 0)]
[Category("Logic/Attribute")]
[Description("按formula公式的治疗计算")]
public class ModifyHPByMaxHPPercentage : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者ID", "targetID");
		ValueInput<int> attackerIDInput = AddValueInput<int>("攻击者ID", "attackerID");
		ValueInput<int> percentInput = AddValueInput<int>("百分比", "percent");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<int> thownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		FlowOutput output = AddFlowOutput("OUT", "out");
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(attackerIDInput.value);
				if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard)
				{
					int attributeID = CalculateDamageHelper.GetAttributeID(-1, entityWithEntityID);
					int attributeID2 = CalculateDamageHelper.GetAttributeID(-1, entityWithEntityID2);
					if (attributeID != -1 && attributeID2 != -1)
					{
						long damage = entityWithEntityID.entityBlackboard.var.mMaxHP * percentInput.value / 100;
						DamageFormula.GetRootAbilityID(abilityIDInput.value, thownIDInput.value, base.mSimContext, out var rootabilityID);
						damage = (int)FixedDamageFormula.CalDamage(damage, attributeID2, attributeID, abilityIDInput.value, rootabilityID);
						AttributeProcessor.GetAttributeWithIntName(attributeID2, 2176, out var baseValue, out var _, out var _);
						DamageType damageType = (DamageType)baseValue;
						AttributeProcessor.SetAttributeWithIntName(attributeID2, 2175, damage, 0L, 0L);
						AttributeProcessor.SetAttributeWithIntName(attributeID2, 2176, (long)damageType, 0L, 0L);
					}
					output.Call(f);
				}
			}
		});
	}
}
