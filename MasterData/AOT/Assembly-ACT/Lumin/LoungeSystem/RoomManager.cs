using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using Fundamental;
using UnityEngine;

namespace Lumin.LoungeSystem;

public class RoomManager
{
	private Dictionary<int, RoomData> rooms;

	private Dictionary<int, FurnitureData> furnitureDatabase;

	private CharacterLoungeManager characterManager;

	public event Action<int> OnRoomUnlocked;

	public event Action<int, int> OnFurnitureAdded;

	public event Action<int, int> OnCharacterEnterRoom;

	public event Action<int, int> OnCharacterLeaveRoom;

	public RoomManager(CharacterLoungeManager charManager)
	{
		characterManager = charManager;
		rooms = new Dictionary<int, RoomData>();
		furnitureDatabase = new Dictionary<int, FurnitureData>();
	}

	public void SetRoomPoint(Dictionary<int, Dictionary<int, Transform>> points)
	{
		InitializeDefaultRooms(points);
	}

	private void InitializeDefaultRooms(Dictionary<int, Dictionary<int, Transform>> points)
	{
		foreach (KeyValuePair<int, Dictionary<int, Transform>> point in points)
		{
			AreaList data = CoreUtils.GetData(point.Key, RuntimeConfigs.data.areaLists);
			if (data != null)
			{
				AddRoom(new RoomData(point.Key, data.name, (LoungeDefine.RoomType)data.type, point.Value)
				{
					IsUnlocked = true,
					ComfortLevel = 50
				});
			}
		}
	}

	public void AddRoom(RoomData room)
	{
		if (!rooms.ContainsKey(room.RoomId))
		{
			rooms[room.RoomId] = room;
		}
	}

	public RoomData GetRoom(int roomId)
	{
		if (!rooms.TryGetValue(roomId, out var value))
		{
			return null;
		}
		return value;
	}

	public bool UnlockRoom(int roomId)
	{
		RoomData room = GetRoom(roomId);
		if (room != null && !room.IsUnlocked)
		{
			room.IsUnlocked = true;
			OnRoomUnlocked?.Invoke(roomId);
			Debug.Log($"房间 {room.RoomName} 已解锁");
			return true;
		}
		return false;
	}

	public List<RoomData> GetUnlockedRooms()
	{
		return rooms.Values.Where((RoomData r) => r.IsUnlocked).ToList();
	}

	public List<RoomData> GetRoomsByType(LoungeDefine.RoomType type)
	{
		return rooms.Values.Where((RoomData r) => r.RoomType == type).ToList();
	}

	public bool AddCharacterToRoom(int characterId, int roomId)
	{
		RoomData room = GetRoom(roomId);
		if (room == null || !room.IsUnlocked)
		{
			Debug.LogWarning($"房间 {roomId} 不存在或未解锁");
			return false;
		}
		CharacterLoungeData characterData = characterManager.GetCharacterData(characterId);
		if (characterData == null || !characterData.IsUnlocked)
		{
			Debug.LogWarning($"角色 {characterId} 不存在或未解锁");
			return false;
		}
		if (room.IsFull())
		{
			Debug.LogWarning($"房间 {room.RoomName} 已满");
			return false;
		}
		if (characterData.CurrentRoomId > 0)
		{
			RemoveCharacterFromRoom(characterId, characterData.CurrentRoomId);
		}
		if (room.AddCharacter(characterId))
		{
			characterManager.MoveCharacterToRoom(characterId, roomId);
			Vector3 availableSpawnPoint = room.GetAvailableSpawnPoint();
			characterData.PositionInRoom = availableSpawnPoint;
			OnCharacterEnterRoom?.Invoke(roomId, characterId);
			Debug.Log($"角色 {characterId} 进入房间 {room.RoomName}");
			return true;
		}
		return false;
	}

	public bool RemoveCharacterFromRoom(int characterId, int roomId)
	{
		RoomData room = GetRoom(roomId);
		if (room != null && room.RemoveCharacter(characterId))
		{
			OnCharacterLeaveRoom?.Invoke(roomId, characterId);
			Debug.Log($"角色 {characterId} 离开房间 {room.RoomName}");
			return true;
		}
		return false;
	}

	public List<CharacterLoungeData> GetCharactersInRoom(int roomId)
	{
		if (GetRoom(roomId) == null)
		{
			return new List<CharacterLoungeData>();
		}
		return characterManager.GetCharactersInRoom(roomId);
	}

