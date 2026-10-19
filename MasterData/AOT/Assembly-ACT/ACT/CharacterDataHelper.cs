using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model;

namespace ACT;

public class CharacterDataHelper
{
	private static SceneStatus Scene_Status
	{
		get
		{
			if (G.localPlayer.Profile != null)
			{
				return G.localPlayer.Profile.SceneStatus;
			}
			return SceneStatus.Main;
		}
	}

	public static CharacterRepository GetCurCharacterRepository()
	{
		return GetCharacterRepository((int)Scene_Status);
	}

	public static CharacterRepository GetCharacterRepository(SceneStatus sceneStatus)
	{
		return GetCharacterRepository((int)sceneStatus);
	}

	public static CharacterRepository GetCharacterRepository(int sceneStatus)
	{
		if (!G.localPlayer.characterRepository.TryGetValue(sceneStatus, out var value))
		{
			value = new CharacterRepository();
			value.CharacterDependSnapshot = new CharacterDependSnapshot();
			value.ExtraCharacterDependSnapshot = new CharacterDependSnapshot();
			G.localPlayer.characterRepository.Add(sceneStatus, value);
		}
		return value;
	}

	public static bool TryGetCharacter(SceneStatus sceneStatus, int characterId, out Character character)
	{
		return TryGetCharacter(GetCharacterRepository(sceneStatus), characterId, out character);
	}

	public static bool TryGetCharacter(CharacterRepository characterRepository, int characterId, out Character character)
	{
		character = null;
		if (characterRepository.Characters.TryGetValue(characterId, out var value))
		{
			character = value;
			return true;
		}
		return false;
	}

	public static bool TryGetExtraCharacter(SceneStatus sceneStatus, int characterId, out Character character)
	{
		return TryGetExtraCharacter(GetCharacterRepository(sceneStatus), characterId, out character);
	}

	public static bool TryGetExtraCharacter(CharacterRepository characterRepository, int characterId, out Character character)
	{
		character = null;
		if (characterRepository.ExtraCharacters.TryGetValue(characterId, out var value))
		{
			character = value;
			return true;
		}
		return false;
	}

	public static List<Character> GetAllCharactersByTeamInfo(SceneStatus sceneStatus, Team team)
	{
		CharacterRepository characterRepository = GetCharacterRepository(sceneStatus);
		List<Character> list = new List<Character>();
		foreach (int characterId in team.CharacterIds)
		{
			if (TryGetCharacter(characterRepository, characterId, out var character))
			{
				list.Add(character);
			}
		}
		foreach (int extraCharacterId in team.ExtraCharacterIds)
		{
			if (TryGetExtraCharacter(characterRepository, extraCharacterId, out var character2))
			{
				list.Add(character2);
			}
		}
		return list.FindAll((Character c) => c != null);
	}

	public static Character GetCharacterByCharacterSource(ICharacterSource source)
	{
		if (source is Character { IsTrailCharacter: not false } character)
		{
			return character;
		}
		int characterId = source.Id();
		return G.localPlayer.GetCharacterByCharacterIndentify(characterId, source.GetCharacterIndentify());
	}

	public static List<Character> CreateTrialCharacterTeamByProbationIds(IEnumerable<int> probationIds)
	{
		List<Character> list = new List<Character>();
		if (probationIds == null || RuntimeConfigs.data?.entityCharacterProbations == null)
		{
			return list;
		}
		HashSet<int> addedCharacterIds = new HashSet<int>();
		foreach (int probationId in probationIds)
		{
			if (probationId > 0 && RuntimeConfigs.data.entityCharacterProbations.TryGetValue(probationId, out var value) && value != null)
			{
				CreateTrialCharacter(list, addedCharacterIds, value.characterId, probationId, value);
			}
		}
		return list;
	}

