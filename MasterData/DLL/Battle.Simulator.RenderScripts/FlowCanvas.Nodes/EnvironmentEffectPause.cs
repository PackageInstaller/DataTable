using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("暂停环境效果(渲染)", 0)]
[Category("Render/特效")]
[Description("暂停游戏中的各种环境效果,例如雾效、三通道分离等")]
public class EnvironmentEffectPause : FlowControlNode
{
	private FlowOutput _output;

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				battleScene.PauseEnvironmentEffect(pCleanEffect: true);
			}
			_output.Call(f);
		});
	}
}
