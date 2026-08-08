using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加buff特效", 0)]
[Category("Render/函数")]
[Description("把创建的特效添加到buff管理的列表里面去")]
public class AddBuffEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> buffIDInput = AddValueInput<int>("buffID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> effectIDInput = AddValueInput<int>("buff渲染ID");
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		AddFlowInput("", delegate(Flow f)
		{
			BuffManager.GetBuffManager()?.AddBuffEffect(buffIDInput.value, entityIDInput.value, effectIDInput.value, goInput.value);
			output.Call(f);
		});
	}
}