	public static List<Character> CreateRogueCharacterTeamByProbationIds(IEnumerable<int> probationIds)
	{
		List<Character> list = new List<Character>();
		if (probationIds == null || RuntimeConfigs.data?.entityCharacterProbations == null)
		{
			return list;
		}
		HashSet<int> addedCharacterIds = new HashSet<int>();
		foreach (int probationId in probationIds)
		{
			if (probationId > 0 && RuntimeConfigs.data.entityCharacterProbations.TryGetValue(probationId, out var value) && value != null)
			{
				EntityCharacterProbation entityCharacterProbation = CopyProbationForRogueTeam(value);
				CreateTrialCharacter(list, addedCharacterIds, entityCharacterProbation.characterId, probationId, entityCharacterProbation);
			}
		}
		return list;
	}

	private static EntityCharacterProbation CopyProbationForRogueTeam(EntityCharacterProbation probation)
	{
		int num = probation.characterLv;
		int skinId = probation.skinId;
		if (TryGetBagCharacterById(probation.characterId, out var character))
		{
			num = Math.Max(num, character.Level);
			skinId = character.SkinId;
		}
		if (num == probation.characterLv && skinId == probation.skinId)
		{
			return probation;
		}
		return new EntityCharacterProbation(probation.id, probation.characterId, skinId, num, probation.stageLevel, probation.weaponId, probation.equipId, probation.weaponStageLevel, probation.constellationLv, probation.chipGroup, probation.skillLevel, probation.eliteCharacter, probation.equip, probation.extraAbility, probation.showIcon, probation.showText, probation.isShow);
	}

	public static List<Character> CreateCharacterViewDisplayCharacters(IEnumerable<int> trialProbationIds, IEnumerable<Character> ownedCharacters = null)
	{
		List<Character> list = CreateTrialCharacterTeamByProbationIds(trialProbationIds);
		if (ownedCharacters == null)
		{
			return list;
		}
		HashSet<int> hashSet = new HashSet<int>();
		foreach (Character item in list)
		{
			hashSet.Add(item.Id);
		}
		foreach (Character ownedCharacter in ownedCharacters)
		{
			if (ownedCharacter != null && hashSet.Add(ownedCharacter.Id))
			{
				list.Add(ownedCharacter);
			}
		}
		return list;
	}

	private static void CreateTrialCharacter(List<Character> characters, HashSet<int> addedCharacterIds, int characterId, int probationId, EntityCharacterProbation probation)
	{
		if (characterId <= 0 || RuntimeConfigs.data?.entityCharacterDatas == null || !RuntimeConfigs.data.entityCharacterDatas.ContainsKey(characterId) || !addedCharacterIds.Add(characterId))
		{
			return;
		}
		Character character = new Character
		{
			Id = characterId,
			SkinId = characterId,
			Level = 1,
			EliteInfo = new CharacterEliteInfo()
		};
		character.SetTrialProbationId(probationId);
		if (probation != null)
		{
			character.SkinId = ((probation.skinId > 0) ? probation.skinId : characterId);
			character.Level = probation.characterLv;
			character.Stage = probation.stageLevel;
			character.Constellation = probation.constellationLv;
			if (probation.skillLevel != null)
			{
				foreach (ItemKv item in probation.skillLevel)
				{
					if (item != null && item.id > 0)
					{
						character.SkillGroupLevels[item.id] = item.count;
					}
				}
			}
			if (probation.eliteCharacter != null)
			{
				int[] array = CoreUtils.GetData(characterId, RuntimeConfigs.data.eliteTrainingMaps)?.pointList;
				int num = 0;
				foreach (ItemKv item2 in probation.eliteCharacter)
				{
					if (item2 != null && item2.id > 0)
					{
						int key = ((array != null && num < array.Length) ? array[num] : item2.id);
						character.EliteInfo.Levels[key] = item2.count;
						num++;
					}
				}
			}
			if (RuntimeConfigs.data.characterConstellationDatas != null)
			{
				foreach (CharacterConstellationData value in RuntimeConfigs.data.characterConstellationDatas.Values)
				{
					if (value.characterId == characterId && value.constellationLevel <= probation.constellationLv)
					{
						character.ConstellationEnabledStatus[value.id] = true;
					}
				}
			}
		}
		character.SetCharacterTeamInfo(new CharacterIdentify(0, isTrailCharacter: true));
		CharacterDependSnapshot characterDependSnapshot = new CharacterDependSnapshot();
		character.SetCharacterDependSnapshot(characterDependSnapshot);
		CreateTrialEquips(character, probation, characterDependSnapshot);
		Model<CharacterModel>.Interface.InitCharacterProperties(character);
		ApplyTrialEquipProperties(character);
		ApplyTrialEquipFeatures(character);
		characters.Add(character);
	}

