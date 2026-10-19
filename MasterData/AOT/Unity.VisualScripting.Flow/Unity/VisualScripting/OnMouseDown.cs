using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseDown : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	protected override string hookName => "OnMouseDown";

	public override Type MessageListenerType => typeof(UnityOnMouseDownMessageListener);
}
