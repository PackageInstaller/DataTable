using System;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[UnitOrder(5)]
[UnitCategory("Events/GUI")]
[TypeIcon(typeof(Toggle))]
public sealed class OnToggleValueChanged : GameObjectEventUnit<bool>
{
	public override Type MessageListenerType => typeof(UnityOnToggleValueChangedMessageListener);

	protected override string hookName => "OnToggleValueChanged";

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput<bool>("value");
	}

	protected override void AssignArguments(Flow flow, bool value)
	{
		flow.SetValue(this.value, value);
	}
}
