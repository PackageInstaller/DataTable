using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("UI Dropdown", 0)]
[Category("Events/Object/UI")]
[Description("Called when the target UI Dropdown value changed.")]
public class UIDropdownEvent : EventNode<Dropdown>
{
	private FlowOutput o;

	private int value;

	public override void OnGraphStarted()
	{
		ResolveSelf();
		if (!target.isNull)
		{
			target.value.onValueChanged.AddListener(OnValueChanged);
		}
	}

	public override void OnGraphStoped()
	{
		if (!target.isNull)
		{
			target.value.onValueChanged.RemoveListener(OnValueChanged);
		}
	}

	protected override void RegisterPorts()
	{
		o = AddFlowOutput("Value Changed");
		AddValueOutput("This", () => target.value);
		AddValueOutput("Value", () => value);
	}

	private void OnValueChanged(int value)
	{
		this.value = value;
		o.Call(default(Flow));
	}
}
