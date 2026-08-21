using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示隐藏全部抛掷物(Render)", 0)]
[Category("Render/抛掷物")]
[Description("隐藏全部抛掷物(Render)")]
[ExposeAsDefinition]
public class HideAllThrown : CallableActionNode<bool>
{
	public override void Invoke(bool hide)
	{
		(NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager.HideAll(hide);
	}
}
