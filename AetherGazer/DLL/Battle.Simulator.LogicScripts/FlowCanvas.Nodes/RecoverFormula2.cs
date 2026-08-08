using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("治疗公式(吃攻击,暴击,治疗加成)", 0)]
[Category("Logic/Attribute")]
[Description("按formula公式的治疗计算")]
public class RecoverFormula2 : FlowNode
{
	public static long GetFinalCritRate(int attributeIDOfAttacker)
	{
		return AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 81, AttributeCalcType.Add);
	}

	public static long GetFinalCritDamagePercent(int attributeIDOfAttacker)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 82, AttributeCalcType.Add);
		return 1500 + finalAttributeByAttributeID;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> attackIDInput = AddValueInput<int>("攻击者ID");
		AddValueOutput("攻击者ID", () => attackIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者");
		ValueInput<int> damagePercentInput = AddValueInput<int>("倍率(百分比)");
		int res = 0;
		AddValueOutput("结果", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(attackIDInput.value);
			int attributeIDByEntityID2 = AttributeProcessor.GetAttributeIDByEntityID(targetIDInput.value);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, 8L, 0L, 0L);
			long finalAttackValue = DamageFormula.GetFinalAttackValue(attributeIDByEntityID);
			long num = 1000L;
			if (DRandom.Random(1000u) < GetFinalCritRate(attributeIDByEntityID))
			{
				num = GetFinalCritDamagePercent(attributeIDByEntityID);
				AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, 7L, 0L, 0L);
			}
			long healBonus = RecoverFormula.GetHealBonus(attributeIDByEntityID, attributeIDByEntityID2);
			long fixedHealBonus = RecoverFormula.GetFixedHealBonus(attributeIDByEntityID, attributeIDByEntityID2);
			long num2 = DamageFormula.ClampPositive(finalAttackValue);
			num2 = DamageFormula.ClampPositive(num2 * damagePercentInput.value / 100);
			num2 = DamageFormula.ClampPositive(num2 * (1000 + healBonus) / 1000);
			num2 = DamageFormula.ClampPositive(num2 * num / 1000);
			num2 = DamageFormula.ClampPositive(num2 + fixedHealBonus * 1000);
			res = (int)DamageFormula.GetResult(num2, 99L, 101L);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2175, res, 0L, 0L);
			f.Call(output);
		});
	}
}
