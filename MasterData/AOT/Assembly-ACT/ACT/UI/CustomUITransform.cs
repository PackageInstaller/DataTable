using Newtonsoft.Json;
using UnityEngine;

namespace ACT.UI;

public class CustomUITransform
{
	public float AnchorX { get; }

	public float AnchorY { get; }

	public Vector2 Pos { get; private set; }

	public float Diameter { get; private set; }

	[JsonConstructor]
	public CustomUITransform(float AnchorX, float AnchorY, float PosX, float PosY, float Diameter)
	{
		this.AnchorX = AnchorX;
		this.AnchorY = AnchorY;
		Pos = new Vector2(PosX, PosY);
		this.Diameter = Diameter;
	}

	public CustomUITransform(CustomUITransformConfig config)
	{
		AnchorX = config.anchorX;
		AnchorY = config.anchorY;
		Pos = config.pos;
		Diameter = config.diameter;
	}

	public CustomUITransform(CustomUITransform otherTransform)
	{
		AnchorX = otherTransform.AnchorX;
		AnchorY = otherTransform.AnchorY;
		Pos = otherTransform.Pos;
		Diameter = otherTransform.Diameter;
	}

	public void SetVal(Vector2 pos, float diameter)
	{
		SetPos(pos);
		SetDiameter(diameter);
	}

	private void SetPos(Vector2 pos)
	{
		Pos = pos;
	}

	private void SetDiameter(float diameter)
	{
		Diameter = diameter;
	}
}
