using System.Collections.Generic;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace UI;

public class CharacterSideInfoComp : MonoBehaviour
{
	[SerializeReference]
	private GameObject sideInfoPrefab;

	private Dictionary<int, CharacterSideInfo> _infos;

	public void Init()
	{
		_infos = new Dictionary<int, CharacterSideInfo>();
		AddEventListener();
	}

	public void UnInit()
	{
		RemoveEventListener();
		DestroyAllInfo();
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CreateOperateBtnGroup, OnCreateCharacterSideInfo);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Character_HpChange, OnCharacterHpChange);
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CreateOperateBtnGroup, OnCreateCharacterSideInfo);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Character_HpChange, OnCharacterHpChange);
	}

	private void OnCreateCharacterSideInfo(BaseEventContent eventContent)
	{
		if (eventContent is CreateOperateBtnGroupEvt createOperateBtnGroupEvt && createOperateBtnGroupEvt.characterEntity.IsCharacter())
		{
			CreateSideInfo(createOperateBtnGroupEvt.characterEntity);
		}
	}

	private void CreateSideInfo(Entity entity)
	{
		int key = entity.GetCompCharacter().characterSource.Id();
		if (!_infos.ContainsKey(key))
		{
			CharacterSideInfo component = Object.Instantiate(sideInfoPrefab, transform).GetComponent<CharacterSideInfo>();
			_infos.Add(key, component);
			component.Init(entity);
		}
	}

	private void DestroyInfo(int characterId)
	{
		if (_infos.TryGetValue(characterId, out var value))
		{
			value.UnInit();
			_infos.Remove(characterId);
		}
	}

	private void DestroyAllInfo()
	{
		foreach (var (characterId, _) in _infos)
		{
			DestroyInfo(characterId);
		}
		_infos.Clear();
		_infos = null;
	}

	private void OnCharacterHpChange(BaseEventContent eventContent)
	{
		if (eventContent is CharacterHpChangeEvt characterHpChangeEvt && _infos.TryGetValue(characterHpChangeEvt.characterId, out var value))
		{
			value.OnCharacterHpChange(characterHpChangeEvt);
		}
	}
}
