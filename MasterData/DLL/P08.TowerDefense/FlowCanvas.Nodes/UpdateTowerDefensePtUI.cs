using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]PTUI更新", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI更新")]
public class UpdateTowerDefensePtUI : FlowNode
{
	private TowerPTUI ui;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ui = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ui = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> hpInput = AddValueInput<int>("当前血量", "hp");
		ValueInput<int> currentWaveInput = AddValueInput<int>("当前波数", "currentWave");
		ValueInput<int> totalWaveInput = AddValueInput<int>("总波数", "totalWave");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("更新", "update", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				ui.SetHP(hpInput.value);
				ui.SetWave(currentWaveInput.value, totalWaveInput.value);
				output.Call(f);
			}
		});
	}
}
