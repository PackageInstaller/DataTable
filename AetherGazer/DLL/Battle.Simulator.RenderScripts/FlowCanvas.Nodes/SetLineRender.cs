using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置LineRender", 0)]
[Category("Render/Asset")]
[Description("设置LineRender起点和终点")]
[ExposeAsDefinition]
public class SetLineRender : CallableActionNode<LineRenderer, Vector3, Vector3>
{
	public override void Invoke(LineRenderer line, Vector3 from, Vector3 to)
	{
		line.gameObject.SetActive(value: true);
		line.SetPosition(0, from);
		line.SetPosition(1, to);
	}
}
