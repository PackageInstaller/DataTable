using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取界面传进来的剩余时长(渲染)", 0)]
[Description("获取界面传进来的剩余时长, 其实是一个整型变量, 默认是0. 说明没人设置过")]
[Category("Render/Trigger")]
public class GetLeftTimeAtStartRender : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("毫秒数", delegate
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			return (!(battleScene == null) && battleScene.ready != null && battleScene.ready.SceneDataForExcehange != null) ? battleScene.ready.SceneDataForExcehange.LeftTime : 0;
		});
	}
}
