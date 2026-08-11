using UnityEngine;

namespace Ase;

public class GameSettingItem : UGuiView
{
	[SerializeField]
	public string Key;

	protected GameSettingItemViewModel _viewModel;

	private float blockAlpha = 0.5f;

	public virtual void Init(GameSettingItemViewModel viewModel)
	{
		_viewModel = viewModel;
		UpdateCanvasAlpha();
	}

	public void SetBlockAlpha(float alpha)
	{
		blockAlpha = alpha;
		UpdateCanvasAlpha();
	}

	private void UpdateCanvasAlpha()
	{
		if (!((Object)(object)CanvasGroup == null) && _viewModel != null)
		{
			if (_viewModel.InBattle && _viewModel.BlockInBattle)
			{
				CanvasGroup.alpha = blockAlpha;
				CanvasGroup.blocksRaycasts = false;
			}
			else
			{
				CanvasGroup.alpha = 1f;
				CanvasGroup.blocksRaycasts = true;
			}
		}
	}
}
