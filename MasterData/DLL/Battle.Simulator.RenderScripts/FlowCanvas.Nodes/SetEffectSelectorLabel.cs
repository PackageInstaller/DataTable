using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置选择器标签(音效)(渲染)", 0)]
[Category("Render/声音")]
[Description("背景音乐设置哪个选择器使用对应的标签;")]
public class SetEffectSelectorLabel : FlowControlNode
{
	private FlowOutput _Out;

	private ValueInput<string> _SelectorInput;

	private ValueInput<string> _LabelInput;

	protected override void RegisterPorts()
	{
		_SelectorInput = AddValueInput<string>("选择器", "selector").SetDefaultAndSerializedValue("1P_3P");
		_LabelInput = AddValueInput<string>("标签", "label").SetDefaultAndSerializedValue("3P");
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetSelectorLabel("effect", _SelectorInput.GetValue(), _LabelInput.GetValue());
			_Out.Call(f);
		});
	}
}
