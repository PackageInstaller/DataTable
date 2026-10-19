using UnityEngine;

namespace Unity.VisualScripting;

public class StickyNote : GraphElement<IGraph>
{
	public enum ColorEnum
	{
		Classic,
		Black,
		Dark,
		Orange,
		Green,
		Blue,
		Red,
		Purple,
		Teal
	}

	[DoNotSerialize]
	public static readonly Color defaultColor = new Color(0.969f, 0.91f, 0.624f);

	[Serialize]
	public Rect position { get; set; }

	[Serialize]
	public string title { get; set; } = "Sticky Note";

	[InspectorTextArea(minLines = 1f)]
	[Serialize]
	public string body { get; set; }

	[Inspectable]
	[Serialize]
	public ColorEnum colorTheme { get; set; }

	public static Color GetStickyColor(ColorEnum enumValue)
	{
		return enumValue switch
		{
			ColorEnum.Black => new Color(0.122f, 0.114f, 0.09f), 
			ColorEnum.Dark => new Color(0.184f, 0.145f, 0.024f), 
			ColorEnum.Orange => new Color(0.988f, 0.663f, 0.275f), 
			ColorEnum.Green => new Color(0.376f, 0.886f, 0.655f), 
			ColorEnum.Blue => new Color(0.518f, 0.725f, 0.855f), 
			ColorEnum.Red => new Color(1f, 0.502f, 0.502f), 
			ColorEnum.Purple => new Color(0.98f, 0.769f, 0.949f), 
			ColorEnum.Teal => new Color(0.475f, 0.878f, 0.89f), 
			_ => new Color(0.969f, 0.91f, 0.624f), 
		};
	}

	public static Color GetFontColor(ColorEnum enumValue)
	{
		if ((uint)(enumValue - 1) <= 1u)
		{
			return Color.white;
		}
		return Color.black;
	}
}
