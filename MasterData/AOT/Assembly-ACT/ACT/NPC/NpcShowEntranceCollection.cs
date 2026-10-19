using System;
using System.Collections.Generic;
using ACT.Core;
using Bamboo.AssetField;
using Bamboo.ECS;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.NPC;

public class NpcShowEntranceCollection
{
	public enum State
	{
		Loading,
		Loaded,
		Removing,
		Removed
	}

	[JsonProperty]
	private int _npcConfigUid;

	[JsonProperty]
	private NpcType _npcType;

	[JsonProperty]
	private int _chunkID;

	[JsonProperty]
	private NpcWorldConfigSource _worldConfigSource;

	[JsonProperty]
	private int _gameWorldId;

	[JsonProperty]
	private List<NpcShowRule> _showRules;

	[JsonProperty]
	private List<int> _mutualExclusionNpcTableUid;

	[JsonProperty]
	private NpcCondition _conditions;

	[JsonProperty]
	private Vector3 _worldPosition;

	[JsonProperty]
	private YooAssetReference _npcConfig;

	[JsonProperty]
	private int _tipIconID = -1;

	[NonSerialized]
	private int _activeRuleIndex = -1;

	public int NpcConfigUid => _npcConfigUid;

	public NpcType NpcType => _npcType;

	public int ChunkID => _chunkID;

	public NpcWorldConfigSource WorldConfigSource => _worldConfigSource;

	public int GameWorldId => _gameWorldId;

	public bool IsGameWorldConfig
	{
		get
		{
			if (_worldConfigSource == NpcWorldConfigSource.GameWorld)
			{
				return _gameWorldId > 0;
			}
			return false;
		}
	}

	public List<NpcShowRule> ShowRules => GetOrCreateShowRules();

	public List<int> MutualExclusionNpcTableUid => _mutualExclusionNpcTableUid;

	public NpcCondition Conditions => GetPrimaryRule().Conditions;

	public Vector3 WorldPosition => GetActiveWorldPosition();

	public Vector3 WorldRotation => GetActiveWorldRotation();

	public int NpcTableUid => TableRule.GetNpcTableID(_npcConfigUid);

	public YooAssetReference NpcConfig => _npcConfig;

	public int TipIconID => _tipIconID;

	public int ActiveRuleIndex => _activeRuleIndex;

	public AssetLoadHandle ConfigHandle { get; set; }

	public AssetLoadHandle ActiveModelHandle { get; set; }

	public AssetLoadHandle PendingModelHandle { get; set; }

	public Entity EntityReference { get; set; }

	public NpcShowRule LoadedShowRule { get; set; }

	public NpcShowRule PendingShowRule { get; set; }

	[JsonIgnore]
	public Vector3? RuntimeWorldPositionOverride { get; set; }

	[JsonIgnore]
	public Vector3 RuntimeWorldPosition => RuntimeWorldPositionOverride ?? WorldPosition;

	[JsonIgnore]
	public Vector3? RuntimeWorldRotationOverride { get; set; }

	[JsonIgnore]
	public Vector3 RuntimeWorldRotation => RuntimeWorldRotationOverride ?? WorldRotation;

	[JsonIgnore]
	public int RuntimeLoadVersion { get; private set; }

	public State CurrentState { get; set; } = State.Removed;

	public float RemainFadeTime { get; set; } = 1f;

	public void ResetRuntimeState()
	{
		EnsureLegacyRulesMigrated();
		ConfigHandle = default;
		ActiveModelHandle = default;
		PendingModelHandle = default;
		EntityReference = default;
		LoadedShowRule = null;
		PendingShowRule = null;
		RuntimeWorldPositionOverride = null;
		RuntimeWorldRotationOverride = null;
		InvalidateRuntimeLoads();
		CurrentState = State.Removed;
		RemainFadeTime = 1f;
		_activeRuleIndex = -1;
	}

	public int BeginRuntimeLoad()
	{
		RuntimeLoadVersion++;
		return RuntimeLoadVersion;
	}

	public bool IsCurrentRuntimeLoad(int loadVersion)
	{
		return RuntimeLoadVersion == loadVersion;
	}

	public void InvalidateRuntimeLoads()
	{
		RuntimeLoadVersion++;
	}

	public List<NpcShowRule> GetOrCreateShowRules(Vector3 fallbackWorldPosition = default(Vector3))
	{
		EnsureLegacyRulesMigrated(fallbackWorldPosition);
		if (_showRules == null)
		{
			_showRules = new List<NpcShowRule>();
		}
		if (_showRules.Count == 0)
		{
			_showRules.Add(CreateRule(fallbackWorldPosition));
		}
		CleanupShowRules();
		return _showRules;
	}

	public NpcShowRule AddShowRule(Vector3 worldPosition = default(Vector3))
	{
		List<NpcShowRule> orCreateShowRules = GetOrCreateShowRules();
		NpcShowRule npcShowRule = CreateRule(worldPosition);
		orCreateShowRules.Add(npcShowRule);
		return npcShowRule;
	}

