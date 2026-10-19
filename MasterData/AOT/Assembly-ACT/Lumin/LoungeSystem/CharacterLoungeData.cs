using System;
using System.Collections.Generic;
using ACT.Model;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class CharacterLoungeData
{
	[SerializeField]
	private int characterId;

	[SerializeField]
	private int favorValue;

	[SerializeField]
	private int favorLevel;

	[SerializeField]
	private LoungeDefine.MoodState currentMood;

	[SerializeField]
	private int currentRoomId;

	[SerializeField]
	private bool isUnlocked;

	[SerializeField]
	private DateTime lastInteractionTime;

	[SerializeField]
	private Dictionary<string, bool> unlockedStoryIds;

	[SerializeField]
	private Vector3 positionInRoom;

	[SerializeField]
	private float intimacyBonus;

	private bool irreplaceable;

	public int CharacterId
	{
		get
		{
			return characterId;
		}
		set
		{
			characterId = value;
		}
	}

	public int FavorValue
	{
		get
		{
			return favorValue;
		}
		set
		{
			favorValue = value;
		}
	}

	public bool Irreplaceable
	{
		get
		{
			return irreplaceable;
		}
		set
		{
			irreplaceable = value;
		}
	}

	public int FavorLevel
	{
		get
		{
			return favorLevel;
		}
		private set
		{
			favorLevel = value;
		}
	}

	public LoungeDefine.MoodState CurrentMood
	{
		get
		{
			return currentMood;
		}
		set
		{
			currentMood = value;
		}
	}

	public int CurrentRoomId
	{
		get
		{
			return currentRoomId;
		}
		set
		{
			currentRoomId = value;
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

	public DateTime LastInteractionTime
	{
		get
		{
			return lastInteractionTime;
		}
		set
		{
			lastInteractionTime = value;
		}
	}

	public Dictionary<string, bool> UnlockedStoryIds => unlockedStoryIds ?? (unlockedStoryIds = new Dictionary<string, bool>());

	public Vector3 PositionInRoom
	{
		get
		{
			return positionInRoom;
		}
		set
		{
			positionInRoom = value;
		}
	}

	public float IntimacyBonus
	{
		get
		{
			return intimacyBonus;
		}
		set
		{
			intimacyBonus = value;
		}
	}

	public CharacterLoungeData()
	{
		unlockedStoryIds = new Dictionary<string, bool>();
		currentMood = LoungeDefine.MoodState.Normal;
		lastInteractionTime = DateTime.MinValue;
	}

	public CharacterLoungeData(int characterId)
		: this()
	{
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(characterId);
		this.characterId = characterId;
		(favorLevel, favorValue) = characterFavorInfo;
	}

	public bool CanInteract()
	{
		if (DateTime.Now - lastInteractionTime < TimeSpan.FromMinutes(1.0))
		{
			return false;
		}
		return true;
	}

	public void RecordInteraction()
	{
		lastInteractionTime = DateTime.Now;
	}

	public bool IsStoryUnlocked(string storyId)
	{
		if (unlockedStoryIds.ContainsKey(storyId))
		{
			return unlockedStoryIds[storyId];
		}
		return false;
	}

	public void UnlockStory(string storyId)
	{
		if (!unlockedStoryIds.ContainsKey(storyId))
		{
			unlockedStoryIds[storyId] = true;
		}
	}
}
