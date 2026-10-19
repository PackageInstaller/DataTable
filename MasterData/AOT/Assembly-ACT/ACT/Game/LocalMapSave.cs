using System;
using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public class LocalMapSave : LuminSerializedScriptableObject
{
	public int wid;

	public Dictionary<int, MapCustomFlag> customFlags = new Dictionary<int, MapCustomFlag>();

	public Dictionary<int, int> serviceSaveStateIds = new Dictionary<int, int>();

	public Dictionary<int, int> serviceBehaveIds = new Dictionary<int, int>();

	public Map ToPB()
	{
		Map map = new Map();
		map.CustomFlags.Add(customFlags);
		foreach (KeyValuePair<int, int> serviceSaveStateId in serviceSaveStateIds)
		{
			map.ServiceSaveStateIds.Add(serviceSaveStateId.Key, serviceSaveStateId.Value);
		}
		foreach (KeyValuePair<int, int> serviceBehaveId in serviceBehaveIds)
		{
			map.ServiceBehaveIds.Add(serviceBehaveId.Key, serviceBehaveId.Value);
		}
		return map;
	}
}
