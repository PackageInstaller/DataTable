using System;
using System.Collections.Generic;
using ACT;
using ACT.Drama;
using ACT.Game.Data;
using Bamboo.AssetField;
using Fundamental;
using Lumin.LoungeSystem.UI;
using UnityEngine;

namespace Lumin.LoungeSystem;

public class InteractionManager
{
	private CharacterLoungeManager characterManager;

	private Dictionary<int, List<InteractionData>> characterInteractions;

	private Dictionary<string, TouchInteractionData> touchZones;

	private Dictionary<int, DateTime> interactionCooldowns;

	private Dictionary<int, Dictionary<int, AssetLoadHandle>> storyTimelineHandles;

	private Dictionary<int, AssetLoadHandle> globalStoryTimelineHandles;

	private Dictionary<int, int> globalStoryTimelineIndex;

	public event Action<int, InteractionData> OnInteractionStarted;

	public event Action<int, InteractionData, bool> OnInteractionCompleted;

	public event Action OnInteractionEnd;

	public event Action<int, string, TouchInteractionData> OnTouchInteraction;

	public InteractionManager(CharacterLoungeManager charManager)
	{
		characterManager = charManager;
		characterInteractions = new Dictionary<int, List<InteractionData>>();
		touchZones = new Dictionary<string, TouchInteractionData>();
		interactionCooldowns = new Dictionary<int, DateTime>();
		storyTimelineHandles = new Dictionary<int, Dictionary<int, AssetLoadHandle>>();
		globalStoryTimelineHandles = new Dictionary<int, AssetLoadHandle>();
		globalStoryTimelineIndex = new Dictionary<int, int>();
		InitializeTouchZones();
	}

	private void InitializeTouchZones()
	{
	}

	public void AddCharacterStoryTimelineHandle(int characterId, int dramaId, AssetLoadHandle handle)
	{
		if (storyTimelineHandles.TryGetValue(characterId, out var value))
		{
			if (!value.ContainsKey(dramaId))
			{
				value.Add(dramaId, handle);
			}
		}
		else
		{
			storyTimelineHandles[characterId] = new Dictionary<int, AssetLoadHandle>();
			storyTimelineHandles[characterId].Add(dramaId, handle);
		}
	}

	public void AddGlobalStoryTimelineHandle(int dramaId, AssetLoadHandle handle)
	{
		if (!globalStoryTimelineHandles.ContainsKey(dramaId))
		{
			globalStoryTimelineHandles.Add(dramaId, handle);
		}
	}

	public void AddGlobalStoryTimelineIndex(int dramaId, int pointId)
	{
		if (!globalStoryTimelineIndex.ContainsKey(dramaId))
		{
			globalStoryTimelineIndex.Add(dramaId, pointId);
		}
	}

	public int GetGlobalStoryTimelineIndex(int dramaId)
	{
		if (globalStoryTimelineIndex.TryGetValue(dramaId, out var value))
		{
			return value;
		}
		return 0;
	}

	public void RemoveGlobalStoryTimelineIndex(int dramaId)
	{
		if (globalStoryTimelineIndex.ContainsKey(dramaId))
		{
			globalStoryTimelineIndex.Remove(dramaId);
		}
	}

	public void RemoveStoryTimelineHandle()
	{
		RemoveAllGlobalStoryTimelineHandle();
		if (storyTimelineHandles.Count == 0)
		{
			return;
		}
		foreach (Dictionary<int, AssetLoadHandle> value in storyTimelineHandles.Values)
		{
			foreach (AssetLoadHandle value2 in value.Values)
			{
				if (value2.IsValid)
				{
					AssetStationManager.BattleStation.ReleaseInstance(value2);
				}
			}
		}
		storyTimelineHandles.Clear();
	}

	public void RemoveAllGlobalStoryTimelineHandle()
	{
		if (globalStoryTimelineHandles.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<int, AssetLoadHandle> globalStoryTimelineHandle in globalStoryTimelineHandles)
		{
			if (globalStoryTimelineHandle.Value.IsValid)
			{
				globalStoryTimelineIndex.Remove(globalStoryTimelineHandle.Key);
				AssetStationManager.BattleStation.ReleaseInstance(globalStoryTimelineHandle.Value);
			}
		}
		globalStoryTimelineIndex.Clear();
		globalStoryTimelineHandles.Clear();
	}

	public void RemoveGlobalStoryTimelineHandle(int dramaId)
	{
		if (globalStoryTimelineHandles.Count != 0 && globalStoryTimelineHandles.TryGetValue(dramaId, out var value) && value.IsValid)
		{
			globalStoryTimelineIndex.Remove(dramaId);
			globalStoryTimelineHandles.Remove(dramaId);
			AssetStationManager.BattleStation.ReleaseInstance(value);
		}
	}

	public GameObject GetCharacterStoryTimelineGo(int characterId, int dramaId)
	{
		if (storyTimelineHandles.Count == 0)
		{
			return null;
		}
		if (storyTimelineHandles.TryGetValue(characterId, out var value) && value.TryGetValue(dramaId, out var value2))
		{
			return value2.AsGameObject();
		}
		return null;
	}

