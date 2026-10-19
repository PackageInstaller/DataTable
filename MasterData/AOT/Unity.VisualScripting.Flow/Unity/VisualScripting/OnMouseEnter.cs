using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseEnter : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnMouseEnterMessageListener);

	protected override string hookName => "OnMouseEnter";
}