	private static void CreateTrialEquips(Character character, EntityCharacterProbation probation, CharacterDependSnapshot snapshot)
	{
		if (character == null || probation == null || snapshot == null || probation.equip == null)
		{
			return;
		}
		Dictionary<int, CharacterEquipProbation> dictionary = RuntimeConfigs.data?.characterEquipProbations;
		if (dictionary == null)
		{
			return;
		}
		for (int i = 0; i < probation.equip.Length; i++)
		{
			int num = probation.equip[i];
			if (num > 0 && dictionary.TryGetValue(num, out var value))
			{
				CreateTrialEquip(character, snapshot, i + 1, value.weaponId, value.weaponGem, value.weaponAttribute);
			}
		}
	}

	private static bool CreateTrialEquip(Character character, CharacterDependSnapshot snapshot, int slotIndex, int[] equipInfo, int[] gemIds, int[][] weaponAttribute = null)
	{
		if (snapshot == null || equipInfo == null || equipInfo.Length <= 0 || !RuntimeConfigs.data.equipDatas.ContainsKey(equipInfo[0]))
		{
			return false;
		}
		int num = -(character.Id * 10 + slotIndex);
		Equip equip = new Equip
		{
			Uid = num,
			Id = equipInfo[0],
			Level = ((equipInfo.Length <= 1 || equipInfo[1] <= 0) ? 1 : equipInfo[1]),
			WearCharacter = character.Id
		};
		if (gemIds != null)
		{
			for (int i = 0; i < gemIds.Length; i++)
			{
				int num2 = gemIds[i];
				if (num2 > 0 && RuntimeConfigs.data.equipGemDatas.ContainsKey(num2))
				{
					int num3 = -(character.Id * 100 + slotIndex * 10 + i);
					Gem gem = new Gem
					{
						Uid = num3,
						Id = num2
					};
					gem.Refresh();
					snapshot.GemSnapshot[num3] = gem;
					equip.GemSlots.Add(new GemSlot
					{
						SlotId = i,
						GemId = num3
					});
				}
			}
		}
		ApplyTrialEquipAttributes(equip, weaponAttribute);
		snapshot.EquipSnapshot[num] = equip;
		equip.SetSnapshot(snapshot);
		equip.Refresh();
		character.Equips[slotIndex] = num;
		return true;
	}

	private static void ApplyTrialEquipProperties(Character character)
	{
		if (character?.systemProperty != null && character.Equips != null && character.Equips.Count != 0)
		{
			character.systemProperty.ReplaceSystemProperties(character.GetEquipProperty(), SystemPropertySource.Equip);
		}
	}

	private static void ApplyTrialEquipFeatures(Character character)
	{
		if (character != null && character.Equips != null && character.Equips.Count != 0)
		{
			character.CalculateTrialEquipFeatureData();
		}
	}

	private static void ApplyTrialEquipAttributes(Equip equip, int[][] weaponAttribute)
	{
		if (equip == null || weaponAttribute == null)
		{
			return;
		}
		foreach (int[] array in weaponAttribute)
		{
			if (array != null && array.Length >= 2 && array[0] > 0)
			{
				equip.Attributes.Add(new EquipAttr
				{
					Id = array[0],
					Value = ToTrialEquipAttributeValue(array[0], array[1])
				});
			}
		}
	}

