using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置血条震动强度等级", 0)]
[Category("Render/UI")]
[Description("设置血条震动强度等级，等级强度在BattlePanel的BossInfo下的BossInfoUI下的shakeDis中配置")]
public class SetHPBarShake : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> LevelInput = AddValueInput<int>("等级", "level");
		AddFlowInput("in", delegate(Flow f)
		{
			BattleUI.GetBattleUI().BossInfoUI.SetHpShakeLevel(LevelInput.value);
			output.Call(f);
		});
	}
}
