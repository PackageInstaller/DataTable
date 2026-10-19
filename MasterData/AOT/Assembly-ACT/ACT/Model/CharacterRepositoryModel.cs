using System.Collections.Generic;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;

namespace ACT.Model;

public class CharacterRepositoryModel : Model<CharacterRepositoryModel>
{
	private Dictionary<int, CharacterRepository> _addCharacterRepositories = new Dictionary<int, CharacterRepository>();

	private Dictionary<int, CharacterRepository> _removeCharacterRepositories = new Dictionary<int, CharacterRepository>();

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, OnAfterLeaveWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, OnBeforeEneterWorld);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, OnAfterLeaveWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, OnBeforeEneterWorld);
	}

	public void RemoveCharacterRepository(int sceneStatusIndex)
	{
		G.localPlayer.teamInfo.CharacterRepository.Remove(sceneStatusIndex);
		_removeCharacterRepositories.Remove(sceneStatusIndex);
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(sceneStatusIndex);
		if (characterRepository.Characters.Count > 0 || characterRepository.ExtraCharacters.Count > 0)
		{
			_removeCharacterRepositories.Add(sceneStatusIndex, characterRepository);
		}
	}

	public void AddCharacterRepository(int sceneStatusIndex, CharacterRepository characterRepository)
	{
		G.localPlayer.teamInfo.CharacterRepository[sceneStatusIndex] = characterRepository;
		_addCharacterRepositories.Remove(sceneStatusIndex);
		_addCharacterRepositories.Add(sceneStatusIndex, characterRepository);
	}

	private void OnAfterLeaveWorld(BaseEventContent evt)
	{
		foreach (KeyValuePair<int, CharacterRepository> removeCharacterRepository in _removeCharacterRepositories)
		{
			ReleaseCharacterRepository(removeCharacterRepository.Key, removeCharacterRepository.Value);
		}
		_removeCharacterRepositories.Clear();
	}

	private void OnBeforeEneterWorld(BaseEventContent evt)
	{
		foreach (KeyValuePair<int, CharacterRepository> addCharacterRepository in _addCharacterRepositories)
		{
			SetCharacterRepository(addCharacterRepository.Key, addCharacterRepository.Value);
		}
		_addCharacterRepositories.Clear();
	}

	public static void SetCharacterRepository(int sceneStatusIndex, CharacterRepository characterRepository)
	{
		CharacterDataHelper.MergeCharacterRepository(sceneStatusIndex, characterRepository, removeExcess: true);
		CharacterDependHelper.MergeCharacterDependChange(sceneStatusIndex, characterRepository, removeExcess: true);
		CharacterRepository characterRepository2 = CharacterDataHelper.GetCharacterRepository(sceneStatusIndex);
		foreach (KeyValuePair<int, PotionItem> potion in characterRepository.Potions)
		{
			if (!characterRepository2.Potions.ContainsKey(potion.Key))
			{
				characterRepository2.Potions.Add(potion.Key, potion.Value);
			}
		}
		characterRepository2.TrialPotions.Clear();
		foreach (KeyValuePair<int, PotionItem> trialPotion in characterRepository.TrialPotions)
		{
			characterRepository2.TrialPotions[trialPotion.Key] = trialPotion.Value;
		}
		Model<BloodBottleModel>.Interface.SetWorldPotions(sceneStatusIndex, characterRepository.Potions);
	}

	public static void ReleaseCharacterRepository(int sceneStatusIndex, CharacterRepository repository)
	{
		foreach (KeyValuePair<int, Character> character in repository.Characters)
		{
			CharacterDataHelper.ReleaseCharacter(sceneStatusIndex, character.Value);
		}
		foreach (KeyValuePair<int, Character> extraCharacter in repository.ExtraCharacters)
		{
			CharacterDataHelper.ReleaseCharacter(sceneStatusIndex, extraCharacter.Value);
		}
		repository.Characters.Clear();
		repository.ExtraCharacters.Clear();
		repository.Potions.Clear();
		repository.TrialPotions.Clear();
		repository.CharacterDependSnapshot.EquipSnapshot.Clear();
		repository.CharacterDependSnapshot.GemSnapshot.Clear();
		repository.ExtraCharacterDependSnapshot.EquipSnapshot.Clear();
		repository.ExtraCharacterDependSnapshot.GemSnapshot.Clear();
	}
}