	private static float ToTrialEquipAttributeValue(int equipAttrId, int rawValue)
	{
		StaticData data = RuntimeConfigs.data;
		if (data?.equipAttrDatas == null || !data.equipAttrDatas.TryGetValue(equipAttrId, out var value) || data.propertyDatas == null || !data.propertyDatas.TryGetValue(value.attrId, out var value2) || !value2.judge)
		{
			return rawValue;
		}
		return (float)rawValue / 10000f;
	}

	public static List<Character> GetCurTeamCharacters()
	{
		Team teamInfo = TeamInfoExtension.GetTeamInfo();
		if (teamInfo == null)
		{
			return null;
		}
		List<Character> list = new List<Character>();
		CharacterRepository curCharacterRepository = GetCurCharacterRepository();
		foreach (int characterId in teamInfo.CharacterIds)
		{
			if (TryGetCharacter(curCharacterRepository, characterId, out var character))
			{
				list.Add(character);
			}
		}
		foreach (int extraCharacterId in teamInfo.ExtraCharacterIds)
		{
			if (TryGetExtraCharacter(curCharacterRepository, extraCharacterId, out var character2))
			{
				list.Add(character2);
			}
		}
		return list.FindAll((Character c) => c != null);
	}

	public static List<Character> GetAllCharactersByRepositoyIndex(int snapshotTeamIndex)
	{
		if (!G.localPlayer.characterRepository.ContainsKey(snapshotTeamIndex))
		{
			return null;
		}
		CharacterRepository characterRepository = GetCharacterRepository(snapshotTeamIndex);
		List<Character> list = new List<Character>();
		list.AddRange(characterRepository.Characters.Values);
		list.AddRange(characterRepository.ExtraCharacters.Values);
		list.RemoveAll(IsProtagonistCharacter);
		return list;
	}

	public static List<Character> GetCurAllCharacters()
	{
		return GetAllCharactersByRepositoyIndex((int)Scene_Status);
	}

	public static List<Character> GetBagCharacters()
	{
		CharacterRepository characterRepository = GetCharacterRepository(0);
		List<Character> list = new List<Character>();
		list.AddRange(characterRepository.Characters.Values);
		list.RemoveAll(IsProtagonistCharacter);
		return list;
	}

