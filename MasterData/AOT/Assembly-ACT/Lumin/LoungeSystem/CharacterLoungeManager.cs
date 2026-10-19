using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Lumin.LoungeSystem;

public class CharacterLoungeManager
{
	private Dictionary<int, CharacterLoungeData> characterDataDict;

	private Dictionary<int, GameObject> characterGoDict;

	private List<InteractionRecord> interactionHistory;

	public event Action<int, LoungeDefine.MoodState> OnMoodChanged;

	public CharacterLoungeManager()
	{
		characterDataDict = new Dictionary<int, CharacterLoungeData>();
		interactionHistory = new List<InteractionRecord>();
		characterGoDict = new Dictionary<int, GameObject>();
	}

	public CharacterLoungeData InitializeCharacter(int characterId)
	{
		if (!characterDataDict.ContainsKey(characterId))
		{
			CharacterLoungeData characterLoungeData = new CharacterLoungeData(characterId);
			characterDataDict[characterId] = characterLoungeData;
			characterLoungeData.IsUnlocked = true;
			return characterLoungeData;
		}
		return GetCharacterData(characterId);
	}

	public CharacterLoungeData GetCharacterData(int characterId)
	{
		if (characterDataDict.TryGetValue(characterId, out var value))
		{
			return value;
		}
		return null;
	}

	public GameObject GetCharacterGo(int characterId)
	{
		if (characterGoDict.TryGetValue(characterId, out var value))
		{
			return value;
		}
		return null;
	}

	public Dictionary<int, GameObject> GetCharacterGoDic()
	{
		return characterGoDict;
	}

	public void AddCharacterGo(int characterId, GameObject gameObject)
	{
		if (characterGoDict.TryGetValue(characterId, out var value))
		{
			if (!(value != null) || !(value == gameObject))
			{
				UnityEngine.Object.DestroyImmediate(value);
				characterGoDict[characterId] = gameObject;
			}
		}
		else
		{
			characterGoDict[characterId] = gameObject;
		}
	}

	public void RemoveCharacterGo(int characterId)
	{
		if (characterGoDict.TryGetValue(characterId, out var value) && !(value == null))
		{
			UnityEngine.Object.DestroyImmediate(value);
			characterGoDict.Remove(characterId);
		}
	}

	public void ClearCharacterGo()
	{
		foreach (GameObject value in characterGoDict.Values)
		{
			if (value != null)
			{
				UnityEngine.Object.Destroy(value);
			}
		}
		characterGoDict.Clear();
	}

	public void SetCharacterMood(int characterId, LoungeDefine.MoodState mood)
	{
		CharacterLoungeData characterData = GetCharacterData(characterId);
		if (characterData != null)
		{
			characterData.CurrentMood = mood;
			OnMoodChanged?.Invoke(characterId, mood);
		}
	}

	public void MoveCharacterToRoom(int characterId, int roomId)
	{
		CharacterLoungeData characterData = GetCharacterData(characterId);
		if (characterData != null)
		{
			characterData.CurrentRoomId = roomId;
			Debug.Log($"角色 {characterId} 移动到房间 {roomId}");
		}
	}

	public void RecordInteraction(int characterId, LoungeDefine.InteractionType type, int favorGained)
	{
		CharacterLoungeData characterData = GetCharacterData(characterId);
		if (characterData != null)
		{
			characterData.RecordInteraction();
			InteractionRecord item = new InteractionRecord(characterId, type, favorGained);
			interactionHistory.Add(item);
			if (interactionHistory.Count > 1000)
			{
				interactionHistory.RemoveAt(0);
			}
		}
	}

	public bool CanInteractWithCharacter(int characterId)
	{
		CharacterLoungeData characterData = GetCharacterData(characterId);
		if (characterData == null || !characterData.IsUnlocked)
		{
			return false;
		}
		return characterData.CanInteract();
	}

	public List<CharacterLoungeData> GetCharactersInRoom(int roomId)
	{
		return characterDataDict.Values.Where((CharacterLoungeData c) => c.CurrentRoomId == roomId && c.IsUnlocked).ToList();
	}

	public List<InteractionRecord> GetInteractionHistory(int characterId, int count = 10)
	{
		return (from r in interactionHistory
			where r.characterId == characterId
			orderby r.timestamp descending
			select r).Take(count).ToList();
	}
}
