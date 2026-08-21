using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("玩家之外的伤害数字", 0)]
[Category("Render/UI")]
[Description("开关玩家之外的伤害数字")]
public class DisableOthersHitNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> valInput = AddValueInput<bool>("是否显示");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
				if (worldSatetManager != null)
				{
					worldSatetManager.hide_teammate_hit_number = !valInput.value;
				}
			}
			output.Call(f);
		});
	}
}
