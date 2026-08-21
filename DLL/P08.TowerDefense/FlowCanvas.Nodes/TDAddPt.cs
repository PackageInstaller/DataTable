using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]增加PT点", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI更新")]
public class TDAddPt : FlowControlNodeOfRender
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
		ValueInput<int> addValueInput = AddValueInput<int>("增量", "addValue");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				ui.SetPT(ui.GetPT() + addValueInput.value);
				output.Call(f);
			}
		});
	}
}
