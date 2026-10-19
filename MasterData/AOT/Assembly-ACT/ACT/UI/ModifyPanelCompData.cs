using UnityEngine;

namespace ACT.UI;

public class ModifyPanelCompData
{
	public CustomUICompType Type { get; }

	public float AnchorX { get; }

	public float AnchorY { get; }

	public Vector2 Pos { get; private set; }

	public float Diameter { get; private set; }

	public ModifyPanelCompData(CustomUICompType type, float anchorX, float anchorY, Vector2 pos, float diameter)
	{
		Type = type;
		AnchorX = anchorX;
		AnchorY = anchorY;
		Pos = pos;
		Diameter = diameter;
	}

	public void SePosDelta(Vector2 delta)
	{
		Pos += delta;
	}

	public void SetPos(Vector2 newPos)
	{
		Pos = newPos;
	}

	public void SetDiameter(float newDiameter)
	{
		Diameter = newDiameter;
	}
}
