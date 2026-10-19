using System;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Obsolete]
public class CharacterHeadSculpture : LoopScrollBaseItem
{
	[SerializeReference]
	private BImage headSculpture;

	[SerializeReference]
	private ActButton btn;

	[SerializeReference]
	private BetterAnimation animation;

	private CharacterSelectScrollRect _scrollRect;

	private ImageAssetStation _imageAssetStation;

	private int _characterId;

	private Action<int> _onClick;

	public void Register(CharacterSelectScrollRect scrollRect, ImageAssetStation imageAssetStation, Action<int> onClick)
	{
		_scrollRect = scrollRect;
		_imageAssetStation = imageAssetStation;
		_onClick = onClick;
	}

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		_characterId = _scrollRect.GetCharacterId(idx);
		_imageAssetStation.LoadImage(103, _characterId, headSculpture);
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			_onClick?.Invoke(_characterId);
		});
		animation.GetSequence((_characterId == _scrollRect.SelectedCharacterId) ? "SelectedShow" : "NormalShow").Play();
	}

	public void ToSelect()
	{
		animation.GetSequence("Select").Play();
	}

	public void ToNormal()
	{
		animation.GetSequence("NormalExchange").Play();
	}
}
