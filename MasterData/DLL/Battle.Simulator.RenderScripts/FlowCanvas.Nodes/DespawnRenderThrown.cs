using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物(Render)", 0)]
[Category("Render/抛掷物")]
[Description("销毁抛掷物(Render)")]
[ExposeAsDefinition]
public class DespawnRenderThrown : CallableActionNode<int>
{
	public override void Invoke(int id)
	{
		(NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager.DestoryThrown(id);
	}
}
