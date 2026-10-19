using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public class ConfigGroupAIUid : LuminSerializedScriptableObject
{
	[HideInInspector]
	public List<int> groupAiUids = new List<int>();

	public Dictionary<string, int> groupAiUidDict = new Dictionary<string, int>();
}
