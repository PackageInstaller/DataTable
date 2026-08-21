using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Get Other Of Type", 0)]
[Category("Variables/Blackboard")]
[Description("Use this to get a variable value from blackboards other than the one this flowscript is using")]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public class GetOtherVariable<T> : VariableNode
{
	public override string name => "Get Variable";

	protected override void RegisterPorts()
	{
		ValueInput<Blackboard> bb = AddValueInput<Blackboard>("Blackboard");
		ValueInput<string> varName = AddValueInput<string>("Variable");
		AddValueOutput("Value", () => bb.value.GetValue<T>(varName.value));
	}

	public override void SetVariable(object o)
	{
	}
}
