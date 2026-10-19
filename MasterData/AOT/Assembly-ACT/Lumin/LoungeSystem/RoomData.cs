using System;
using System.Collections.Generic;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class RoomData
{
	[SerializeField]
	private int roomId;

	[SerializeField]
	private int roomName;

	[SerializeField]
	private LoungeDefine.RoomType roomType;

	[SerializeField]
	private int comfortLevel;

	[SerializeField]
	private bool isUnlocked;

	[SerializeField]
	private List<int> charactersInRoom;

	[SerializeField]
	private List<int> furnitureIds;

	[SerializeField]
	private Dictionary<int, Vector3> spawnPoints;

	[SerializeField]
	private int maxCapacity;

	public int RoomId
	{
		get
		{
			return roomId;
		}
		set
		{
			roomId = value;
		}
	}

	public int RoomName
	{
		get
		{
			return roomName;
		}
		set
		{
			roomName = value;
		}
	}

	public LoungeDefine.RoomType RoomType
	{
		get
		{
			return roomType;
		}
		set
		{
			roomType = value;
		}
	}

	public int ComfortLevel
	{
		get
		{
			return comfortLevel;
		}
		set
		{
			comfortLevel = Mathf.Clamp(value, 0, 100);
		}
	}

	public bool IsUnlocked
	{
		get
		{
			return isUnlocked;
		}
		set
		{
			isUnlocked = value;
		}
	}

	public List<int> CharactersInRoom => charactersInRoom ?? (charactersInRoom = new List<int>());

	public List<int> FurnitureIds => furnitureIds ?? (furnitureIds = new List<int>());

	public Dictionary<int, Vector3> SpawnPoints => spawnPoints ?? (spawnPoints = new Dictionary<int, Vector3>());

	public int MaxCapacity
	{
		get
		{
			return maxCapacity;
		}
		set
		{
			maxCapacity = value;
		}
	}

	public RoomData()
	{
		charactersInRoom = new List<int>();
		furnitureIds = new List<int>();
		spawnPoints = new Dictionary<int, Vector3>();
		maxCapacity = 5;
	}

	public RoomData(int roomId, int roomName, LoungeDefine.RoomType roomType, Dictionary<int, Transform> points)
		: this()
	{
		this.roomId = roomId;
		this.roomName = roomName;
		this.roomType = roomType;
		spawnPoints.Clear();
		foreach (int key in points.Keys)
		{
			spawnPoints.Add(key, points[key].position);
		}
	}

	public bool AddCharacter(int characterId)
	{
		if (charactersInRoom.Count >= maxCapacity)
		{
			return false;
		}
		if (!charactersInRoom.Contains(characterId))
		{
			charactersInRoom.Add(characterId);
			return true;
		}
		return false;
	}

	public bool RemoveCharacter(int characterId)
	{
		return charactersInRoom.Remove(characterId);
	}

	public bool IsFull()
	{
		return charactersInRoom.Count >= maxCapacity;
	}

	public Vector3 GetAvailableSpawnPoint()
	{
		using (Dictionary<int, Vector3>.Enumerator enumerator = spawnPoints.GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				return enumerator.Current.Value;
			}
		}
		return Vector3.zero;
	}
}
