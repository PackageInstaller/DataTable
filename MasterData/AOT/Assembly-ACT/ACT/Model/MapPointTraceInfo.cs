using ACT.UI;
using ACT.World;

namespace ACT.Model;

public class MapPointTraceInfo
{
	public MapIconType iconType;

	public MapArea mapArea;

	public int pointId;

	public MapPointTraceInfo(MapIconType iconType, MapArea mapArea, int pointId)
	{
		this.iconType = iconType;
		this.mapArea = mapArea;
		this.pointId = pointId;
	}

	public MapPointTraceInfo()
	{
	}
}
