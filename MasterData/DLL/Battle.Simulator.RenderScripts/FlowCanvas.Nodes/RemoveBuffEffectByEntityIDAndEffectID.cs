using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除buff特效(实体ID和buff渲染ID)", 0)]
[Category("Render/函数")]
[Description("把buff管理的对应的特效移除回收了")]
public class RemoveBuffEffectByEntityIDAndEffectID : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> effectIDInput = AddValueInput<int>("buff渲染ID");
		AddFlowInput("", delegate(Flow f)
		{
			BuffManager.GetBuffManager()?.RemoveBuffEffectByEntityIDAndEffectID(entityIDInput.value, effectIDInput.value);
			output.Call(f);
		});
	}
}
