using System;

namespace Unity.VisualScripting;

[UnitOrder(23)]
[UnitCategory("Events/GUI")]
public sealed class OnDeselect : GenericGuiEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnDeselectMessageListener);

	protected override string hookName => "OnDeselect";
}
