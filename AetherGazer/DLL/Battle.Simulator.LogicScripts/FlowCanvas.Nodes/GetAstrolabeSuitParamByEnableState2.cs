using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("星盘套装激活参数选择(逻辑黑板)", 0)]
[Category("Logic/星盘")]
[Description("星盘套装激活状态为检查逻辑黑板的【星盘套装ID】对应是否有值,进而传出不同的参数值")]
public class GetAstrolabeSuitParamByEnableState2 : FlowControlNode
{
	private int m_outputValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("EntityID", "entityIDVar");
		ValueInput<int> suitIDVar = AddValueInput<int>("星盘套装ID", "astrolabeSuitIDVar");
		ValueInput<int> defaultValueVar = AddValueInput<int>("默认值", "dufaultValueVar");
		ValueInput<int> enableValueVar = AddValueInput<int>("激活值", "enableValueVar");
		FlowOutput output = AddFlowOutput("Out", "Output");
		AddFlowInput("In", delegate(Flow f)
		{
			m_outputValue = defaultValueVar.GetValue();
			if (AstrolabeSuitFlowCanvasHelper.CheckAstrolabeSuitEnableWithIntName(base.mSimContext, entityIDVar.GetValue(), suitIDVar.GetValue()))
			{
				m_outputValue = enableValueVar.GetValue();
			}
			output.Call(f);
		});
		AddValueOutput("结果值", "outputValue", () => m_outputValue);
	}
}
