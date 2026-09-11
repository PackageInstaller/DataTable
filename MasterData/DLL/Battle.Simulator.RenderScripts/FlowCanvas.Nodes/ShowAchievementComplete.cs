using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示成就达成(已过时, 以后可能会用)", 0)]
[Category("Render/UI")]
[Description("显示成就达成")]
public class ShowAchievementComplete : CallableActionNode<int, GameObject>
{
	public override void Invoke(int id, GameObject panel)
	{
	}
}
