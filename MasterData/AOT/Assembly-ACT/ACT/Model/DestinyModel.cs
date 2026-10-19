using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Bamboo.Collections;
using Fundamental;
using UnityEngine.Pool;

namespace ACT.Model;

public class DestinyModel : Model<DestinyModel>
{
	private Dictionary<int, int> characterDestinyActiveCount;

	private HashSet<int> _desRedActiveCharacterIds;

	private BMap<int, int> _characterDestinyCost;

	private const int MAX_COMMONDESTINYCOUNT = 6;

	public Dictionary<int, int> CharacterDestinyActiveCount => characterDestinyActiveCount;

	public BMap<int, int> characterDestinyCost => _characterDestinyCost;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnDestinyCostCountChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeLeaveWorld, ClearDestinyActiveCount);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, RefreshDestinyActiveCount);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_Add, CharacterAdd);
		_desRedActiveCharacterIds = HashSetPool<int>.Get();
		characterDestinyActiveCount = new Dictionary<int, int>();
		Dictionary<int, CharacterConstellationData> characterConstellationDatas = RuntimeConfigs.data.characterConstellationDatas;
		_characterDestinyCost = BMapPool<int, int>.Default.Get();
		foreach (KeyValuePair<int, CharacterConstellationData> item in characterConstellationDatas)
		{
			if (!_characterDestinyCost.ContainsKey(item.Value.characterId))
			{
				_characterDestinyCost.Add(item.Value.characterId, item.Value.costItemId);
			}
		}
		foreach (Item item2 in G.localPlayer.Inventory.Items)
		{
			InitCharacterDestinyCostData(_desRedActiveCharacterIds, item2);
		}
		ActiveDestinyRedDot(_desRedActiveCharacterIds);
	}

	private void ClearDestinyActiveCount(BaseEventContent obj)
	{
		characterDestinyActiveCount.Clear();
	}

	public void CharacterAdd(BaseEventContent obj)
	{
		if (obj is CharacterRefresh { character: not null } characterRefresh && G.localPlayer.Profile != null && G.localPlayer.Profile.SceneStatus == (SceneStatus)characterRefresh.sceneIndex)
		{
			characterDestinyActiveCount[characterRefresh.character.Id] = characterRefresh.character.GetActiveDestinyCount();
		}
	}

	public void RefreshDestinyActiveCount(BaseEventContent obj)
	{
		List<Character> curAllCharacters = CharacterDataHelper.GetCurAllCharacters();
		if (curAllCharacters == null || curAllCharacters.Count <= 0)
		{
			return;
		}
		foreach (Character item in curAllCharacters)
		{
			characterDestinyActiveCount[item.Id] = item.GetActiveDestinyCount();
		}
	}

	private void InitCharacterDestinyCostData(HashSet<int> data, Item cost)
	{
		foreach (KeyValuePair<int, int> item in _characterDestinyCost)
		{
			if (item.Value != cost.Id)
			{
				continue;
			}
			Character character = G.localPlayer.GetCharacter(item.Key);
			if (character == null)
			{
				continue;
			}
			if (character == null || character.ConstellationEnabledStatus.Count < 8)
			{
				if (cost.Count > 0)
				{
					data.Add(item.Key);
					ActiveDestinyRedDot(data);
					break;
				}
				DisableDestinyRedDot(item.Key);
			}
			else
			{
				DisableDestinyRedDot(item.Key);
			}
		}
	}

	private void OnDestinyCostCountChange(BaseEventContent obj)
	{
		List<Item> list = CollectionPool<List<Item>, Item>.Get();
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			if (_characterDestinyCost.ContainsValue(item.Id))
			{
				list.Add(item);
			}
		}
		_desRedActiveCharacterIds.Clear();
		foreach (Item item2 in list)
		{
			InitCharacterDestinyCostData(_desRedActiveCharacterIds, item2);
		}
		CollectionPool<List<Item>, Item>.Release(list);
	}

	public void ActiveDestinyRedDot(HashSet<int> activeDesCharacter)
	{
		if (activeDesCharacter.Count <= 0)
		{
			return;
		}
		foreach (int item in activeDesCharacter)
		{
			string nodeFullPath = string.Format(RedDotPathDefine.Character + "|{0}|Constellation", item);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath) && Singleton<RedDotManager>.instance.GetNode(nodeFullPath) == null)
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(nodeFullPath, active: true);
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: true);
			}
		}
	}

	public void DisableDestinyRedDot(int characterId)
	{
		if (characterId != 0)
		{
			string nodeFullPath = string.Format(RedDotPathDefine.Character + "|{0}|Constellation", characterId);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath) && Singleton<RedDotManager>.instance.GetNode(nodeFullPath) == null)
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(nodeFullPath);
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
			}
		}
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnDestinyCostCountChange);
		HashSetPool<int>.Release(_desRedActiveCharacterIds);
		characterDestinyActiveCount.Clear();
	}

	public int GetCharacterDestinyActiveCount(int characterId)
	{
		if (characterDestinyActiveCount.TryGetValue(characterId, out var value))
		{
			return value;
		}
		return 0;
	}

	public bool GetCharacterCouldGetDestinyCost(int characterId)
	{
		int num = 0;
		characterDestinyActiveCount.TryGetValue(characterId, out var value);
		if (_characterDestinyCost.TryGetValue(characterId, out var value2))
		{
			num = G.localPlayer.Inventory.GetItemCount(value2);
		}
		return 6 - value - num > 0;
	}

	public int GetCharacterCouldGetDestinyCostCount(int characterId)
	{
		int num = 0;
		characterDestinyActiveCount.TryGetValue(characterId, out var value);
		if (_characterDestinyCost.TryGetValue(characterId, out var value2))
		{
			num = G.localPlayer.Inventory.GetItemCount(value2);
		}
		return 6 - value - num;
	}

	public int GetMaxCommonDestinyCount()
	{
		return 6;
	}
}
