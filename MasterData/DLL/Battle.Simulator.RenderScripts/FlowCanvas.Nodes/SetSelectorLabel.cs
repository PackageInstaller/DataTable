using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置选择器标签(渲染)", 0)]
[Category("Render/声音")]
[Description("选择哪个音源的哪个选择器使用对应的标签;\n音源:music、voice、effect;")]
public class SetSelectorLabel : FlowControlNode
{
	private FlowOutput _Out;

	private ValueInput<string> _KeyInput;

	private ValueInput<string> _SelectorInput;

	private ValueInput<string> _LabelInput;

	protected override void RegisterPorts()
	{
		_KeyInput = AddValueInput<string>("音源", "key").SetDefaultAndSerializedValue("music");
		_SelectorInput = AddValueInput<string>("选择器", "selector").SetDefaultAndSerializedValue("1P_3P");
		_LabelInput = AddValueInput<string>("标签", "label").SetDefaultAndSerializedValue("3P");
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetSelectorLabel(_KeyInput.GetValue(), _SelectorInput.GetValue(), _LabelInput.GetValue());
			_Out.Call(f);
		});
	}
}
