using System;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到BUFF元素属性(配置ID)", 0)]
[Category("Logic/Buff")]
[Description("通过buff子类型，得到buff对应的元素属性")]
public class GetElementOfBuffConfigID : FlowControlNodeOfLogic
{
	private ValueInput<int> _buffConfigIDInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private int _element;

	protected override void RegisterPorts()
	{
		_buffConfigIDInput = AddValueInput<int>("配置ID", "configID");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_element = -1;
			if (!ConfigHelper.GetInstance().TryGetConfig<public_buff>(_buffConfigIDInput.value, out var config))
			{
				_errorOut.Call(f);
			}
			else
			{
				if (config.SubType.Contains('$'))
				{
					string[] array = config.SubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
					for (int i = 0; i < array.Length && !BuffSubType2Element.TryParseBuffSubType2Ele(array[i], out _element); i++)
					{
					}
				}
				else
				{
					BuffSubType2Element.TryParseBuffSubType2Ele(config.SubType, out _element);
				}
				_output.Call(f);
			}
		});
		AddValueOutput("元素属性", "element", () => _element);
	}
}
