using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示战斗界面UI", 0)]
[Category("Render/UI")]
[Description("显示UI")]
public class EnableBattleUI : CallableActionNode
{
	public override void Invoke()
	{
		BattleUI.BattleUIActive(flag: true);
	}
}
