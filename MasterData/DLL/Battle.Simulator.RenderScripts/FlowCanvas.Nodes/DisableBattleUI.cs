using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("隐藏战斗界面UI", 0)]
[Category("Render/UI")]
[Description("隐藏UI")]
public class DisableBattleUI : CallableActionNode
{
	public override void Invoke()
	{
		BattleUI.BattleUIActive(flag: false);
	}
}
