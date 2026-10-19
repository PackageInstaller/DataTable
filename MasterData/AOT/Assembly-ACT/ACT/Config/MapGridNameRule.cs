using System.Text;
using ACT.World;

namespace ACT.Config;

public class MapGridNameRule
{
	public static string GetFormatName(int areaId, int layerId, int gridTypeId, int rowId, int colId)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(areaId.ToString("0000"));
		stringBuilder.Append(layerId.ToString("00"));
		stringBuilder.Append(gridTypeId.ToString("0"));
		stringBuilder.Append(rowId.ToString("000"));
		stringBuilder.Append(colId.ToString("000"));
		return stringBuilder.ToString();
	}

	public static string GetFormatName(ACT.World.MapArea areaId, MapLayer layerId, string gridType, int rowId, int colId)
	{
		return GetFormatName((int)areaId, (int)layerId, GridTypeString2Id(gridType), rowId, colId);
	}

	public static string GetFormatName(ACT.World.MapArea areaId, MapLayer layerId, int gridTypeId, int rowId, int colId)
	{
		return GetFormatName((int)areaId, (int)layerId, gridTypeId, rowId, colId);
	}

	public static int GridTypeString2Id(string gridTypeString)
	{
		return gridTypeString switch
		{
			"Bg" => 1, 
			"Room" => 2, 
			"Detail" => 3, 
			_ => 0, 
		};
	}

	public static int GetRowByFormatName(string formatName)
	{
		return int.Parse(formatName.Substring(7, 3));
	}

	public static int GetColByFormatName(string formatName)
	{
		return int.Parse(formatName.Substring(10, 3));
	}
}
