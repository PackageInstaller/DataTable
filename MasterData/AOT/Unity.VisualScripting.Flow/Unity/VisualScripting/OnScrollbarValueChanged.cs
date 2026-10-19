using System;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[UnitOrder(6)]
[TypeIcon(typeof(Scrollbar))]
[UnitCategory("Events/GUI")]
public sealed class OnScrollbarValueChanged : GameObjectEventUnit<float>
{
	public override Type MessageListenerType => typeof(UnityOnScrollbarValueChangedMessageListener);

	protected override string hookName => "OnScrollbarValueChanged";

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput<float>("value");
	}

	protected override void AssignArguments(Flow flow, float value)
	{
		flow.SetValue(this.value, value);
	}
}
