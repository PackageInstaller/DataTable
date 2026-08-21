using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查星盘套装激活", 0)]
[Category("Logic/星盘")]
[Description("")]
public class CheckAstrolabeSuitEnable : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> suitIDVar = AddValueInput<int>("星盘套装ID", "astrolabeSuitIDVar");
		FlowOutput enableOutput = AddFlowOutput("激活", "enableOutput");
		FlowOutput disableOutput = AddFlowOutput("未激活", "disableOutput");
		AddFlowInput("In", delegate(Flow f)
		{
			if (AstrolabeSuitFlowCanvasHelper.CheckAstrolabeSuitEnable(base.mSimContext, entityIDVar.GetValue(), suitIDVar.GetValue()))
			{
				enableOutput.Call(f);
			}
			else
			{
				disableOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
	}
}
