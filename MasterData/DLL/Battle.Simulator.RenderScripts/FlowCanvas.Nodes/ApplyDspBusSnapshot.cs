using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置Dsp总线快照", 0)]
[Category("Render/声音")]
[Description("设置总线快照")]
public class ApplyDspBusSnapshot : FlowControlNode
{
	private ValueInput<string> _NameInput;

	private ValueInput<int> _ValueInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_NameInput = AddValueInput<string>("快照名称", "name").SetDefaultAndSerializedValue(string.Empty);
		_ValueInput = AddValueInput<int>("生效时长(毫秒)", "value").SetDefaultAndSerializedValue(500);
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.ApplyDspBusSnapshot(_NameInput.GetValue(), _ValueInput.GetValue());
			_Out.Call(f);
		});
	}
}
