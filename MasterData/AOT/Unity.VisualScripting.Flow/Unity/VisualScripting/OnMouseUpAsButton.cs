using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseUpAsButton : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnMouseUpAsButtonMessageListener);

	protected override string hookName => "OnMouseUpAsButton";
}
