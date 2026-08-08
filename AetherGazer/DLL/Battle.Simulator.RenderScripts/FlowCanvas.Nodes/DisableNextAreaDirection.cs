using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清理下个区域的位置(渲染)", 0)]
[Category("Render/Trigger")]
[Description("发送事件给对应的触发器")]
public class DisableNextAreaDirection : CallableActionNode
{
	public override void Invoke()
	{
		((BattleScene)NScene.GetCurrentScene()).CleanNextAreaDirection();
	}
}
