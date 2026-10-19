using System;
using UnityEngine.EventSystems;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[UnitOrder(21)]
public sealed class OnMove : GameObjectEventUnit<AxisEventData>
{
	public override Type MessageListenerType => typeof(UnityOnMoveMessageListener);

	protected override string hookName => "OnMove";

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput data { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		data = ValueOutput<AxisEventData>("data");
	}

	protected override void AssignArguments(Flow flow, AxisEventData data)
	{
		flow.SetValue(this.data, data);
	}
}
