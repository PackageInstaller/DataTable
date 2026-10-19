using UnityEngine;

namespace Unity.VisualScripting;

[TypeIcon(typeof(GUI))]
[UnitCategory("Events/GUI")]
[UnitOrder(0)]
public sealed class OnGUI : GlobalEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnGUI";
}
