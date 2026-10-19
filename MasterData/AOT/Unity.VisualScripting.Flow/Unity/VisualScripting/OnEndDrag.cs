using System;

namespace Unity.VisualScripting;

[TypeIcon(typeof(OnDrag))]
[UnitOrder(18)]
[UnitCategory("Events/GUI")]
public sealed class OnEndDrag : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnEndDragMessageListener);

	protected override string hookName => "OnEndDrag";
}
