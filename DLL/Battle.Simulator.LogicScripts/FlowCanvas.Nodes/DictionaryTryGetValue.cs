using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("DictionaryTryGetValue", 0)]
[Category("Common/Control")]
[Description("DictionaryTryGetValue")]
[ExposeAsDefinition]
public class DictionaryTryGetValue<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<IDictionary<int, T>> dictInput = AddValueInput<IDictionary<int, T>>("字典");
		ValueInput<int> keyInput = AddValueInput<int>("Key");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		T res = default(T);
		AddValueOutput("value", () => res);
		bool flag = false;
		AddValueOutput("flag", () => flag);
		AddFlowInput("", delegate(Flow f)
		{
			flag = dictInput.value.TryGetValue(keyInput.value, out res);
			if (flag)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
