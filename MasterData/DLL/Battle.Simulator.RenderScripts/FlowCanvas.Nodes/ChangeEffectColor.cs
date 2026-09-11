using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改特效颜色", 0)]
[Category("Render/函数")]
[Description("修改特效颜色")]
public class ChangeEffectColor : CallableActionNode<GameObject, Color>
{
	public override void Invoke(GameObject effect, Color color)
	{
		effect.GetComponent<Renderer>().sharedMaterial.color = color;
	}
}
