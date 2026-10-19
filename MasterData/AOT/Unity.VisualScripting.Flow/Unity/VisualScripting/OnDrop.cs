using System;

namespace Unity.VisualScripting;

[TypeIcon(typeof(OnDrag))]
[UnitCategory("Events/GUI")]
[UnitOrder(19)]
public sealed class OnDrop : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnDropMessageListener);

	protected override string hookName => "OnDrop";
}
