using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class CharacterPresentationItem : MonoBehaviour
{
	public List<GameObject> QuaList = new List<GameObject>();

	public BImage CharacterIcon;

	public ActButton BtnClcik;

	public GameObject GoItem;

	public GameObject BtnAdd;

	public LocalizeStringEvent TextName;

	public GameObject GoSelect;

	private int _index;

	private int _characterId;

	private Action<int> _onClick;

	public int Index => _index;

	public int CharacterId => _characterId;

	public bool HasCharacter => _characterId > 0;

	public void Init(int index, Action<int> onClick)
	{
		_index = index;
		_onClick = onClick;
		BindClick(BtnClcik);
	}

	public void SetCharacter(int characterId, ImageAssetStation station)
	{
		_characterId = characterId;
		if (GoItem != null)
		{
			GoItem.SetActive(value: true);
		}
		if (BtnAdd != null)
		{
			BtnAdd.SetActive(value: false);
		}
		int id = CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(characterId);
		station?.LoadImage(103, id, CharacterIcon);
		EntityData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		if (data != null && TextName != null)
		{
			TextName.StringReference.TableEntryReference = data.nameLocal;
			TextName.RefreshString();
		}
		RefreshQuality(characterId);
		SetSelected(selected: false);
	}

	public void SetEmpty()
	{
		_characterId = 0;
		if (GoItem != null)
		{
			GoItem.SetActive(value: false);
		}
		if (BtnAdd != null)
		{
			BtnAdd.SetActive(value: true);
		}
		SetSelected(selected: false);
	}

	public void SetSelected(bool selected)
	{
		if (GoSelect != null)
		{
			GoSelect.SetActive(selected);
		}
	}

	private void RefreshQuality(int characterId)
	{
		if (QuaList == null)
		{
			return;
		}
		int bagCharacterQuality = GameUtility.GetBagCharacterQuality(characterId);
		for (int i = 0; i < QuaList.Count; i++)
		{
			if (QuaList[i] != null)
			{
				QuaList[i].SetActive(i == bagCharacterQuality - 1);
			}
		}
	}

	private void BindClick(ActButton go)
	{
		go.SetBtnClick(() =>
		{
			_onClick?.Invoke(_index);
		});
	}
}