	public GameObject GetGlobalStoryTimelineGo(int dramaId)
	{
		if (globalStoryTimelineHandles.Count == 0)
		{
			return null;
		}
		if (globalStoryTimelineHandles.TryGetValue(dramaId, out var value))
		{
			return value.AsGameObject();
		}
		return null;
	}

	public void AddCharacterInteraction(int characterId, List<InteractionData> interaction)
	{
		if (characterInteractions.TryGetValue(characterId, out var value))
		{
			value.Clear();
			value.AddRange(interaction);
		}
		else
		{
			characterInteractions[characterId] = new List<InteractionData>();
			characterInteractions[characterId].AddRange(interaction);
		}
	}

	public List<InteractionData> GetAvailableInteractions(int characterId)
	{
		if (!characterInteractions.TryGetValue(characterId, out var value))
		{
			return new List<InteractionData>();
		}
		CharacterLoungeData characterData = characterManager.GetCharacterData(characterId);
		if (characterData == null)
		{
			return new List<InteractionData>();
		}
		List<InteractionData> list = new List<InteractionData>();
		foreach (InteractionData item in value)
		{
			if (characterData.FavorLevel >= item.RequiredFavorLevel && !IsOnCooldown((int)item.InteractionType))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public async void PerformInteraction(int characterId, InteractionData interaction)
	{
		CharacterLoungeData characterData = characterManager.GetCharacterData(characterId);
		if (characterData == null || !characterData.IsUnlocked)
		{
			Debug.LogWarning($"角色 {characterId} 未解锁或不存在");
			return;
		}
		if (!characterManager.CanInteractWithCharacter(characterId))
		{
			Debug.LogWarning($"角色 {characterId} 今日互动次数已达上限");
			return;
		}
		if (IsOnCooldown((int)interaction.InteractionType))
		{
			Debug.LogWarning("互动 " + interaction.InteractionName + " 冷却中");
			return;
		}
		if (interaction.InteractionType == LoungeDefine.InteractionType.Chat)
		{
			await Singleton<ConversationManager>.instance.BeginConversation(interaction.StoryGroupId);
			LoungeUIScene.instance.SetCharacterAnimState(characterId, "LoungeEnterInteract");
		}
		OnInteractionStarted?.Invoke(characterId, interaction);
		SetCooldown((int)interaction.InteractionType, interaction.CooldownMinutes);
		OnInteractionCompleted?.Invoke(characterId, interaction, arg3: true);
		Debug.Log($"与角色 {characterId} 完成互动 {interaction.InteractionName}");
	}

	public void OnEndInteraction()
	{
		OnInteractionEnd?.Invoke();
	}

	public bool PerformTouchInteraction(int characterId, string zoneName)
	{
		CharacterLoungeData characterData = characterManager.GetCharacterData(characterId);
		if (characterData == null || !characterData.IsUnlocked)
		{
			return false;
		}
		if (!touchZones.TryGetValue(zoneName, out var value))
		{
			Debug.LogWarning("触摸区域 " + zoneName + " 不存在");
			return false;
		}
		if (characterData.FavorLevel < value.minFavorLevel)
		{
			Debug.LogWarning("好感度不足，无法触摸 " + zoneName);
			return false;
		}
		if (!characterManager.CanInteractWithCharacter(characterId))
		{
			Debug.LogWarning("今日互动次数已达上限");
			return false;
		}
		characterManager.RecordInteraction(characterId, LoungeDefine.InteractionType.Touch, value.favorChange);
		OnTouchInteraction?.Invoke(characterId, zoneName, value);
		if (value.reactions.Count > 0)
		{
			string arg = value.reactions[UnityEngine.Random.Range(0, value.reactions.Count)];
			Debug.Log($"角色 {characterId} 的反应: {arg}");
		}
		return true;
	}

	public bool GiveGift(int characterId, List<Item> gifts, int favorValue)
	{
		CharacterLoungeData characterData = characterManager.GetCharacterData(characterId);
		if (characterData == null || !characterData.IsUnlocked)
		{
			return false;
		}
		return true;
	}

	private bool IsOnCooldown(int interactionType)
	{
		if (interactionCooldowns.TryGetValue(interactionType, out var value))
		{
			return DateTime.Now < value;
		}
		return false;
	}

	private void SetCooldown(int interactionType, int minutes)
	{
		if (minutes > 0)
		{
			interactionCooldowns[interactionType] = DateTime.Now.AddMinutes(minutes);
		}
	}

	public TimeSpan GetRemainingCooldown(int interactionId)
	{
		if (interactionCooldowns.TryGetValue(interactionId, out var value))
		{
			TimeSpan timeSpan = value - DateTime.Now;
			if (!(timeSpan > TimeSpan.Zero))
			{
				return TimeSpan.Zero;
			}
			return timeSpan;
		}
		return TimeSpan.Zero;
	}
}
