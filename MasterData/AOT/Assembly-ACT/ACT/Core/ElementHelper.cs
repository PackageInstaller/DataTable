namespace ACT.Core;

public class ElementHelper
{
	public static int Element2Id(ElementBitmask element)
	{
		return element switch
		{
			ElementBitmask.Promote => 1, 
			ElementBitmask.Disturb => 2, 
			ElementBitmask.Operate => 3, 
			ElementBitmask.Born => 4, 
			ElementBitmask.Ash => 5, 
			_ => 0, 
		};
	}

	public static ElementBitmask Id2Element(int elementId)
	{
		return elementId switch
		{
			1 => ElementBitmask.Promote, 
			2 => ElementBitmask.Disturb, 
			3 => ElementBitmask.Operate, 
			4 => ElementBitmask.Born, 
			5 => ElementBitmask.Ash, 
			_ => ElementBitmask.None, 
		};
	}

	public static int Element2LocalizeId(ElementBitmask element)
	{
		return CoreUtils.GetData(Element2Id(element), RuntimeConfigs.data.EnvironmentElements)?.localizeId ?? 0;
	}
}
