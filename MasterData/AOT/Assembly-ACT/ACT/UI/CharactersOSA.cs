using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CharactersOSA : OSA<CharactersParams, CharactersViewsHolder>
{
	[SerializeField]
	private RectTransform buttonPromptNext;

	[SerializeField]
	private RectTransform buttonPromptPrev;

	[SerializeField]
	private float buttonPromptNextOffset = 10f;

	private Vector2 _buttonPromptNextOriginalPos;

	private bool _buttonPromptNextOriginalPosCached;

	private ImageAssetStation _station;

	private Action<ICharacterSource> _onSelectCharacter;

	private SimpleDataHelper<CharactersModel> _data;

	private int _selectIndex;

	private SceneStatus _openSceneStatus;

	private void OnValidate()
	{
		_InternalState?.CacheScrollViewInfo();
	}

	public void Reload(ImageAssetStation station, List<Character> characters, Character selectedCharacter, Action<ICharacterSource> onSelectCharacter, SceneStatus openSceneStatus = SceneStatus.Main)
	{
		_station = station;
		_onSelectCharacter = onSelectCharacter;
		_openSceneStatus = openSceneStatus;
		_selectIndex = 0;
		CharactersModel[] array = new CharactersModel[characters.Count];
		for (int i = 0; i < characters.Count; i++)
		{
			bool flag = characters[i] == selectedCharacter;
			array[i] = new CharactersModel(characters[i], flag);
			if (flag)
			{
				_selectIndex = i;
			}
		}
		_data = new SimpleDataHelper<CharactersModel>(this);
		if (!IsInitialized)
		{
			Init();
		}
		_data.ResetItems(array);
		if (array.Length != 0)
		{
			ScrollTo(_selectIndex, 0.5f, 0.5f);
		}
		UpdateButtonPromptNextPosition();
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze()
	{
		gameObject.SetActive(value: true);
	}

	public void Unload()
	{
		if (IsInitialized)
		{
			Clear();
		}
	}

	protected override CharactersViewsHolder CreateViewsHolder(int itemIndex)
	{
		CharactersViewsHolder charactersViewsHolder = new CharactersViewsHolder();
		charactersViewsHolder.Init(_Params.ItemPrefab, _Params.Content, itemIndex);
		charactersViewsHolder.BindClickAction(OnSelectCharacter);
		return charactersViewsHolder;
	}

	protected override void UpdateViewsHolder(CharactersViewsHolder newOrRecycled)
	{
		CharactersModel model = _data[newOrRecycled.ItemIndex];
		newOrRecycled.UpdateView(model, _station, _openSceneStatus);
	}

	private void OnSelectCharacter(CharactersViewsHolder vh)
	{
		if (_selectIndex != vh.ItemIndex)
		{
			_data[_selectIndex].UpdateSelect(isSelect: false);
			GetItemViewsHolderIfVisible(_selectIndex)?.OnSelectSwitch(isSelect: false);
			_data[vh.ItemIndex].UpdateSelect(isSelect: true);
			vh.OnSelectSwitch(isSelect: true);
			_selectIndex = vh.ItemIndex;
			_onSelectCharacter(_data[vh.ItemIndex].Character);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Chose", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
	}

	public void RefreshIcon()
	{
		if (IsInitialized && _data != null)
		{
			for (int i = 0; i < _data.Count; i++)
			{
				GetItemViewsHolderIfVisible(i)?.RefreshIcon();
			}
		}
	}

	public void ChangeSelectCharacter(int newIndex)
	{
		if (IsInitialized && _data != null && newIndex >= 0 && newIndex < _data.Count)
		{
			_data[_selectIndex].UpdateSelect(isSelect: false);
			GetItemViewsHolderIfVisible(_selectIndex)?.OnSelectSwitch(isSelect: false);
			_data[newIndex].UpdateSelect(isSelect: true);
			GetItemViewsHolderIfVisible(newIndex)?.OnSelectSwitch(isSelect: true);
			_selectIndex = newIndex;
			if (isActiveAndEnabled)
			{
				SmoothScrollTo(newIndex, 0.5f, 0.5f, 0.5f);
			}
		}
	}

	private void UpdateButtonPromptNextPosition()
	{
		if (!(buttonPromptNext == null))
		{
			if (!_buttonPromptNextOriginalPosCached)
			{
				_buttonPromptNextOriginalPos = buttonPromptNext.anchoredPosition;
				_buttonPromptNextOriginalPosCached = true;
			}
			StartCoroutine(CoUpdateButtonPromptNextPosition());
		}
	}

	private IEnumerator CoUpdateButtonPromptNextPosition()
	{
		yield return null;
		if (!IsInitialized || _data == null || _data.Count == 0)
		{
			yield break;
		}
		float num = (float)GetContentSize();
		float num2 = (float)GetViewportSize();
		if (num >= num2)
		{
			buttonPromptNext.anchoredPosition = _buttonPromptNextOriginalPos;
			yield break;
		}
		RectTransform rectTransform = buttonPromptNext.parent as RectTransform;
		if (!(rectTransform == null))
		{
			RectTransform viewport = _Params.Viewport;
			Vector3 position = new Vector3(0f, viewport.rect.yMax - num, 0f);
			Vector3 position2 = viewport.TransformPoint(position);
			Vector3 vector = rectTransform.InverseTransformPoint(position2);
			float num3 = buttonPromptNext.anchoredPosition.y - buttonPromptNext.localPosition.y;
			buttonPromptPrev.anchoredPosition = new Vector2(buttonPromptNext.anchoredPosition.x, buttonPromptPrev.anchoredPosition.y);
			buttonPromptNext.anchoredPosition = new Vector2(buttonPromptNext.anchoredPosition.x, vector.y + num3 - buttonPromptNextOffset);
		}
	}
}
