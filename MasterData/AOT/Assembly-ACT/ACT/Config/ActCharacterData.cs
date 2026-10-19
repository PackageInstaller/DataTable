using System;

namespace ACT.Config;

[Serializable]
public class ActCharacterData
{
	public readonly int id;

	public readonly string name = "";

	public readonly float[] viewPosition = new float[0];

	public readonly float[] viewRotation = new float[0];

	public readonly float[] view1Position = new float[0];

	public readonly float[] view1Rotation = new float[0];

	public readonly float[] view2Position = new float[0];

	public readonly float[] view2Rotation = new float[0];

	public readonly float[] view3Position = new float[0];

	public readonly float[] view3Rotation = new float[0];

	public readonly float[] view4Position = new float[0];

	public readonly float[] view4Rotation = new float[0];

	public readonly float[] view5Position = new float[0];

	public readonly float[] view5Rotation = new float[0];

	public readonly float[] view6Position = new float[0];

	public readonly float[] view6Rotation = new float[0];

	public ActCharacterData(int id, string name, float[] viewPosition, float[] viewRotation, float[] view1Position, float[] view1Rotation, float[] view2Position, float[] view2Rotation, float[] view3Position, float[] view3Rotation, float[] view4Position, float[] view4Rotation, float[] view5Position, float[] view5Rotation, float[] view6Position, float[] view6Rotation)
	{
		this.id = id;
		this.name = name;
		this.viewPosition = viewPosition;
		this.viewRotation = viewRotation;
		this.view1Position = view1Position;
		this.view1Rotation = view1Rotation;
		this.view2Position = view2Position;
		this.view2Rotation = view2Rotation;
		this.view3Position = view3Position;
		this.view3Rotation = view3Rotation;
		this.view4Position = view4Position;
		this.view4Rotation = view4Rotation;
		this.view5Position = view5Position;
		this.view5Rotation = view5Rotation;
		this.view6Position = view6Position;
		this.view6Rotation = view6Rotation;
	}
}
