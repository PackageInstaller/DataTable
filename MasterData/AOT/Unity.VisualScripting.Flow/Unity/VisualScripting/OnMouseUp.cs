using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseUp : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnMouseUpMessageListener);

	protected override string hookName => "OnMouseUp";
}
