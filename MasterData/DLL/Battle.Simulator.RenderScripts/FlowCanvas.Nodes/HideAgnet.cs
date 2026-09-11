using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏角色(不包括影子)(过时)", 0)]
[Category("Render/Agent")]
[Description("Hide Agnet")]
[ExposeAsDefinition]
public class HideAgnet : CallableActionNode<NAgent, bool>
{
	public override void Invoke(NAgent agent, bool isShow)
	{
		Renderer[] componentsInChildren = agent.GetComponentsInChildren<Renderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = isShow;
		}
	}
}
