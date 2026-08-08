using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("On Variable Change", 0)]
[Category("Events/Other")]
[Description("Called when the target variable change. (Not whenever it is set).")]
public class VariableChangedEvent : EventNode
{
	[BlackboardOnly]
	public BBObjectParameter targetVariable;

	private FlowOutput fOut;

	private object newValue;

	public override string name => $"{base.name} [{targetVariable}]";

	public override void OnGraphStarted()
	{
		if (targetVariable.varRef != null)
		{
			targetVariable.varRef.onValueChanged += OnValueChanged;
		}
	}

	public override void OnGraphStoped()
	{
		if (targetVariable.varRef != null)
		{
			targetVariable.varRef.onValueChanged -= OnValueChanged;
		}
	}

	protected override void RegisterPorts()
	{
		fOut = AddFlowOutput("Out");
		AddValueOutput("Value", targetVariable.varType, () => newValue);
	}

	private void OnValueChanged(string name, object value)
	{
		newValue = value;
		fOut.Call(default(Flow));
	}

	private void OnVariableRefChange(Variable newVarRef)
	{
		if (newVarRef != null)
		{
			targetVariable.SetType(newVarRef.varType);
			GatherPorts();
		}
	}
}
