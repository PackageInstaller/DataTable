using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[UnitOrder(17)]
public sealed class OnDrag : PointerEventUnit
{
	protected override string hookName => "OnDrag";

	public override Type MessageListenerType => typeof(UnityOnDragMessageListener);
}
