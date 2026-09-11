using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改移速加成(千分比)", 0)]
[Category("Logic/Attribute")]
[Description("修改移速(千分比)")]
public class ModifyMoveSpeed : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int value)
	{
		int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityID);
		AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2006, out var baseValue, out var plusValue, out var tempPlusValue);
		plusValue += value;
		AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2006, baseValue, plusValue, tempPlusValue);
	}
}