	public bool AddFurnitureToRoom(int roomId, int furnitureId, Vector3 position, Quaternion rotation)
	{
		RoomData room = GetRoom(roomId);
		if (room == null || !room.IsUnlocked)
		{
			return false;
		}
		if (!furnitureDatabase.TryGetValue(furnitureId, out var value))
		{
			Debug.LogWarning($"家具 {furnitureId} 不存在");
			return false;
		}
		value.position = position;
		value.rotation = rotation;
		if (!room.FurnitureIds.Contains(furnitureId))
		{
			room.FurnitureIds.Add(furnitureId);
			room.ComfortLevel += value.comfortBonus;
			OnFurnitureAdded?.Invoke(roomId, furnitureId);
			Debug.Log($"家具 {value.furnitureName} 添加到房间 {room.RoomName}");
			return true;
		}
		return false;
	}

	public bool RemoveFurnitureFromRoom(int roomId, int furnitureId)
	{
		RoomData room = GetRoom(roomId);
		if (room == null)
		{
			return false;
		}
		if (room.FurnitureIds.Remove(furnitureId))
		{
			if (furnitureDatabase.TryGetValue(furnitureId, out var value))
			{
				room.ComfortLevel -= value.comfortBonus;
			}
			Debug.Log($"家具 {furnitureId} 从房间 {room.RoomName} 移除");
			return true;
		}
		return false;
	}

	public void RegisterFurniture(FurnitureData furniture)
	{
		if (!furnitureDatabase.ContainsKey(furniture.furnitureId))
		{
			furnitureDatabase[furniture.furnitureId] = furniture;
		}
	}

	public FurnitureData GetFurniture(int furnitureId)
	{
		if (!furnitureDatabase.TryGetValue(furnitureId, out var value))
		{
			return null;
		}
		return value;
	}

	public int GetTotalComfortLevel(int roomId)
	{
		RoomData room = GetRoom(roomId);
		if (room == null)
		{
			return 0;
		}
		int num = room.ComfortLevel;
		foreach (int furnitureId in room.FurnitureIds)
		{
			if (furnitureDatabase.TryGetValue(furnitureId, out var value))
			{
				num += value.comfortBonus;
			}
		}
		return num;
	}

	public bool UpgradeRoom(int roomId, int comfortIncrease = 0, int capacityIncrease = 0)
	{
		RoomData room = GetRoom(roomId);
		if (room == null)
		{
			return false;
		}
		room.ComfortLevel += comfortIncrease;
		room.MaxCapacity += capacityIncrease;
		Debug.Log($"房间 {room.RoomName} 升级: 舒适度+{comfortIncrease}, 容量+{capacityIncrease}");
		return true;
	}

	public RoomData GetRecommendedRoom(int characterId)
	{
		return (from r in rooms.Values
			where r.IsUnlocked && !r.IsFull()
			orderby GetTotalComfortLevel(r.RoomId) descending
			select r).FirstOrDefault();
	}

	public int MoveCharactersToRoom(List<int> characterIds, int roomId)
	{
		int num = 0;
		foreach (int characterId in characterIds)
		{
			if (AddCharacterToRoom(characterId, roomId))
			{
				num++;
			}
		}
		return num;
	}

	public void ClearRoom(int roomId)
	{
		RoomData room = GetRoom(roomId);
		if (room == null)
		{
			return;
		}
		foreach (int item in new List<int>(room.CharactersInRoom))
		{
			RemoveCharacterFromRoom(item, roomId);
		}
	}

	public void CalculateComfortLevelEffectMood(int roodID)
	{
		RoomData room = GetRoom(roodID);
		if (room == null)
		{
			return;
		}
		List<CharacterLoungeData> charactersInRoom = characterManager.GetCharactersInRoom(roodID);
		if (charactersInRoom.Count <= 0)
		{
			return;
		}
		LoungeDefine.MoodState moodState = LoungeDefine.MoodState.Normal;
		float num = room.ComfortLevel / Singleton<LoungeSystemManager>.instance.loungeConfig.defaultRoomComfort;
		if (num <= 0.5f)
		{
			moodState = LoungeDefine.MoodState.Sad;
		}
		else if (num < 1f && num > 0.5f)
		{
			moodState = LoungeDefine.MoodState.Unhappy;
		}
		else
		{
			moodState = ((num >= 1f && num < 1.2f) ? LoungeDefine.MoodState.Normal : ((num >= 1.2f && num < 1.5f) ? LoungeDefine.MoodState.Happy : LoungeDefine.MoodState.VeryHappy));
		}
		foreach (CharacterLoungeData item in charactersInRoom)
		{
			item.CurrentMood = moodState;
		}
	}
}
