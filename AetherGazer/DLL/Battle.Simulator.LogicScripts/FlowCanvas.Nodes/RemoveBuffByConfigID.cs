using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff(配置ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除Buff(ID)\n新名字:移除Buff(配置ID)")]
public class RemoveBuffByConfigID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffIDInput = AddValueInput<int>("配置ID", "BuffID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BuffProcessor.RemoveBuffByConfigID(entityIDInput.value, buffIDInput.value);
			output.Call(f);
		});
	}
}
