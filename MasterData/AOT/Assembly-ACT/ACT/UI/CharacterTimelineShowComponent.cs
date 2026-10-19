using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CharacterTimelineShowComponent : MonoBehaviour
{
	[SerializeField]
	private CharacterTimelineDisplayElements displayElements;

	[SerializeField]
	private ActButton closeButton;

	public BetterAnimation betterAnimation;

	[SerializeField]
	private GameObject displayRoot;

	[SerializeField]
	private List<GameObject> qualityBgList = new List<GameObject>();

	[SerializeField]
	private List<CharacterOverTagtem> characterTags = new List<CharacterOverTagtem>();

	[SerializeField]
	private GameObject shareButtonRoot;

	private CharacterTimelineShowData _showData;

	private ImageAssetStation _station;

	private Action _stopTimeline;

	private Action _closeView;

	private bool _isClosing;

	public void Init(CharacterTimelineShowData showData, ImageAssetStation station, Action stopTimeline, Action closeView)
	{
		_showData = showData;
		_station = station;
		_stopTimeline = stopTimeline;
		_closeView = closeView;
		_isClosing = false;
		closeButton.gameObject.SetActive(value: false);
		closeButton.SetBtnClick(OnCloseClick);
		shareButtonRoot?.SetActive(value: false);
		displayRoot.SetActive(value: false);
		gameObject.SetActive(value: false);
	}

	public void Show()
	{
		Show(_showData);
	}

	public void Show(CharacterTimelineShowData showData)
	{
		_showData = showData;
		_isClosing = false;
		if (_showData == null || _station == null)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(_showData.CharacterItemId, RuntimeConfigs.data.itemDatas);
		if (data == null || data.canBeTransited == null || data.canBeTransited.Count == 0)
		{
			Debug.LogError($"CharacterTimelineShowComponent: invalid character item id {_showData.CharacterItemId}.");
			_closeView?.Invoke();
			return;
		}
		int id = data.canBeTransited[0].id;
		EntityCharacterData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
		if (data2 == null)
		{
			Debug.LogError($"CharacterTimelineShowComponent: character data not found, id={id}.");
			_closeView?.Invoke();
		}
		else
		{
			RefreshCharacter(data, data2, id);
			PlayShowAnimation(data.quality);
		}
	}

	private void RefreshCharacter(ItemData itemData, EntityCharacterData characterData, int characterId)
	{
		gameObject.SetActive(value: true);
		displayRoot.SetActive(value: true);
		displayElements.CharacterRoot?.SetActive(value: true);
		displayElements.ItemRoot?.SetActive(value: false);
		displayElements.goNew?.SetActive(_showData.IsNew);
		displayElements.textName.StringReference.TableEntryReference = itemData.nameLocal;
		displayElements.imageProfession?.UpdateDisPlay(characterId);
		displayElements.MannerItem?.Init(_station, characterData.mannerType);
		_station.LoadImage(160, characterData.characterNameEng, displayElements.imageName);
		_station.LoadImage(113, characterData.characterArt, displayElements.characterImage);
		RefreshCharacterTags(characterData.characterTagGroup);
		RefreshQuality(itemData.quality);
		RefreshExtraItems(characterData);
	}

	private void PlayShowAnimation(int quality)
	{
		if (quality == 5)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Gold", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Gold", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			closeButton.gameObject.SetActive(value: true);
		}).Play();
	}

	public void OnCloseClick()
	{
		_closeView?.Invoke();
	}

	public void Close()
	{
		if (!_isClosing)
		{
			_isClosing = true;
			closeButton.gameObject.SetActive(value: false);
			_stopTimeline?.Invoke();
		}
	}

	private void RefreshCharacterTags(int[] tagGroup)
	{
		for (int i = 0; i < characterTags.Count; i++)
		{
			bool flag = tagGroup != null && i < tagGroup.Length;
			characterTags[i].gameObject.SetActive(flag);
			if (flag)
			{
				characterTags[i].Init(tagGroup[i]);
			}
		}
	}

	private void RefreshQuality(int quality)
	{
		int num = ((quality > 3) ? ((quality == 4) ? 1 : 2) : 0);
		for (int i = 0; i < displayElements.CharacterQualityList.Count; i++)
		{
			displayElements.CharacterQualityList[i]?.SetActive(i == num);
		}
		for (int j = 0; j < qualityBgList.Count; j++)
		{
			qualityBgList[j]?.SetActive(j == num);
		}
	}

	private void RefreshExtraItems(EntityCharacterData characterData)
	{
		List<Item> list = new List<Item>();
		if (!_showData.IsNew)
		{
			list.Add(new Item
			{
				Id = characterData.ConstellationItem,
				Count = 1
			});
		}
		for (int i = 0; i < displayElements.extraItems.Count; i++)
		{
			AcquireCharacterShowExtraItem acquireCharacterShowExtraItem = displayElements.extraItems[i];
			bool flag = i < list.Count;
			if (flag)
			{
				acquireCharacterShowExtraItem.Init(list[i], _station);
			}
			acquireCharacterShowExtraItem.gameObject.SetActive(flag);
		}
	}
}
