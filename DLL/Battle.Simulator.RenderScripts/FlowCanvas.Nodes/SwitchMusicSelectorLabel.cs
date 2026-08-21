using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("切换选择器标签(背景音乐)(渲染)", 0)]
[Category("Render/声音")]
[Description("背景音乐设置哪个选择器使用对应的标签;\n当标签组为空或者长度为0时候,走Error分支;\n当值大于组长度时候,走默认0;")]
public class SwitchMusicSelectorLabel : FlowControlNode
{
	private FlowOutput _Out;

	private FlowOutput _Error;

	private ValueInput<string> _SelectorInput;

	private ValueInput<List<string>> _LabelsInput;

	private ValueInput<int> _ValueInput;

	protected override void RegisterPorts()
	{
		_SelectorInput = AddValueInput<string>("选择器", "selector").SetDefaultAndSerializedValue("1P_3P");
		_LabelsInput = AddValueInput<List<string>>("标签组", "labels");
		_ValueInput = AddValueInput<int>("值(看说明)", "value");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			List<string> value = _LabelsInput.GetValue();
			if (value == null || value.Count <= 0)
			{
				_Error.Call(f);
			}
			else
			{
				int value2 = _ValueInput.GetValue();
				string empty = string.Empty;
				empty = ((value.Count > value2) ? value[value2] : value[0]);
				AudioManager.Instance.SetSelectorLabel("music", _SelectorInput.GetValue(), empty);
				_Out.Call(f);
			}
		});
	}
}
