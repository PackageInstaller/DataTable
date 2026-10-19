using System;

namespace Unity.VisualScripting;

[UnitOrder(20)]
[UnitCategory("Events/GUI")]
public sealed class OnScroll : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnScrollMessageListener);

	protected override string hookName => "OnScroll";
}
