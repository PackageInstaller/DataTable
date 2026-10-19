using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[UnitOrder(12)]
public sealed class OnPointerDown : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnPointerDownMessageListener);

	protected override string hookName => "OnPointerDown";
}
