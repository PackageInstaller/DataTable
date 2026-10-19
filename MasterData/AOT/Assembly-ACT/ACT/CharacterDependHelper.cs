using System.Collections.Generic;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using Google.Protobuf.Collections;

namespace ACT;

public static class CharacterDependHelper
{
	public static int GetEquipCount(int equipItemId)
	{
		MapField<int, Equip> mapField = CharacterDataHelper.GetCharacterRepository(0)?.CharacterDependSnapshot?.EquipSnapshot;
		if (mapField == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, Equip> item in mapField)
		{
			if (item.Value.Id == equipItemId)
			{
				num++;
			}
		}
		return num;
	}

	public static Equip GetCurWorldEquip(int equipUid)
	{
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (curCharacterRepository.CharacterDependSnapshot.EquipSnapshot.TryGetValue(equipUid, out var value))
		{
			return value;
		}
		if (curCharacterRepository.ExtraCharacterDependSnapshot.EquipSnapshot.TryGetValue(equipUid, out value))
		{
			return value;
		}
		return null;
	}

	public static Equip GetEquipBySnapshot(int equipUid, CharacterDependSnapshot snapshot)
	{
		if (snapshot == null || snapshot.EquipSnapshot == null)
		{
			return G.localPlayer.Inventory.GetEquip(equipUid);
		}
		if (snapshot.EquipSnapshot.ContainsKey(equipUid))
		{
			return snapshot.EquipSnapshot[equipUid];
		}
		return null;
	}

	public static int GetGemCount(int gemItemId)
	{
		MapField<int, Gem> mapField = CharacterDataHelper.GetCharacterRepository(0)?.CharacterDependSnapshot?.GemSnapshot;
		if (mapField == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, Gem> item in mapField)
		{
			if (item.Value.Id == gemItemId)
			{
				num++;
			}
		}
		return num;
	}

	public static Gem GetCurWorldGem(int gemUid)
	{
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (curCharacterRepository.CharacterDependSnapshot.GemSnapshot.TryGetValue(gemUid, out var value))
		{
			return value;
		}
		if (curCharacterRepository.ExtraCharacterDependSnapshot.GemSnapshot.TryGetValue(gemUid, out value))
		{
			return value;
		}
		return null;
	}

	public static Gem GetGemBySnapshot(int gemUid, CharacterDependSnapshot snapshot)
	{
		if (snapshot == null || snapshot.GemSnapshot == null)
		{
			return G.localPlayer.Inventory.GetGem(gemUid);
		}
		if (snapshot.GemSnapshot.ContainsKey(gemUid))
		{
			return snapshot.GemSnapshot[gemUid];
		}
		return null;
	}

