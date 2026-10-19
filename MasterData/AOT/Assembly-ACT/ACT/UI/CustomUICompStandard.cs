namespace ACT.UI;

public class CustomUICompStandard
{
	public float OriginalSize { get; }

	public bool UseDiameter { get; }

	public CustomUICompShapeType ShapeType { get; }

	public CustomUICompStandard(CustomUICompStandardConfig config)
	{
		OriginalSize = config.originalSize;
		UseDiameter = config.useDiameter;
		ShapeType = config.shapeType;
	}
}
