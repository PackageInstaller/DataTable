using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置Label", 0)]
[Category("Render/UI")]
[Description("设置Label")]
[ExposeAsDefinition]
public class SetLabel : CallableActionNode<Text, string>
{
	public override void Invoke(Text label, string text)
	{
		label.text = text;
	}
}