	public static List<Equip> GetCurWorldAllEquip(bool includeExtra = false)
	{
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (curCharacterRepository != null)
		{
			List<Equip> list = new List<Equip>();
			if (curCharacterRepository.CharacterDependSnapshot != null)
			{
				list.AddRange(curCharacterRepository.CharacterDependSnapshot.EquipSnapshot.Values);
			}
			if (includeExtra && curCharacterRepository.ExtraCharacterDependSnapshot != null)
			{
				list.AddRange(curCharacterRepository.ExtraCharacterDependSnapshot.EquipSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static List<Equip> GetAllEquip(CharacterRepository repository)
	{
		if (repository != null)
		{
			List<Equip> list = new List<Equip>();
			if (repository.CharacterDependSnapshot != null)
			{
				list.AddRange(repository.CharacterDependSnapshot.EquipSnapshot.Values);
			}
			if (repository.ExtraCharacterDependSnapshot != null)
			{
				list.AddRange(repository.ExtraCharacterDependSnapshot.EquipSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static List<Equip> GetAllBagEquip()
	{
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(0);
		if (characterRepository != null)
		{
			List<Equip> list = new List<Equip>();
			if (characterRepository.CharacterDependSnapshot != null)
			{
				list.AddRange(characterRepository.CharacterDependSnapshot.EquipSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static List<Gem> GetCurWorldAllGem(bool includeExtra = false)
	{
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (curCharacterRepository != null)
		{
			List<Gem> list = new List<Gem>();
			if (curCharacterRepository.CharacterDependSnapshot != null)
			{
				list.AddRange(curCharacterRepository.CharacterDependSnapshot.GemSnapshot.Values);
			}
			if (includeExtra && curCharacterRepository.ExtraCharacterDependSnapshot != null)
			{
				list.AddRange(curCharacterRepository.ExtraCharacterDependSnapshot.GemSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static List<Gem> GetAllBagGem()
	{
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(0);
		if (characterRepository != null)
		{
			List<Gem> list = new List<Gem>();
			if (characterRepository.CharacterDependSnapshot != null)
			{
				list.AddRange(characterRepository.CharacterDependSnapshot.GemSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static List<Gem> GetAllGem(CharacterRepository repository)
	{
		if (repository != null)
		{
			List<Gem> list = new List<Gem>();
			if (repository.CharacterDependSnapshot != null)
			{
				list.AddRange(repository.CharacterDependSnapshot.GemSnapshot.Values);
			}
			if (repository.ExtraCharacterDependSnapshot != null)
			{
				list.AddRange(repository.ExtraCharacterDependSnapshot.GemSnapshot.Values);
			}
			return list;
		}
		return null;
	}

	public static void RemoveFromSnap(CharacterDependSnapshot repoSnap, CharacterDependSnapshot incomingSnap)
	{
		if (repoSnap == null || incomingSnap == null)
		{
			return;
		}
		foreach (KeyValuePair<int, Equip> item in incomingSnap.EquipSnapshot)
		{
			repoSnap.EquipSnapshot.Remove(item.Key);
			item.Value.RefreshItemInfo();
		}
		foreach (KeyValuePair<int, Gem> item2 in incomingSnap.GemSnapshot)
		{
			repoSnap.GemSnapshot.Remove(item2.Key);
			item2.Value.RefreshItemInfo();
		}
	}

	public static void MergeCharacterDependChange(int SceneEnum, CharacterRepository incoming, bool removeExcess)
	{
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(SceneEnum);
		MergePresenceCharacterDependDictionary(characterRepository.Characters, characterRepository.CharacterDependSnapshot, characterRepository.CharacterDependSnapshot.GemSnapshot, incoming.CharacterDependSnapshot?.GemSnapshot, removeExcess);
		MergePresenceCharacterDependDictionary(characterRepository.Characters, characterRepository.CharacterDependSnapshot, characterRepository.CharacterDependSnapshot.EquipSnapshot, incoming.CharacterDependSnapshot?.EquipSnapshot, removeExcess);
		MergePresenceCharacterDependDictionary(characterRepository.ExtraCharacters, characterRepository.CharacterDependSnapshot, characterRepository.ExtraCharacterDependSnapshot.GemSnapshot, incoming.ExtraCharacterDependSnapshot?.GemSnapshot, removeExcess);
		MergePresenceCharacterDependDictionary(characterRepository.ExtraCharacters, characterRepository.CharacterDependSnapshot, characterRepository.ExtraCharacterDependSnapshot.EquipSnapshot, incoming.ExtraCharacterDependSnapshot?.EquipSnapshot, removeExcess);
	}

	public static void MergePresenceCharacterDependDictionary<T>(MapField<int, Character> characters, CharacterDependSnapshot depend, MapField<int, T> current, MapField<int, T> incoming, bool removeExcess) where T : IMargeFrom<T>, IItemChangeEvent
	{
		if (current == null || incoming == null)
		{
			return;
		}
		List<int> list = ListPool<int>.Get();
		try
		{
			if (removeExcess)
			{
				foreach (KeyValuePair<int, T> item in current)
				{
					if (!incoming.ContainsKey(item.Key))
					{
						list.Add(item.Key);
					}
				}
				for (int i = 0; i < list.Count; i++)
				{
					current.Remove(list[i]);
				}
			}
			foreach (KeyValuePair<int, T> item2 in incoming)
			{
				if (current.ContainsKey(item2.Key))
				{
					if ((object)current[item2.Key] != (object)item2.Value)
					{
						current[item2.Key].TakeOff(characters, depend);
						current[item2.Key].MargeFrom(item2.Value);
					}
				}
				else
				{
					current.Add(item2.Key, item2.Value);
					current[item2.Key].Refresh();
				}
			}
			foreach (KeyValuePair<int, T> item3 in incoming)
			{
				current[item3.Key].Wear(characters, depend);
				current[item3.Key].RefreshItemInfo();
			}
		}
		finally
		{
			ListPool<int>.Release(list);
		}
	}
}
