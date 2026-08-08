using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("UI Field Input", 0)]
[Category("Events/Object/UI")]
[Description("Called when the target UI Dropdown value changed.")]
public class UIInputFieldEvent : EventNode<InputField>
{
	private FlowOutput onValueChanged;

	private FlowOutput onEndEdit;

	private string value;

	public override void OnGraphStarted()
	{
		ResolveSelf();
		if (!target.isNull)
		{
			target.value.onValueChanged.AddListener(OnValueChanged);
			target.value.onEndEdit.AddListener(OnEndEdit);
		}
	}

	public override void OnGraphStoped()
	{
		if (!target.isNull)
		{
			target.value.onValueChanged.RemoveListener(OnValueChanged);
			target.value.onEndEdit.RemoveListener(OnEndEdit);
		}
	}

	protected override void RegisterPorts()
	{
		onValueChanged = AddFlowOutput("Value Changed");
		onEndEdit = AddFlowOutput("End Edit");
		AddValueOutput("This", () => target.value);
		AddValueOutput("Value", () => value);
	}

	private void OnValueChanged(string value)
	{
		this.value = value;
		onValueChanged.Call(default(Flow));
	}

	private void OnEndEdit(string value)
	{
		this.value = value;
		onEndEdit.Call(default(Flow));
	}
}
