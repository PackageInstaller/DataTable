using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改暴击率", 0)]
[Category("Logic/Attribute")]
[Description("修改暴击率")]
public class ModifyCritRate : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int value)
	{
		int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityID);
		AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 81, out var baseValue, out var plusValue, out var tempPlusValue);
		AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 81, baseValue, plusValue + value, tempPlusValue);
	}
}
