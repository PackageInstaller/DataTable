using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加抛掷物忽略", 0)]
[Category("Logic/抛掷物")]
[Description("向抛掷物命中历史中添加一个ID,当进入新的Hit段、接触段时候，会被重置")]
public class AddThrownIgnore : FlowControlNode
{
	private ValueInput<int> _ThrownIDInput;

	private ValueInput<int> _IgnoreEntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_ThrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		_IgnoreEntityIDInput = AddValueInput<int>("要忽略的实体ID", "ignoreEntityID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int value = _ThrownIDInput.GetValue();
			if (value >= 0)
			{
				_Error.Call(f);
			}
			else
			{
				int value2 = _IgnoreEntityIDInput.GetValue();
				if (value2 <= 0)
				{
					_Error.Call(f);
				}
				else
				{
					List<int> list = FrameListPool<int>.Claim();
					list.Add(value2);
					ThrownProcessor.AddThrownHitHistory(base.mSimContext, value, list);
					FrameListPool<int>.Release(list);
					_Out.Call(f);
				}
			}
		});
	}
}
