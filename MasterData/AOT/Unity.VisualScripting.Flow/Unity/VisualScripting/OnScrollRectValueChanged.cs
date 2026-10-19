using System;
using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[UnitOrder(7)]
[TypeIcon(typeof(ScrollRect))]
public sealed class OnScrollRectValueChanged : GameObjectEventUnit<Vector2>
{
	public override Type MessageListenerType => typeof(UnityOnScrollRectValueChangedMessageListener);

	protected override string hookName => "OnScrollRectValueChanged";

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput<Vector2>("value");
	}

	protected override void AssignArguments(Flow flow, Vector2 value)
	{
		flow.SetValue(this.value, value);
	}
}