	public bool MigrateLegacyConditionAndWorldPositionToFirstShowRule(Vector3 fallbackWorldPosition = default(Vector3))
	{
		bool flag = _conditions != null;
		bool flag2 = _worldPosition != Vector3.zero;
		if (!flag && !flag2)
		{
			return false;
		}
		if (_showRules == null)
		{
			_showRules = new List<NpcShowRule>();
		}
		_showRules.RemoveAll((NpcShowRule rule) => rule == null);
		if (_showRules.Count == 0)
		{
			_showRules.Add(CreateRule(fallbackWorldPosition));
		}
		NpcShowRule npcShowRule = _showRules[0];
		bool flag3 = false;
		if (flag && npcShowRule.Conditions != _conditions)
		{
			npcShowRule.SetConditions(_conditions);
			flag3 = true;
		}
		Vector3 vector = (flag2 ? _worldPosition : fallbackWorldPosition);
		if (npcShowRule.WorldPosition != vector)
		{
			npcShowRule.WorldPosition = vector;
			flag3 = true;
		}
		CleanupShowRules();
		return flag3 | flag | flag2;
	}

	public void CleanupShowRules()
	{
		if (_showRules == null)
		{
			_showRules = new List<NpcShowRule>();
		}
		_showRules.RemoveAll((NpcShowRule rule) => rule == null);
		foreach (NpcShowRule showRule in _showRules)
		{
			showRule.Conditions.groups.RemoveAll((NpcConditionGroup group) => group == null);
			foreach (NpcConditionGroup group in showRule.Conditions.groups)
			{
				group.conditionWraps.RemoveAll((NpcConditionWrap conditionWrap) => conditionWrap.GetCondition() == null);
			}
		}
	}

	public void BindRuntimeContext()
	{
		foreach (NpcShowRule orCreateShowRule in GetOrCreateShowRules())
		{
			orCreateShowRule.Conditions.BindRuntimeContext();
		}
	}

	public void FreeRuntimeContext()
	{
		foreach (NpcShowRule orCreateShowRule in GetOrCreateShowRules())
		{
			orCreateShowRule.Conditions.FreeRuntimeContext();
		}
	}

	public int RefreshActiveRuleIndexWithoutCache()
	{
		List<NpcShowRule> orCreateShowRules = GetOrCreateShowRules();
		_activeRuleIndex = -1;
		for (int num = orCreateShowRules.Count - 1; num >= 0; num--)
		{
			if (orCreateShowRules[num].Conditions.IsPassWithoutCache())
			{
				_activeRuleIndex = num;
			}
		}
		return _activeRuleIndex;
	}

	public int RefreshActiveRuleIndexFromCache()
	{
		List<NpcShowRule> orCreateShowRules = GetOrCreateShowRules();
		_activeRuleIndex = -1;
		for (int i = 0; i < orCreateShowRules.Count; i++)
		{
			if (orCreateShowRules[i].Conditions.IsPassed)
			{
				_activeRuleIndex = i;
				break;
			}
		}
		return _activeRuleIndex;
	}

	public Vector3 GetActiveWorldPosition()
	{
		return GetActiveRule().WorldPosition;
	}

	public Vector3 GetActiveWorldRotation()
	{
		return GetActiveRule().WorldRotation;
	}

	public NpcShowRule GetActiveRule()
	{
		List<NpcShowRule> orCreateShowRules = GetOrCreateShowRules();
		if (_activeRuleIndex >= 0 && _activeRuleIndex < orCreateShowRules.Count)
		{
			return orCreateShowRules[_activeRuleIndex];
		}
		return orCreateShowRules[0];
	}

	public void MigrateLegacyFields(JObject legacyJson, Vector3 fallbackWorldPosition = default(Vector3))
	{
		if (legacyJson == null)
		{
			GetOrCreateShowRules(fallbackWorldPosition);
			return;
		}
		if (legacyJson["_showRules"] is JArray { Count: >0 })
		{
			GetOrCreateShowRules(fallbackWorldPosition);
			return;
		}
		NpcShowRule npcShowRule = CreateRule(legacyJson["_worldPosition"]?.ToObject<Vector3>() ?? fallbackWorldPosition);
		JToken jToken = legacyJson["_conditions"];
		if (jToken != null)
		{
			npcShowRule = new NpcShowRule();
			npcShowRule.WorldPosition = legacyJson["_worldPosition"]?.ToObject<Vector3>() ?? fallbackWorldPosition;
			NpcCondition npcCondition = jToken.ToObject<NpcCondition>();
			if (npcCondition != null)
			{
				npcShowRule.SetConditions(npcCondition);
			}
		}
		_showRules = new List<NpcShowRule> { npcShowRule };
		CleanupShowRules();
	}

	private void EnsureLegacyRulesMigrated(Vector3 fallbackWorldPosition = default(Vector3))
	{
		List<NpcShowRule> showRules = _showRules;
		if (showRules != null && showRules.Count > 0)
		{
			CleanupShowRules();
		}
		else if (_conditions != null || _worldPosition != Vector3.zero)
		{
			_showRules = new List<NpcShowRule> { CreateRule((_worldPosition != Vector3.zero) ? _worldPosition : fallbackWorldPosition, _conditions) };
			CleanupShowRules();
		}
		else if (_showRules == null)
		{
			_showRules = new List<NpcShowRule>();
		}
	}

	public NpcShowRule GetPrimaryRule()
	{
		return GetOrCreateShowRules()[0];
	}

	private static NpcShowRule CreateRule(Vector3 worldPosition, NpcCondition condition = null)
	{
		NpcShowRule npcShowRule = new NpcShowRule();
		npcShowRule.WorldPosition = worldPosition;
		if (condition != null)
		{
			npcShowRule.SetConditions(condition);
		}
		return npcShowRule;
	}
}
