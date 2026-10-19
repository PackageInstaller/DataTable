using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class ACTDebugCommandConfig : LuminSerializedScriptableObject
{
	[HideInInspector]
	public Dictionary<int, int> missionAccount;
}
