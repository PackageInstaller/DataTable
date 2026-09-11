using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[Aisac音量]设置类别Aisac音量", 0)]
[Description("设置类别的Aisac音量")]
[Category("Render/声音/Aisac音量")]
public class SetAisacControlOfCategory : FlowControlNodeOfRender
{
	private ValueInput<string> _categoryNameInput;

	private ValueInput<string> _nameInput;

	private ValueInput<float> _valueInput;

	private FlowOutput _out;

	protected override void RegisterPorts()
	{
		_categoryNameInput = AddValueInput<string>("类别", "categoryName").SetDefaultAndSerializedValue("music");
		_nameInput = AddValueInput<string>("控制器名", "name").SetDefaultAndSerializedValue("bgm_volume");
		_valueInput = AddValueInput<float>("音量", "value").SetDefaultAndSerializedValue(0.5f);
		_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AudioManager.Instance.SetAisacControlOfCategory(_categoryNameInput.value, _nameInput.GetValue(), _valueInput.GetValue());
			_out.Call(f);
		});
	}
}
