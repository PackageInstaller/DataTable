using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置下个区域的位置(渲染)", 0)]
[Category("Render/Trigger")]
[Description("发送事件给对应的触发器")]
public class SetNextAreaDirection : CallableActionNode<Vector3>
{
	public override void Invoke(Vector3 direction)
	{
		((BattleScene)NScene.GetCurrentScene()).SetNextAreaDirection(direction);
	}
}
