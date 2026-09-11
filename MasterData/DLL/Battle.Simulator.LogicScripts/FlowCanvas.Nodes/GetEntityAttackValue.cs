using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得实体最终攻击力", 0)]
[Category("Logic/Attribute")]
[Description("获得实体最终攻击力")]
public class GetEntityAttackValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("最终攻击力", () => (int)DamageFormula.GetFinalAttackValue(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value)) / 1000);
	}
}
