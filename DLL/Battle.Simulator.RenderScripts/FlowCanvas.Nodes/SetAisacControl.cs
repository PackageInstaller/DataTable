using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[Aisac音量]设置背景音Aisac音量", 0)]
[Description("修改 Aisac 音量")]
[Category("Render/声音/Aisac音量")]
[Color("ffff00")]
public class SetAisacControl : FlowControlNode
{
	private ValueInput<string> _NameInput;

	private ValueInput<float> _ValueInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_NameInput = AddValueInput<string>("控制器名", "name").SetDefaultAndSerializedValue("bgm_volume");
		_ValueInput = AddValueInput<float>("音量", "value").SetDefaultAndSerializedValue(0.5f);
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetAisacControl("music", _NameInput.GetValue(), _ValueInput.GetValue());
			_Out.Call(f);
		});
	}
}
