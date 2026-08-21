using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除buff特效(buffID)", 0)]
[Category("Render/函数")]
[Description("把buff管理的对应的特效移除回收了")]
public class RemoveBuffEffectByBuffID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> buffIDInput = AddValueInput<int>("buffID");
		AddFlowInput("", delegate(Flow f)
		{
			BuffManager.GetBuffManager()?.RemoveBuffEffectByBuffID(buffIDInput.value);
			output.Call(f);
		});
	}
}
