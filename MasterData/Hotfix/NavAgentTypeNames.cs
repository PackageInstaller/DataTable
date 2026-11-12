using System.Collections.Generic;
using Pathfinding;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;
using UnityEngine.AI;

public static class NavAgentTypeNames
{
	public enum NavigationUpdateQualityLevel
	{
		LowQualityNavigationUpdate,
		MedQualityNavigationUpdate,
		GoodQualityNavigationUpdate,
		HighQualityNavigationUpdate
	}

	private static Dictionary<string, int> _nameToIDDict;

	private static Dictionary<int, string> _idToNameDict;

	public static readonly GraphMask HumanoidGraphMask = 1;

	public static readonly GraphMask FlyingGraphMask = 2;

	public const RVOLayer PlayerAgentLayerMask = RVOLayer.DefaultAgent;

	public const RVOLayer PlayerAgentCollidesWithLayerMask = RVOLayer.DefaultAgent | RVOLayer.DefaultObstacle | RVOLayer.Layer2;

	public static readonly int PlayerAgentPriority = 2;

	public static readonly FP PlayerAgentDamp = 1f;

	public const RVOLayer MonsterAgentLayerMask = RVOLayer.Layer2;

	public const RVOLayer MonsterAgentCollidesWithLayerMask = RVOLayer.DefaultAgent | RVOLayer.DefaultObstacle | RVOLayer.Layer2;

	public static readonly int MonsterAgentPriority = 3;

	public static readonly FP MonsterAgentDamp = 1f;

	public static readonly int UnmoveableAgentPriority = 999;

	public static readonly FP UnmoveableAgentDamp = 1f;

	public static void Initialize()
	{
		int settingsCount = NavMesh.GetSettingsCount();
		_nameToIDDict = new Dictionary<string, int>(settingsCount);
		_idToNameDict = new Dictionary<int, string>(settingsCount);
		for (int i = 0; i < settingsCount; i++)
		{
			int agentTypeID = NavMesh.GetSettingsByIndex(i).agentTypeID;
			string settingsNameFromID = NavMesh.GetSettingsNameFromID(agentTypeID);
			_nameToIDDict.Add(settingsNameFromID, agentTypeID);
			_idToNameDict.Add(agentTypeID, settingsNameFromID);
		}
	}

	public static int GetAgentIDFromName(string name)
	{
		if (_nameToIDDict == null)
		{
			Initialize();
		}
		if (_nameToIDDict != null && _nameToIDDict.TryGetValue(name, out var value))
		{
			return value;
		}
		Debug.LogErrorFormat("<NavAgentTypeNames> Agent \"{0}\" does not exist!", name);
		return 0;
	}

	public static string GetAgentNameFromID(int id)
	{
		if (_nameToIDDict == null)
		{
			Initialize();
		}
		if (_idToNameDict.TryGetValue(id, out var value))
		{
			return value;
		}
		Debug.LogErrorFormat("<NavAgentTypeNames> AgentID \"{0}\" does not exist!", id);
		return null;
	}
}
