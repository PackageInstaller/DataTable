using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取变身实体类型ID(Pure)", 0)]
[Category("Logic/Abilities")]
[Description("若实体无变身效果则传出的变身前后实体类型ID都为0")]
public class GetTransfigurationInfo : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("变身前实体类型ID", delegate
		{
			AttributeProcessor.GetAttributeWithIntName(base.mSimContext.GetEntityWithEntityID(entityIDInput.value).entityBlackboard.var.mAttributeID, 2220, out var baseValue, out var _, out var _);
			return (int)baseValue;
		});
		AddValueOutput("变身后实体类型ID", delegate
		{
			AttributeProcessor.GetAttributeWithIntName(base.mSimContext.GetEntityWithEntityID(entityIDInput.value).entityBlackboard.var.mAttributeID, 2221, out var baseValue, out var _, out var _);
			return (int)baseValue;
		});
	}
}
