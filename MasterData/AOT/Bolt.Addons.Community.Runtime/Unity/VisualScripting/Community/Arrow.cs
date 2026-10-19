using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitTitle("Arrow")]
[UnitCategory("Community\\Documentation")]
public class Arrow : Unit
{
	[Inspectable]
	public float Length = 20f;

	[Inspectable]
	public float rotationAngle;

	[Inspectable]
	public Color Color = Color.red;

	[Inspectable]
	public Color ArrowColor = Color.red;

	[Inspectable]
	public string Text;

	public bool ShowSquare = true;

	public bool ShowBottomArrow = true;

	public bool ShowTopArrow = true;

	public LineType lineType;

	public override bool isControlRoot => true;

	protected override void Definition()
	{
	}
}
