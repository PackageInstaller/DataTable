using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("UI Scrollbar", 0)]
[Category("Events/Object/UI")]
[Description("Called when the target UI Scrollbar value changed.")]
public class UIScrollbarEvent : EventNode<Scrollbar>
{
	private FlowOutput o;

	private float value;

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

	private void OnValueChanged(float value)
	{
		this.value = value;
		o.Call(default(Flow));
	}
}
