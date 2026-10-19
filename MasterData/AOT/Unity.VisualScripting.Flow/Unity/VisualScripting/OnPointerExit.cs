using System;

namespace Unity.VisualScripting;

[UnitOrder(15)]
[UnitCategory("Events/GUI")]
public sealed class OnPointerExit : PointerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnPointerExitMessageListener);

	protected override string hookName => "OnPointerExit";
}
