using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("调用战斗暂停界面", 0)]
[Category("Render/UI")]
[Description("调用战斗暂停界面")]
public class CallBattlePauseUI : CallableFunctionNode<bool>
{
	public override bool Invoke()
	{
		if (NScene.IsHanding())
		{
			return false;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			battleScene.CallPauseUI();
		}
		return false;
	}
}
