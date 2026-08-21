using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取伤害值和伤害类型", 0)]
[Category("Logic/Attribute")]
[Description("设置伤害值和伤害类型")]
public class GetDamageAndType : FlowNode
{
	private ValueInput<int> m_attributeIDInput;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> entityIDInput = AddValueInput<int>("攻击者ID");
		long damageValue = 0L;
		AddValueOutput("伤害值", () => damageValue);
		DamageType damageType = DamageType.None;
		AddValueOutput("伤害类型", () => damageType);
		m_attributeIDInput = AddValueInput<int>("攻击者黑板ID", "attributeID").SetDefaultAndSerializedValue(-1);
		AddValueOutput("攻击者黑板ID", "attributeID", () => m_attributeIDInput.GetValue());
		AddFlowInput("", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2175, out damageValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2176, out var baseValue, out plusValue, out tempPlusValue);
			damageType = (DamageType)baseValue;
			f.Call(output);
		});
	}
}
