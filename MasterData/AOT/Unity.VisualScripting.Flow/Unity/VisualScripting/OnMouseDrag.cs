using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseDrag : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnMouseDragMessageListener);

	protected override string hookName => "OnMouseDrag";
}