	private static bool IsProtagonistCharacter(Character character)
	{
		return CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas)?.isProtagonist ?? false;
	}

	public static bool CheckIsHaveCharacterById(int characterId)
	{
		return GetCharacterRepository(0).Characters.ContainsKey(characterId);
	}

	public static bool TryGetBagCharacterById(int characterId, out Character character)
	{
		GetCharacterRepository(0).Characters.TryGetValue(characterId, out character);
		return character != null;
	}

	public static Character GetCurCharacterByCharacterId(int characterId)
	{
		CharacterRepository curCharacterRepository = GetCurCharacterRepository();
		if (curCharacterRepository.Characters.TryGetValue(characterId, out var value))
		{
			return value;
		}
		if (curCharacterRepository.ExtraCharacters.TryGetValue(characterId, out value))
		{
			return value;
		}
		return null;
	}

	public static Character GetOrCloneCurrentWorldCharacter(int characterId)
	{
		if (characterId == 0)
		{
			return null;
		}
		Character curCharacterByCharacterId = GetCurCharacterByCharacterId(characterId);
		if (curCharacterByCharacterId != null)
		{
			return curCharacterByCharacterId;
		}
		if (!TryGetBagCharacterById(characterId, out var character) || character == null)
		{
			return null;
		}
		int scene_Status = (int)Scene_Status;
		if (scene_Status == 0)
		{
			return character;
		}
		return CloneBagCharacterToRepository(scene_Status, character);
	}

	private static Character CloneBagCharacterToRepository(int sceneStatusIndex, Character bagCharacter)
	{
		CharacterRepository characterRepository = GetCharacterRepository(sceneStatusIndex);
		if (characterRepository.Characters.TryGetValue(bagCharacter.Id, out var value) && value != null)
		{
			return value;
		}
		Character character = bagCharacter.Clone();
		characterRepository.Characters[bagCharacter.Id] = character;
		CopyCharacterDependsFromSource(bagCharacter, characterRepository.CharacterDependSnapshot);
		character.SetCharacterTeamInfo(new CharacterIdentify(sceneStatusIndex));
		character.Refresh();
		AddCharacter(sceneStatusIndex, character);
		return character;
	}

	private static void CopyCharacterDependsFromSource(Character source, CharacterDependSnapshot targetSnapshot)
	{
		if (source == null || targetSnapshot == null)
		{
			return;
		}
		foreach (int value in source.Equips.Values)
		{
			CopyEquipDependFromSource(source, targetSnapshot, value);
		}
	}

	private static void CopyEquipDependFromSource(Character source, CharacterDependSnapshot targetSnapshot, int equipUid)
	{
		if (equipUid == 0 || targetSnapshot.EquipSnapshot.ContainsKey(equipUid))
		{
			return;
		}
		Equip equip = source.GetEquip(equipUid);
		if (equip == null)
		{
			return;
		}
		Equip equip2 = equip.Clone();
		equip2.SetSnapshot(targetSnapshot);
		targetSnapshot.EquipSnapshot[equipUid] = equip2;
		if (equip2.GemSlots == null)
		{
			return;
		}
		foreach (GemSlot gemSlot in equip2.GemSlots)
		{
			if (gemSlot.GemId != 0 && !targetSnapshot.GemSnapshot.ContainsKey(gemSlot.GemId))
			{
				Gem gem = source.GetGem(gemSlot.GemId);
				if (gem != null)
				{
					targetSnapshot.GemSnapshot[gemSlot.GemId] = gem.Clone();
				}
			}
		}
	}

	public static void MergeCharacterRepository(int sceneStatusIndex, CharacterRepository other, bool removeExcess)
	{
		CharacterRepository characterRepository = GetCharacterRepository(sceneStatusIndex);
		MergeCharacterDictionary(sceneStatusIndex, isExtraCharacter: false, characterRepository.Characters, other.Characters, removeExcess);
		MergeCharacterDictionary(sceneStatusIndex, isExtraCharacter: true, characterRepository.ExtraCharacters, other.ExtraCharacters, removeExcess: true);
	}

	public static void MergeCharacterDictionary(int sceneStatusIndex, bool isExtraCharacter, MapField<int, Character> current, MapField<int, Character> incoming, bool removeExcess)
	{
		List<int> list = ListPool<int>.Get();
		foreach (KeyValuePair<int, Character> item in current)
		{
			if (incoming.TryGetValue(item.Key, out var value))
			{
				item.Value.MargeFrom(value);
			}
			else
			{
				list.Add(item.Key);
			}
		}
		if (removeExcess)
		{
			foreach (int item2 in list)
			{
				ReleaseCharacter(sceneStatusIndex, current[item2]);
				current.Remove(item2);
			}
		}
		ListPool<int>.Release(list);
		foreach (KeyValuePair<int, Character> item3 in incoming)
		{
			if (!current.ContainsKey(item3.Key))
			{
				current.Add(item3.Key, item3.Value);
				item3.Value.Refresh();
				item3.Value.SetCharacterTeamInfo(new CharacterIdentify(sceneStatusIndex, isExtraCharacter));
				AddCharacter(sceneStatusIndex, item3.Value);
			}
		}
	}

	public static void AddCharacter(int sceneIndex, Character character)
	{
		CharacterRefresh evt = Singleton<EventManager>.instance.GetEvt<CharacterRefresh>();
		evt.sceneIndex = sceneIndex;
		evt.character = character;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_Add, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public static void ReleaseCharacter(int sceneIndex, Character character)
	{
		CharacterRefresh evt = Singleton<EventManager>.instance.GetEvt<CharacterRefresh>();
		evt.sceneIndex = sceneIndex;
		evt.character = character;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_Remove, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
