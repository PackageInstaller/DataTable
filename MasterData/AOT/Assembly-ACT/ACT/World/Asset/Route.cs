using System;

namespace ACT.World.Asset;

[Serializable]
public class Route : IDataToBake
{
	public RoutePoint[] routePoints;
}
