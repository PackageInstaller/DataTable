using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减CD时间上限值(毫秒)(已过时)", 0)]
[Category("Logic/Attribute")]
[Description("增减CD时间上限值的毫秒数,直接修改为目标值")]
[ExposeAsDefinition]
public class ModifyAbilityCDValue : FlowControlNode
{
	private FlowOutput m_output;

	private ValueInput<int> m_entityIDVar;

	private ValueInput<int> m_modifyValue;

	protected override void RegisterPorts()
	{
		m_entityIDVar = AddValueInput<int>("EntityID", "entityID");
		m_modifyValue = AddValueInput<int>("变化值(毫秒)", "modifyValue");
		m_output = AddFlowOutput("Out", "out");
		AddFlowInput("In", "in", delegate(Flow f)
		{
			m_output.Call(f);
		});
		AddValueOutput("EntityID", "entityID", () => m_entityIDVar.GetValue());
	}
}
