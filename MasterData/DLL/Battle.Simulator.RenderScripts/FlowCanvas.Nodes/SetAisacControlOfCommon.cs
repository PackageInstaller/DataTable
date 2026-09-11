using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[Aisac音量]设置通用播放器Aisac音量", 0)]
[Description("设置通用播放器的Aisac音量")]
[Category("Render/声音/Aisac音量")]
public class SetAisacControlOfCommon : FlowControlNodeOfRender
{
	private ValueInput<string> _playerKeyInput;

	private ValueInput<string> _nameInput;

	private ValueInput<float> _valueInput;

	private FlowOutput _out;

	protected override void RegisterPorts()
	{
		_playerKeyInput = AddValueInput<string>("播放器", "playerKey").SetDefaultAndSerializedValue("music");
		_nameInput = AddValueInput<string>("控制器名", "name").SetDefaultAndSerializedValue("bgm_volume");
		_valueInput = AddValueInput<float>("音量", "value").SetDefaultAndSerializedValue(0.5f);
		_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetAisacControl(_playerKeyInput.value, _nameInput.GetValue(), _valueInput.GetValue());
			_out.Call(f);
		});
	}
}
