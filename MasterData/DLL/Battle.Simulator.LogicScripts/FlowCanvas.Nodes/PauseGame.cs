using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("暂停游戏", 0)]
[Category("Render/Control")]
[Description("Pause Game")]
public class PauseGame : CallableActionNode<bool>
{
	public override void Invoke(bool isPause)
	{
		if (NScene.IsHanding())
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			if (isPause)
			{
				battleScene.GetBattleSimulatorSystem().PauseGame();
			}
			else
			{
				battleScene.GetBattleSimulatorSystem().ResumeGame();
			}
		}
	}
}
