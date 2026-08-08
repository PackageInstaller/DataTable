using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[修正模式]激活手动模式(逻辑)", 0)]
[Category("Logic/修正模式")]
[Description("修正模式从自动进入切换为手动进入")]
public class AcitveManualMode : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> activeInput = AddValueInput<bool>("激活", "active");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.graph.mSimContext.entitySourceSpace;
			if (entitySourceSpace == null)
			{
				errorOut.Call(f);
			}
			else
			{
				entitySourceSpace.ManualMode = activeInput.value;
				output.Call(f);
			}
		});
	}
}
