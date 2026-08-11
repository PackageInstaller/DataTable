namespace Spine;

public class InheritEnum
{
	public static readonly Inherit[] Values = new Inherit[5]
	{
		Inherit.Normal,
		Inherit.OnlyTranslation,
		Inherit.NoRotationOrReflection,
		Inherit.NoScale,
		Inherit.NoScaleOrReflection
	};
}
