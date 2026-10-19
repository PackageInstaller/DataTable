using System;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;

namespace ACT.UI;

public class CharactersViewsHolder : BaseItemViewsHolder
{
	private CharacterHead _head;

	private bool _isFirst = true;

	private float _posX;

	public void SetPosX(float posX)
	{
		_posX = posX;
	}

	public override void CollectViews()
	{
		_head = root.GetComponent<CharacterHead>();
	}

	public void UpdateView(CharactersModel model, ImageAssetStation assetStation, SceneStatus openSceneStatus = SceneStatus.Main)
	{
		root.gameObject.SetActive(value: true);
		_head.ActiveTrial(model.Character.IsTrailCharacter);
		_head.Init(model.Character, assetStation, model.IsSelect, openSceneStatus);
	}

	public void RefreshIcon()
	{
		_head.RefreshIcon();
	}

	public void OnSelectSwitch(bool isSelect)
	{
		_head.OnIsNewRedClick();
		_head.RefreshSelectState(isSelect);
	}

	public void BindClickAction(Action<CharactersViewsHolder> action)
	{
		_head.btn.OnClick.RemoveAllListeners();
		_head.btn.OnClick.AddListener(() =>
		{
			action(this);
		});
	}
}
