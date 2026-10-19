using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseExit : GameObjectEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnMouseExitMessageListener);

	protected override string hookName => "OnMouseExit";
}
