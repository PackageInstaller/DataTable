using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改增益掉落拾取距离(逻辑)", 0)]
[Category("Logic/Attribute/增益掉落")]
[Description("对实体持有的增益掉落拾取距离进行增加,传入负数为减少")]
public class ModifyItemPickUpRadius : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_addValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_itemPickUpRadius;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "EntityIDInput");
		m_addValueInput = AddValueInput<int>("增量", "addValueInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (AttributeProcessor.TryModifyItemPickUpRadius(base.mSimContext, m_entityIDInput.GetValue(), m_addValueInput.GetValue(), out m_itemPickUpRadius))
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityIDInput.GetValue());
		AddValueOutput("拾取距离", "ItemPickUpRadius", () => m_itemPickUpRadius);
	}
}
