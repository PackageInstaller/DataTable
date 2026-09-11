using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取暴击率", 0)]
[Category("Logic/Attribute")]
[Description("获取暴击率")]
public class GetCritRate : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityID), 81, out var baseValue, out var plusValue, out var _);
		return (int)(baseValue + plusValue);
	}
}
