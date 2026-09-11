using System;
using System.Collections.Generic;

namespace T0World;

[Serializable]
public class T0BedGameIceData
{
	public List<T0BedGameIceIdleData> iceIdleToDragDataList;

	public List<T0BedGameIceIdleData> iceDragToClickDataList;
}
