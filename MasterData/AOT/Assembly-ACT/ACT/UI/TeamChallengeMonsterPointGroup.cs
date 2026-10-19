using System.Collections.Generic;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public sealed class TeamChallengeMonsterPointGroup : MonoBehaviour
{
	private static readonly Dictionary<int, TeamChallengeMonsterPointGroup> GroupsByWorldId = new Dictionary<int, TeamChallengeMonsterPointGroup>();

	[SerializeField]
	private List<WorldMonsterPointComp> _monsterPoints = new List<WorldMonsterPointComp>();

	private int _registeredWorldId = -1;

	public IReadOnlyList<WorldMonsterPointComp> MonsterPoints => _monsterPoints;

	private void OnEnable()
	{
		RegisterCurrentWorld();
	}

	private void Start()
	{
		RegisterCurrentWorld();
	}

	private void OnDisable()
	{
		Unregister();
	}

	public static bool TryGetCurrentWorldGroup(out TeamChallengeMonsterPointGroup pointGroup)
	{
		pointGroup = null;
		if (!TryGetCurrentWorldId(out var worldId) || !GroupsByWorldId.TryGetValue(worldId, out pointGroup))
		{
			return false;
		}
		if (pointGroup != null && pointGroup.isActiveAndEnabled)
		{
			return true;
		}
		GroupsByWorldId.Remove(worldId);
		pointGroup = null;
		return false;
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void ClearRegisteredGroups()
	{
		GroupsByWorldId.Clear();
	}

	private void RegisterCurrentWorld()
	{
		if (_registeredWorldId < 0 && TryGetCurrentWorldId(out var worldId))
		{
			if (GroupsByWorldId.TryGetValue(worldId, out var value) && value != this)
			{
				Debug.LogError($"[TeamChallenge] World {worldId} has multiple monster point groups.", this);
				return;
			}
			GroupsByWorldId[worldId] = this;
			_registeredWorldId = worldId;
		}
	}

	private void Unregister()
	{
		if (_registeredWorldId >= 0)
		{
			if (GroupsByWorldId.TryGetValue(_registeredWorldId, out var value) && value == this)
			{
				GroupsByWorldId.Remove(_registeredWorldId);
			}
			_registeredWorldId = -1;
		}
	}

	private static bool TryGetCurrentWorldId(out int worldId)
	{
		worldId = -1;
		WorldManager worldManager = Singleton<GameManager>.instance?.worldManager;
		if (worldManager == null)
		{
			return false;
		}
		WorldBase currentWorld = worldManager.GetCurrentWorld();
		if (currentWorld == null)
		{
			return false;
		}
		worldId = currentWorld.WorldDataHandle.WorldID;
		return worldId > 0;
	}
}
