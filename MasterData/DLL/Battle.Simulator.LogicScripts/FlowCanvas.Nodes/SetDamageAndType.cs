using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置伤害值和伤害类型", 0)]
[Category("Logic/Attribute")]
[Description("设置伤害值和伤害类型")]
public class SetDamageAndType : FlowNode
{
	private ValueInput<int> m_attributeIDInput;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("攻击者ID");
		ValueInput<int> damageValueInput = AddValueInput<int>("伤害值");
		ValueInput<DamageType> damageTypeInput = AddValueInput<DamageType>("伤害类型");
		m_attributeIDInput = AddValueInput<int>("攻击者黑板ID", "attributeID").SetDefaultAndSerializedValue(-1);
		AddValueOutput("攻击者黑板ID", "attributeID", () => m_attributeIDInput.GetValue());
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2175, damageValueInput.value, 0L, 0L);
			AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2176, (long)damageTypeInput.value, 0L, 0L);
			output.Call(f);
		});
	}
}
