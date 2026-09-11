using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("恢复环境效果(渲染)", 0)]
[Category("Render/特效")]
[Description("恢复游戏中的各种环境效果,例如雾效、三通道分离等")]
public class EnvironmentEffectResume : FlowControlNode
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
				battleScene.ResumeEnvironmentEffect();
			}
			_output.Call(f);
		});
	}
}
