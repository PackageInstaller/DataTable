using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("通过组件获取GameObject", 0)]
[Category("Render/UI")]
[Description("通过组件获取GameObject")]
public class GetGameObjectByComponent<T> : FlowNode where T : Component
{
	protected override void RegisterPorts()
	{
		ValueInput<T> comInput = AddValueInput<T>("组件");
		AddValueOutput("GameObject", () => comInput.value.gameObject);
	}
}
