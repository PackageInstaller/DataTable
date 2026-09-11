using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置音量(分类)(渲染)", 0)]
[Category("Render/声音")]
[Description("设置分类对应的音量")]
public class SetVolumeOfCategory : FlowControlNode
{
	private ValueInput<string> _NameInput;

	private ValueInput<float> _ValueInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_NameInput = AddValueInput<string>("分类名", "name").SetDefaultAndSerializedValue("");
		_ValueInput = AddValueInput<float>("音量", "value").SetDefaultAndSerializedValue(0.5f);
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetVolumeOfCategory(_NameInput.GetValue(), _ValueInput.GetValue());
			_Out.Call(f);
		});
	}
}
