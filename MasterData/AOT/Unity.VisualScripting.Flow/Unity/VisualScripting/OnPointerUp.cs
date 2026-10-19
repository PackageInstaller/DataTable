using System;

namespace Unity.VisualScripting;

[UnitOrder(13)]
[UnitCategory("Events/GUI")]
public sealed class OnPointerUp : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnPointerUpMessageListener);

	protected override string hookName => "OnPointerUp";
}
