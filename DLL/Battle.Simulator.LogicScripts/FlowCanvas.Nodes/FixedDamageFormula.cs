using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("伤害公式(固定值节点)", 0)]
[Category("Logic/Attribute")]
[Description("按formula公式的伤害计算")]
public class FixedDamageFormula : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> attackIDInput = AddValueInput<int>("攻击者ID");
		AddValueOutput("攻击者ID", () => attackIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		SkillDamageType skillDamageType = SkillDamageType.All;
		AddValueOutput("技能属性", () => skillDamageType);
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<int> damageInput = AddValueInput<int>("伤害值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			int value2 = thrownIDInput.value;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(attackIDInput.value);
			int attributeIDByEntityID2 = AttributeProcessor.GetAttributeIDByEntityID(targetIDInput.value);
			DamageFormula.GetRootAbilityID(value, value2, base.mSimContext, out var rootabilityID);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, 1L, 0L, 0L);
			int skillDamageType2 = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).SkillDamageType;
			skillDamageType = (SkillDamageType)skillDamageType2;
			if (skillDamageType == SkillDamageType.Random)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2222, out var baseValue, out var _, out var _);
				skillDamageType = (SkillDamageType)baseValue;
			}
			int num = (int)CalDamage(damageInput.value, attributeIDByEntityID, attributeIDByEntityID2, value, rootabilityID);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2175, num, 0L, 0L);
			f.Call(output);
		});
	}

	public static long CalDamage(long damage, int attributeIDOfAttacker, int attributeIDOfTarget, int abilityID, int skillID)
	{
		return DamageFormula.CalAllDamageBonus(damage * 1000, attributeIDOfAttacker, attributeIDOfTarget, abilityID, skillID);
	}
}
