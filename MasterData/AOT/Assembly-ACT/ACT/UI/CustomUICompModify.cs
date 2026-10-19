using UnityEngine;

namespace ACT.UI;

public class CustomUICompModify
{
	public CustomUICompType Type { get; }

	public Vector2 Pos { get; }

	public float Diameter { get; }

	public CustomUICompModify(CustomUICompType type, Vector2 pos, float diameter)
	{
		Type = type;
		Pos = pos;
		Diameter = diameter;
	}
}
