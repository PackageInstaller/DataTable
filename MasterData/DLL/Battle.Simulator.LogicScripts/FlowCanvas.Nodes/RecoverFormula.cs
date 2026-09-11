using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("治疗公式(吃治疗加成)", 0)]
[Category("Logic/Attribute")]
[Description("按formula公式的治疗计算")]
public class RecoverFormula : FlowNode
{
	public static long GetHealBonus(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 42, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 44, AttributeCalcType.Add);
		return finalAttributeByAttributeID + finalAttributeByAttributeID2;
	}

	public static long GetFixedHealBonus(int attributeIDOfAttacker, int attributeIDOfTarget)
	{
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfAttacker, 41, AttributeCalcType.Add);
		long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(attributeIDOfTarget, 43, AttributeCalcType.Add);
		return finalAttributeByAttributeID + finalAttributeByAttributeID2;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> attackIDInput = AddValueInput<int>("攻击者ID");
		AddValueOutput("攻击者ID", () => attackIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("受击者");
		ValueInput<int> recoverBaseValueInput = AddValueInput<int>("回血基础值");
		int res = 0;
		AddValueOutput("结果", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			res = recoverBaseValueInput.value;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(attackIDInput.value);
			int attributeIDByEntityID2 = AttributeProcessor.GetAttributeIDByEntityID(targetIDInput.value);
			_ = recoverBaseValueInput.value;
			long healBonus = GetHealBonus(attributeIDByEntityID, attributeIDByEntityID2);
			long fixedHealBonus = GetFixedHealBonus(attributeIDByEntityID, attributeIDByEntityID2);
			long num = res * (1000 + healBonus) + fixedHealBonus * 1000;
			if (num > 0)
			{
				res = (int)DamageFormula.GetResult(num, 99L, 101L);
			}
			else
			{
				res = 1;
			}
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, 8L, 0L, 0L);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2175, res, 0L, 0L);
			f.Call(output);
		});
	}
}
