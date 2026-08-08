using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取最大机制值", 0)]
[Category("Logic/Config")]
[Description("获取最大机制值")]
public class GetEnergyMaxValueByConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("最大机制值", delegate
		{
			int maxValue = 0;
			int value = entityIDInput.value;
			AttributeProcessor.TryGetEnergyMaxValue(base.mSimContext.GetEntityWithEntityID(value), out maxValue);
			return maxValue;
		});
	}
}
