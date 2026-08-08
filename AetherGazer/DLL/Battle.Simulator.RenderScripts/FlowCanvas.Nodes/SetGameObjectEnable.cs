using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置GameObject激活", 0)]
[Category("Render/UI")]
[Description("设置GameObject激活")]
[ExposeAsDefinition]
public class SetGameObjectEnable : CallableActionNode<bool, GameObject>
{
	public override void Invoke(bool enable, GameObject gameObject)
	{
		gameObject.SetActive(enable);
	}
}
