using System.Collections.Generic;
using ACT.Game.Data;
using UnityEngine;

namespace ACT;

public class WorldData
{
	public Team TeamInfo;

	public List<Character> TeamCharacters;

	public Vector3 SpawnPosition;

	public bool UseWorldSpawnPosition;

	public int WorldID;

	public int WorldConfigId;

	public bool IsReconnect;

	public string WorldConfigPath;

	public int TeamIndex;

	public int ChunkId { get; set; }

	public WorldData()
	{
		IsReconnect = false;
		UseWorldSpawnPosition = false;
	}

	public void Reset()
	{
		IsReconnect = false;
		UseWorldSpawnPosition = false;
	}
}
