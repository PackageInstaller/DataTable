using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("UI Toggle", 0)]
[Category("Events/Object/UI")]
[Description("Called when the target UI Toggle value changed.")]
public class UIToggleEvent : EventNode<UnityEngine.UI.Toggle>
{
	private FlowOutput o;

	private bool state;

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
		AddValueOutput("Value", () => state);
	}

	private void OnValueChanged(bool state)
	{
		this.state = state;
		o.Call(default(Flow));
	}
}
