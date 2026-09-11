using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到BUFF配置间隔(配置ID)", 0)]
[Category("Logic/Config")]
[Description("根据配置ID得到buff配置间隔时长")]
public class GetBuffConfigTickByConfigID : FlowControlNodeOfLogic
{
	private ValueInput<int> _configIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _tick;

	protected override void RegisterPorts()
	{
		_configIDInput = AddValueInput<int>("配置ID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_tick = 0;
			if (!ConfigHelper.GetInstance().TryGetConfig<public_buff>(_configIDInput.value, out var config))
			{
				_errorOut.Call(f);
			}
			else
			{
				_tick = config.BuffTicktime;
				_output.Call(f);
			}
		});
		AddValueOutput("触发间隔", "tick", () => _tick);
	}
}
