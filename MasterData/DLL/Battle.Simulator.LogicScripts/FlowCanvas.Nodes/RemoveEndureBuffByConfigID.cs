using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除霸体Buff", 0)]
[Category("Logic/Buff")]
[Description("移除霸体Buff(ID)")]
public class RemoveEndureBuffByConfigID : FlowNode
{
	private readonly int m_BuffClassID = 200001;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BuffProcessor.RemoveBuffByConfigID(entityIDInput.value, m_BuffClassID);
			output.Call(f);
		});
	}
}
