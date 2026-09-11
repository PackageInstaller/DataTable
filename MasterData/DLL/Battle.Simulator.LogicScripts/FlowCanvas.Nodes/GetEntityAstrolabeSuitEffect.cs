using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("星盘套装效果(遍历+说明)", 0)]
[Category("Logic/星盘")]
[Description("得到传入实体的星盘套装ID,【激活】接口会调用多次,每次【星盘套装效果ID】都会传出对应的套装ID")]
public class GetEntityAstrolabeSuitEffect : FlowNode
{
	private long m_suitIndex;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		FlowOutput outputHad = AddFlowOutput("激活", "outputHad");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int num = 2023;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(value);
			for (int i = 0; i < 27; i++)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, num, out m_suitIndex, out var _, out var _);
				if (m_suitIndex == 0L)
				{
					break;
				}
				outputHad.Call(f);
				num++;
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDInput.GetValue());
		AddValueOutput("星盘套装效果ID", "astrolabeSuitIndex", () => (int)m_suitIndex);
	}
}
